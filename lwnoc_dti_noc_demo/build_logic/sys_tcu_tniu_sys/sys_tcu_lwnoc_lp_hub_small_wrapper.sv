/*
 * File: lwnoc_lp_hub_small_wrapper.sv
 * Project: lwnoc_lowpower_component
 * File Created: Tuesday, 26th August 2025 5:34:39 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  small hub (terminal =4) wrapper
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:10:41 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_hub_small_wrapper
    import sys_tcu_lwnoc_lp_struct_package::*;
(
    input  lwnoc_lp_req_signal_t v_rx_req [4-1:0],
    output lwnoc_lp_req_signal_t v_tx_req [4-1:0]
);

//===========================================================================
// Uarch
//===========================================================================
// ---------------------------------------------------------------------------
// Two-hub chaining topology (NUM_TERMINAL == 4)
// ASCII diagram showing two hubs connected via their terminal[2],
// while terminal[0] and terminal[1] of each hub are exposed to wrapper I/F.
//
//   External IF (wrapper)                          External IF (wrapper)
//   term[0] (i=0)                                       term[2] (i=2)
//        |                                                    |
//   +-----------------+                               +-----------------+
//   |     HUB[0]      |                               |     HUB[1]      |
//   |  t0  <------>   |<----------------------------->|   <------>  t0  |
//   |  t1  <------>   |                               |   <------>  t1  |
//   |  t2  <------>   |===============================|   <------>  t2  |
//   +-----------------+                               +-----------------+
//        |                                                    |
//   term[1] (i=1)                                       term[3] (i=3)
//
// Mapping (wrapper index -> hub/terminal):
//   i in [0..3]: hub_idx = i/2; port_idx = i%2
//     i=0 -> HUB[0].t0 exposed
//     i=1 -> HUB[0].t1 exposed
//     i=2 -> HUB[1].t0 exposed
//     i=3 -> HUB[1].t1 exposed
//   HUB[0].t2 <==> HUB[1].t2 is used for cascading (internal only).
//
// Notes:
// - Each terminal carries stg1_req, stg2_req, and deny groups (and/or variants).
// - Signals on the cascade link are bi-directionally wired by pairing tx/rx groups.
// ---------------------------------------------------------------------------

//===========================================================================
// Internal logic
//===========================================================================
   lwnoc_lp_req_signal_t v_rx_req_hub [2-1:0][3-1:0];
   lwnoc_lp_req_signal_t v_tx_req_hub [2-1:0][3-1:0];

//===========================================================================
// Two Hub
//===========================================================================
    generate
        for (genvar i=0; i<2; i++) begin : gen_hubs
            lwnoc_lp_hub_3terminal u_hub (
                .v_rx_req(v_rx_req_hub[i]),
                .v_tx_req(v_tx_req_hub[i])
            );
        end
    endgenerate

//===========================================================================
// Terminal allocation
//===========================================================================
    // Connect external interface to hub terminals
    // HUB[0]: t0, t1 exposed; t2 cascaded
    assign v_rx_req_hub[0][0] = v_rx_req[0];
    assign v_rx_req_hub[0][1] = v_rx_req[1];
    assign v_tx_req[0]        = v_tx_req_hub[0][0];
    assign v_tx_req[1]        = v_tx_req_hub[0][1];

    // HUB[1]: t0, t1 exposed; t2 cascaded
    assign v_rx_req_hub[1][0] = v_rx_req[2];
    assign v_rx_req_hub[1][1] = v_rx_req[3];
    assign v_tx_req[2]        = v_tx_req_hub[1][0];
    assign v_tx_req[3]        = v_tx_req_hub[1][1];

    // Cascade connection between HUB[0].t2 <-> HUB[1].t2
    assign v_rx_req_hub[0][2] = v_tx_req_hub[1][2];
    assign v_rx_req_hub[1][2] = v_tx_req_hub[0][2];


endmodule

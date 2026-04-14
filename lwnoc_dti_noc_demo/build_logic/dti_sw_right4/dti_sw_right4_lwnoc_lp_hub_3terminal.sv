/*
 * File: lwnoc_lp_hub_3terminal.sv
 * Project: lwnoc_lowpower_component
 * File Created: Monday, 25th August 2025 11:16:05 pm
 * Author: Zou Zhili
 * -----
 * Description:
 *  Low-power hub module for three terminals.
 *  Each terminal exchanges stage1, stage2, and deny signals with the other two.
 *  The hub instantiates three subhubs, one per terminal, to aggregate and route
 *  requests and denials between terminals for low-power network-on-chip operation.
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:09:12 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_hub_3terminal
    import dti_sw_right4_lwnoc_lp_struct_package::*;
(

    input  lwnoc_lp_req_signal_t v_rx_req [3-1:0],
    output lwnoc_lp_req_signal_t v_tx_req [3-1:0]
);

//===========================================================================
// Internal signals
//===========================================================================
    // 3 Terminals, each receive other two's tx req, so called peer
    lwnoc_lp_req_signal_t vv_tx_req_peer [3-1:0][2-1:0];

//===========================================================================
// Peer Wiring
//===========================================================================
    generate
        for (genvar i = 0; i < 3; i++) begin : GEN_TERMINAL
            for (genvar j = 0; j < 2; j++) begin: GEN_PEER
                // For each terminal i, peer signals are from the other two terminals (not i)
                assign vv_tx_req_peer[i][j] = v_rx_req[(i + j + 1) % 3];
            end
        end
    endgenerate

//===========================================================================
// Subhub for each terminal
//===========================================================================
    generate
        for (genvar i=0; i<3; i++) begin
            lwnoc_lp_subhub  u_subhub (
                .v_rx_req  (vv_tx_req_peer[i]),
                .tx_req    (v_tx_req[i]      )
            );
        end
    endgenerate

endmodule

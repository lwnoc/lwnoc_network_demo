/*
 * File: lwnoc_lp_subhub.sv
 * Project: lwnoc_lowpower_component
 * File Created: Monday, 25th August 2025 11:22:33 pm
 * Author: Zou Zhili
 * -----
 * Description:
 *  Subhub module for low-power hub with three terminals.
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:12:03 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_subhub
    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
(
    input  lwnoc_lp_req_signal_t v_rx_req [2-1:0],
    output lwnoc_lp_req_signal_t tx_req
);

//===========================================================================
// Internal signals
//===========================================================================

//===========================================================================
// STG1_REQ BOX
//===========================================================================
assign tx_req.stg1_req_or  = v_rx_req[0].stg1_req_or  | v_rx_req[1].stg1_req_or;
assign tx_req.stg1_req_and = v_rx_req[0].stg1_req_and & v_rx_req[1].stg1_req_and;

//===========================================================================
// STG2_REQ BOX
//===========================================================================
assign tx_req.stg2_req_or  = v_rx_req[0].stg2_req_or  | v_rx_req[1].stg2_req_or;
assign tx_req.stg2_req_and = v_rx_req[0].stg2_req_and & v_rx_req[1].stg2_req_and;

//===========================================================================
// DENY BOX
//===========================================================================
assign tx_req.deny_and = v_rx_req[0].deny_and & v_rx_req[1].deny_and;
assign tx_req.deny_or  = v_rx_req[0].deny_or  | v_rx_req[1].deny_or;

//===========================================================================
// State Box
//===========================================================================
assign tx_req.state = lwnoc_lp_state_t'(v_rx_req[0].state | v_rx_req[1].state);
endmodule

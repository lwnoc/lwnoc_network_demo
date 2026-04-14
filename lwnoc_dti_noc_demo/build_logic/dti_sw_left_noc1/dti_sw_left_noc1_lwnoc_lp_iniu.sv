/*
 * File: lwnoc_lp_iniu.sv
 * Project: allude
 * File Created: Wednesday, 27th August 2025 1:19:31 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  LP iniu as a initiator, kick off a lowpower operation required by pchannel
 * -----
 * Last Modified: Wednesday, 3rd September 2025 7:17:38 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_iniu
    import dti_sw_left_noc1_lwnoc_lp_struct_package::*;
    import dti_sw_left_noc1_lwnoc_lp_define_package::*;
(
    input  logic                   clk,
    input  logic                   rst_n,
    input  lwnoc_lp_req_signal_t   rx_req,
    output lwnoc_lp_req_signal_t   tx_req,
    // P channel from rsc
    input  logic                   preq,
    input  lwnoc_pchannel_state_t  pstate,
    output lwnoc_pchannel_active_t pactive,
    output logic                   paccept,
    output logic                   pdeny
);
    //===========================================================================
    // Internal logic
    //===========================================================================
    // lp fsm
    logic            internal_tx_stg1_req;
    logic            internal_rx_stg1_req;
    lwnoc_lp_state_t internal_tx_state;
    lwnoc_lp_state_t internal_rx_state;
    logic            internal_tx_stg1_deny;
    logic            internal_rx_stg1_deny;
    logic            internal_tx_stg2_req;
    logic            internal_rx_stg2_req;

    //===========================================================================
    // NIU FSM
    //===========================================================================
    lwnoc_lp_niu_fsm u_niu_fsm (
        .clk                  (clk),
        .rst_n                (rst_n),
        .rx_req               (rx_req),
        .tx_req               (tx_req),
        .internal_tx_stg1_req (internal_tx_stg1_req),
        .internal_rx_stg1_req (internal_rx_stg1_req),
        .internal_tx_state    (internal_tx_state),
        .internal_rx_state    (internal_rx_state),
        .internal_tx_stg1_deny(internal_tx_stg1_deny),
        .internal_rx_stg1_deny(internal_rx_stg1_deny),
        .internal_tx_stg2_req (internal_tx_stg2_req),
        .internal_rx_stg2_req (internal_rx_stg2_req)
    );

    //===========================================================================
    // Pchannel NIU
    //===========================================================================
    lwnoc_lp_pchn_niu u_pchn_fsm (
        .clk         (clk),
        .rst_n       (rst_n),
        .preq        (preq),
        .pstate      (pstate),
        .pactive     (pactive),
        .paccept     (paccept),
        .pdeny       (pdeny),
        .tx_stg1_req (internal_rx_stg1_req),
        .rx_stg1_req (internal_tx_stg1_req),
        .tx_state    (internal_rx_state),
        .rx_state    (internal_tx_state),
        .tx_stg1_deny(internal_rx_stg1_deny),
        .rx_stg1_deny(internal_tx_stg1_deny),
        .tx_stg2_req (internal_rx_stg2_req),
        .rx_stg2_req (internal_tx_stg2_req)
    );


endmodule

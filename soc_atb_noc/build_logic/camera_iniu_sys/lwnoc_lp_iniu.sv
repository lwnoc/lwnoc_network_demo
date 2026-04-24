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
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
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
    // device-side NIU / pchannel interface
    logic            device_rx_stg1_req;
    logic            device_tx_stg1_req;
    lwnoc_lp_state_t device_rx_state;
    lwnoc_lp_state_t device_tx_state;
    logic            device_rx_stg1_dack;
    logic            device_tx_stg1_dack;
    logic            device_rx_stg2_req;
    logic            device_tx_stg2_req;
    logic            stg1_run_done;
    logic            stg1_stop_done;
    logic            stg2_run_done;
    logic            stg2_stop_done;

    //===========================================================================
    // NIU FSM
    //===========================================================================
    lwnoc_lp_niu_fsm u_niu_fsm (
        .clk                  (clk),
        .rst_n                (rst_n),
        .rx_req               (rx_req),
        .tx_req               (tx_req),
        .device_rx_stg1_req   (device_rx_stg1_req),
        .device_tx_stg1_req   (device_tx_stg1_req),
        .device_rx_state      (device_rx_state),
        .device_tx_state      (device_tx_state),
        .device_rx_stg1_dack  (device_rx_stg1_dack),
        .device_tx_stg1_dack  (device_tx_stg1_dack),
        .device_rx_stg2_req   (device_rx_stg2_req),
        .device_tx_stg2_req   (device_tx_stg2_req),
        .stg1_run_done       (stg1_run_done),
        .stg1_stop_done      (stg1_stop_done),
        .stg2_run_done       (stg2_run_done),
        .stg2_stop_done      (stg2_stop_done)
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
        .tx_stg1_req (device_tx_stg1_req),
        .rx_stg1_req (device_rx_stg1_req),
        .tx_state    (device_tx_state),
        .rx_state    (device_rx_state),
        .tx_stg1_dack(device_tx_stg1_dack),
        .rx_stg1_dack(device_rx_stg1_dack),
        .tx_stg2_req (device_tx_stg2_req),
        .rx_stg2_req (device_rx_stg2_req),
        .stg1_run_done(stg1_run_done),
        .stg1_stop_done(stg1_stop_done),
        .stg2_run_done(stg2_run_done),
        .stg2_stop_done(stg2_stop_done)
    );


endmodule

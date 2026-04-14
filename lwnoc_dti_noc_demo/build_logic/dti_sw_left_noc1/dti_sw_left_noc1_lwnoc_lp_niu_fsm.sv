/*
 * File: lwnoc_lp_niu_fsm.sv
 * Project: lwnoc_lowpower_component
 * File Created: Monday, 1st September 2025 1:56:02 am
 * Author: Zou Zhili
 * -----
 * Description:
    This module implements the finite state machine (FSM) for the low-power
    Network Interface Unit (NIU) in the LWNOC (Low-power Network-on-Chip)
    component.
    This module controls req/deny seen by niu, reduce req and/or into only one req depending on fsm
 *
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:01:18 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_niu_fsm
    import dti_sw_left_noc1_lwnoc_lp_struct_package::*;
    import dti_sw_left_noc1_lwnoc_lp_define_package::*;
(
    input  logic                 clk,
    input  logic                 rst_n,
    input  lwnoc_lp_req_signal_t rx_req,
    output lwnoc_lp_req_signal_t tx_req,
    // adapter side
    output logic                 internal_tx_stg1_req,
    input  logic                 internal_rx_stg1_req,
    output lwnoc_lp_state_t      internal_tx_state,
    input  lwnoc_lp_state_t      internal_rx_state,
    output logic                 internal_tx_stg1_deny,
    input  logic                 internal_rx_stg1_deny,
    output logic                 internal_tx_stg2_req,
    input  logic                 internal_rx_stg2_req
);

    //===========================================================================
    // Internal Parameter
    //===========================================================================
    localparam integer unsigned LP_REQ_PLD_WIDTH = $bits(lwnoc_lp_req_signal_t);

    //===========================================================================
    // Internal logic
    //===========================================================================
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_sync_cell_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_sync_cell_out;
    lwnoc_lp_req_signal_t                        rx_req_sync;
    lwnoc_lp_req_signal_t                        tx_req_cdc;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_cdc_buf_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_cdc_buf_out;

    lwnoc_lp_req_signal_t                        tx_req_stg1_fsm;
    lwnoc_lp_req_signal_t                        tx_req_stg2_fsm;
    lwnoc_lp_req_signal_t                        rx_req_stg1_fsm;
    lwnoc_lp_req_signal_t                        rx_req_stg2_fsm;
    logic                                        master_mode;
    //===========================================================================
    // Sync cell
    //===========================================================================
    assign rx_req_sync_cell_in = rx_req;

    fcip_sync_cell #(
        .DATA_WIDTH(LP_REQ_PLD_WIDTH),
        .SYN_STAGE (3)
    ) u_rx_req_sync_cell (
        .clk  (clk),
        .rst_n(rst_n),
        .d    (rx_req_sync_cell_in),
        .q    (rx_req_sync_cell_out)
    );

    assign rx_req_sync       = lwnoc_lp_req_signal_t'(rx_req_sync_cell_out);

    //===========================================================================
    // TX CDC marker
    //===========================================================================
    assign tx_req_cdc_buf_in = tx_req_cdc;

    fcip_marker #(
        .DATA_WIDTH(LP_REQ_PLD_WIDTH)
    ) u_lp_tx_cdc_marker (
        .I(tx_req_cdc_buf_in),
        .Z(tx_req_cdc_buf_out)
    );
    assign tx_req = lwnoc_lp_req_signal_t'(tx_req_cdc_buf_out);

    //===========================================================================
    // STG1 FSM
    //===========================================================================
    lwnoc_lp_stg1_fsm u_stg1_fsm (
        .clk                   (clk),
        .rst_n                 (rst_n),
        .rx_req                (rx_req_stg1_fsm),
        .tx_req                (tx_req_stg1_fsm),
        .internal_tx_stg1_req  (internal_tx_stg1_req),
        .internal_tx_stg1_state(internal_tx_state),
        .internal_tx_stg1_deny (internal_tx_stg1_deny),
        .internal_rx_stg1_req  (internal_rx_stg1_req),
        .internal_rx_stg1_state(internal_rx_state),
        .internal_rx_stg1_deny (internal_rx_stg1_deny),
        .master_mode          (master_mode)
    );

    //===========================================================================
    // STG2 FSM
    //===========================================================================
    lwnoc_lp_stg2_fsm u_stg2_fsm (
        .clk                 (clk),
        .rst_n               (rst_n),
        .rx_req              (rx_req_stg2_fsm),
        .stg2_tx_req         (tx_req_stg2_fsm),
        .stg1_tx_req         (tx_req_stg1_fsm),
        .internal_tx_stg2_req(internal_tx_stg2_req),
        .internal_rx_stg2_req(internal_rx_stg2_req),
        .master_mode        (master_mode)
    );

    //===========================================================================
    // Fanout lp network rx signal to stg1/2 fsm
    //===========================================================================
    assign rx_req_stg1_fsm = rx_req_sync;
    assign rx_req_stg2_fsm = rx_req_sync;

    //===========================================================================
    // Assemble lp network tx signal
    //===========================================================================
    assign tx_req_cdc = lwnoc_lp_req_signal_t'{
            stg1_req_or : tx_req_stg1_fsm.stg1_req_or,
            stg1_req_and: tx_req_stg1_fsm.stg1_req_and,
            state       : tx_req_stg1_fsm.state,
            deny_and    : tx_req_stg1_fsm.deny_and,
            deny_or     : tx_req_stg1_fsm.deny_or,
            stg2_req_or : tx_req_stg2_fsm.stg2_req_or,
            stg2_req_and: tx_req_stg2_fsm.stg2_req_and,
            default: 'd0
        };

endmodule

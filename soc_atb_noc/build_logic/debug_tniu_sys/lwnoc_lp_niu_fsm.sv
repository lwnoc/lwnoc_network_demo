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
    This module controls req/ack/stg1_dack seen by niu, reduce req and/or into only one req depending on fsm
 *
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:01:18 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_niu_fsm
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
(
    input  logic                 clk,
    input  logic                 rst_n,
    input  lwnoc_lp_req_signal_t rx_req,
    output lwnoc_lp_req_signal_t tx_req,
    // device side
    output logic                 device_rx_stg1_req,
    input  logic                 device_tx_stg1_req,
    output lwnoc_lp_state_t      device_rx_state,
    input  lwnoc_lp_state_t      device_tx_state,
    output logic                 device_rx_stg1_dack,
    input  logic                 device_tx_stg1_dack,
    output logic                 device_rx_stg2_req,
    input  logic                 device_tx_stg2_req,
    output logic                 stg1_run_done,
    output logic                 stg1_stop_done,
    output logic                 stg2_run_done,
    output logic                 stg2_stop_done
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
        .device_rx_stg1_req    (device_rx_stg1_req),
        .device_rx_state       (device_rx_state),
        .device_rx_stg1_dack   (device_rx_stg1_dack),
        .device_tx_stg1_req    (device_tx_stg1_req),
        .device_tx_state       (device_tx_state),
        .device_tx_stg1_dack   (device_tx_stg1_dack),
        .master_mode           (master_mode)
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
        .device_rx_stg2_req  (device_rx_stg2_req),
        .device_tx_stg2_req  (device_tx_stg2_req),
        .master_mode         (master_mode)
    );

    //===========================================================================
    // Fanout lp network rx signal to stg1/2 fsm
    //===========================================================================
    assign rx_req_stg1_fsm = rx_req_sync;
    assign rx_req_stg2_fsm = rx_req_sync;

    //===========================================================================
    // Global stage completion observation for local device-side consumers
    //===========================================================================
    assign stg1_run_done  = tx_req_stg1_fsm.stg1_ack_and  && rx_req_sync.stg1_ack_and &&
                            (~tx_req_stg1_fsm.stg1_dack_or) && (~rx_req_sync.stg1_dack_or);
    assign stg1_stop_done = (~tx_req_stg1_fsm.stg1_ack_or) && (~rx_req_sync.stg1_ack_or);
    assign stg2_run_done  = tx_req_stg2_fsm.stg2_ack_and && rx_req_sync.stg2_ack_and;
    assign stg2_stop_done = (~tx_req_stg2_fsm.stg2_ack_or) && (~rx_req_sync.stg2_ack_or);

    //===========================================================================
    // Assemble lp network tx signal
    //===========================================================================
    assign tx_req_cdc = lwnoc_lp_req_signal_t'{
            stg1_req_or : tx_req_stg1_fsm.stg1_req_or,
            stg1_req_and: tx_req_stg1_fsm.stg1_req_and,
            stg1_ack_or : tx_req_stg1_fsm.stg1_ack_or,
            stg1_ack_and: tx_req_stg1_fsm.stg1_ack_and,
            state       : tx_req_stg1_fsm.state,
            stg1_dack_and: tx_req_stg1_fsm.stg1_dack_and,
            stg1_dack_or : tx_req_stg1_fsm.stg1_dack_or,
            stg2_req_or : tx_req_stg2_fsm.stg2_req_or,
            stg2_req_and: tx_req_stg2_fsm.stg2_req_and,
            stg2_ack_or : tx_req_stg2_fsm.stg2_ack_or,
            stg2_ack_and: tx_req_stg2_fsm.stg2_ack_and,
            default: 'd0
        };

endmodule

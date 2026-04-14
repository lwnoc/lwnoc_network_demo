/*
 * File: lwnoc_lp_slv_wrapper.sv
 * Project: lwnoc_lowpower_component
 * File Created: Wednesday, 3rd September 2025 3:01:46 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  combine fsm and slv adapter to gather
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:06:48 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_slv_wrapper
    import dti_sw_left_dsp0_lwnoc_lp_struct_package::*;
    import dti_sw_left_dsp0_lwnoc_lp_define_package::*;
#(
    parameter integer unsigned HAS_TIME_OUT   = 1,
    parameter integer unsigned TIME_OUT_WIDTH = 10
) (
    input  logic                                      clk,
    input  logic                                      rst_n,
    // config val
    input  logic                 [TIME_OUT_WIDTH-1:0] timeout_val,
    // lp noc
    input  lwnoc_lp_req_signal_t                      rx_req,
    output lwnoc_lp_req_signal_t                      tx_req,
    // mst/slv side
    output logic                                      mst_stg1_req,
    input  logic                                      mst_stg1_ack,
    output lwnoc_lp_slv_cmd_t                         mst_cmd,
    output logic                                      mst_stg2_req,
    input  logic                                      mst_stg2_ack
);

    //===========================================================================
    // Internal logic
    //===========================================================================
    logic            internal_tx_stg1_req;
    logic            internal_rx_stg1_req;
    lwnoc_lp_state_t internal_tx_state;
    lwnoc_lp_state_t internal_rx_state;
    logic            internal_tx_stg1_deny;
    logic            internal_rx_stg1_deny;
    logic            internal_tx_stg2_req;
    logic            internal_rx_stg2_req;

    //===========================================================================
    // TNIU FSM
    //===========================================================================
    lwnoc_lp_niu_fsm u_tniu_fsm (
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
    // SLV adapter
    //===========================================================================
    lwnoc_lp_slv_adapter #(
        .HAS_TIME_OUT  (HAS_TIME_OUT),
        .TIME_OUT_WIDTH(TIME_OUT_WIDTH)
    ) u_lp2mstslv_adapter (
        .clk                  (clk),
        .rst_n                (rst_n),
        .timeout_val          (timeout_val),
        .tx_stg1_req (internal_rx_stg1_req),
        .rx_stg1_req (internal_tx_stg1_req),
        .tx_state    (internal_rx_state),
        .rx_state    (internal_tx_state),
        .tx_stg1_deny(internal_rx_stg1_deny),
        .rx_stg1_deny(internal_tx_stg1_deny),
        .tx_stg2_req (internal_rx_stg2_req),
        .rx_stg2_req (internal_tx_stg2_req),
        .mst_stg1_req         (mst_stg1_req),
        .mst_stg1_ack         (mst_stg1_ack),
        .mst_cmd              (mst_cmd),
        .mst_stg2_req         (mst_stg2_req),
        .mst_stg2_ack         (mst_stg2_ack)
    );
endmodule

/*
 * File: lwnoc_lp_slv_wrapper.sv
 * Project: lwnoc_lowpower_component
 * File Created: Wednesday, 3rd September 2025 3:01:46 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  combine fsm and device adapter together
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:06:48 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_slv_wrapper
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
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
    logic            device_rx_stg1_req;
    logic            device_tx_stg1_req;
    lwnoc_lp_state_t device_rx_state;
    lwnoc_lp_state_t device_tx_state;
    logic            device_rx_stg1_dack;
    logic            device_tx_stg1_dack;
    logic            device_rx_stg2_req;
    logic            device_tx_stg2_req;

    //===========================================================================
    // TNIU FSM
    //===========================================================================
    lwnoc_lp_niu_fsm u_tniu_fsm (
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
        .stg1_run_done       (),
        .stg1_stop_done      (),
        .stg2_run_done       (),
        .stg2_stop_done      ()
    );

    //===========================================================================
    // DEVICE adapter
    //===========================================================================
    lwnoc_lp_device_adapter #(
        .HAS_TIME_OUT  (HAS_TIME_OUT),
        .TIME_OUT_WIDTH(TIME_OUT_WIDTH)
    ) u_lp_device_adapter (
        .clk                  (clk),
        .rst_n                (rst_n),
        .timeout_val          (timeout_val),
        .device_tx_stg1_req   (device_tx_stg1_req),
        .device_rx_stg1_req   (device_rx_stg1_req),
        .device_tx_state      (device_tx_state),
        .device_rx_state      (device_rx_state),
        .device_tx_stg1_dack  (device_tx_stg1_dack),
        .device_rx_stg1_dack  (device_rx_stg1_dack),
        .device_tx_stg2_req   (device_tx_stg2_req),
        .device_rx_stg2_req   (device_rx_stg2_req),
        .mst_stg1_req         (mst_stg1_req),
        .mst_stg1_ack         (mst_stg1_ack),
        .mst_cmd              (mst_cmd),
        .mst_stg2_req         (mst_stg2_req),
        .mst_stg2_ack         (mst_stg2_ack)
    );
endmodule

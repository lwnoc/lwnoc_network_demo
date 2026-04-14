/*
 * File: lwnoc_lp_endpoint.sv
 * Project: lwnoc_lowpower_component
 * File Created: Tuesday, 26th August 2025 1:54:15 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  傻子模块，这个模块用的越多，人越聪明
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:16:09 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_endpoint
    import dti_sw_left_dsp1_lwnoc_lp_define_package::*;
    import dti_sw_left_dsp1_lwnoc_lp_struct_package::*;
(
    input  logic                 clk,
    input logic                  rst_n,
    output lwnoc_lp_req_signal_t tx_req,
    input  lwnoc_lp_req_signal_t rx_req
);
    //===========================================================================
    // Internal parameter
    //===========================================================================
    localparam integer unsigned LP_REQ_PLD_WIDTH = $bits(lwnoc_lp_req_signal_t);

    //===========================================================================
    // Internal signals
    //===========================================================================
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_sync_cell_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_sync_cell_out;
    lwnoc_lp_req_signal_t                        rx_req_sync;
    lwnoc_lp_req_signal_t                        tx_req_cdc;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_cdc_buf_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_cdc_buf_out;
    logic                                        power_on_seq;

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

    assign rx_req_sync = lwnoc_lp_req_signal_t'(rx_req_sync_cell_out);

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
    // Identify power on or power off
    //===========================================================================
    always_ff @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            power_on_seq <= 1'b1;
        else if (rx_req.stg1_req_and && tx_req.stg1_req_and && tx_req.stg2_req_and && rx_req.stg2_req_and)
            power_on_seq <= 1'b0;
        else if (~(rx_req.stg1_req_or || tx_req.stg1_req_or || rx_req.stg2_req_or || tx_req.stg2_req_or))
            power_on_seq <= 1'b1;
    end

    //===========================================================================
    // Endpoint logic
    //===========================================================================
    // since endpoint does not connect sub node. tx_req and/or are the same
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_req_cdc <= lwnoc_lp_req_signal_t'{
                stg1_req_or : 1'b0,
                stg1_req_and: 1'b0,
                stg2_req_or : 1'b0,
                stg2_req_and: 1'b0,
                state       : LP_LEVEL0_NOP,
                deny_and    : 1'b0,
                deny_or     : 1'b0
            };
        end else if (power_on_seq) begin
            tx_req_cdc <= lwnoc_lp_req_signal_t'{
                stg1_req_or : rx_req_sync.stg1_req_or,
                stg1_req_and: rx_req_sync.stg1_req_or,
                stg2_req_or : rx_req_sync.stg2_req_or,
                stg2_req_and: rx_req_sync.stg2_req_or,
                state       : rx_req_sync.state,
                deny_and    : 1'b0,
                deny_or     : 1'b0
            };
        end
        else if (~power_on_seq) begin
            tx_req_cdc <= lwnoc_lp_req_signal_t'{
                stg1_req_or : rx_req_sync.deny_or ? 1'b0 : rx_req_sync.stg1_req_and,
                stg1_req_and: rx_req_sync.deny_or ? 1'b0 : rx_req_sync.stg1_req_and,
                stg2_req_or : rx_req_sync.stg2_req_and,
                stg2_req_and: rx_req_sync.stg2_req_and,
                state       : rx_req_sync.state,
                deny_and    : rx_req_sync.deny_or,
                deny_or     : rx_req_sync.deny_or
            };
        end
    end

endmodule

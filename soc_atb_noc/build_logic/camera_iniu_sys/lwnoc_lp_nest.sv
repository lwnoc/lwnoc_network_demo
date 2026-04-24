/*
 * File: lwnoc_lp_nest.sv
 * Project: allude
 * File Created: Wednesday, 27th August 2025 2:52:57 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  Quarantine subdomain from main domain, main domain stage1 bypass subdomain.
 *  subdomain stage1, stage2 handshake with main domain stage2.
 * -----
 * Last Modified: Thursday, 4th September 2025 12:00:37 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_nest
    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
(
    input  logic                 clk,
    input  logic                 rst_n,
    input  lwnoc_lp_req_signal_t rx_req_main,
    output lwnoc_lp_req_signal_t tx_req_main,
    input  lwnoc_lp_req_signal_t rx_req_sub,
    output lwnoc_lp_req_signal_t tx_req_sub
);
    //===========================================================================
    // Internal parameter
    //===========================================================================
    localparam integer unsigned LP_REQ_PLD_WIDTH = $bits(lwnoc_lp_req_signal_t);

    //===========================================================================
    // Internal logic
    //===========================================================================
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_main_sync_cell_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_main_sync_cell_out;
    lwnoc_lp_req_signal_t                        rx_req_main_sync;
    lwnoc_lp_req_signal_t                        tx_req_main_cdc;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_main_cdc_buf_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_main_cdc_buf_out;

    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_sub_sync_cell_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] rx_req_sub_sync_cell_out;
    lwnoc_lp_req_signal_t                        rx_req_sub_sync;
    lwnoc_lp_req_signal_t                        tx_req_sub_cdc;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_sub_cdc_buf_in;
    logic                 [LP_REQ_PLD_WIDTH-1:0] tx_req_sub_cdc_buf_out;

    lwnoc_lp_main_fsm_state_t lp_state_sub_domain, lp_state_sub_domain_n;
    lwnoc_lp_state_t          sub_deact_target_state;

    //===========================================================================
    // Sync cell
    //===========================================================================
    assign rx_req_main_sync_cell_in = rx_req_main;
    assign rx_req_sub_sync_cell_in  = rx_req_sub;

    fcip_sync_cell #(
        .DATA_WIDTH (LP_REQ_PLD_WIDTH),
        .SYN_STAGE  (3)
    ) u_rx_req_sync_cell_main (
        .clk        (clk                   ),
        .rst_n      (rst_n                 ),
        .d          (rx_req_main_sync_cell_in   ),
        .q          (rx_req_main_sync_cell_out  )
    );

    fcip_sync_cell #(
        .DATA_WIDTH (LP_REQ_PLD_WIDTH),
        .SYN_STAGE  (3)
    ) u_rx_req_sync_cell_sub (
        .clk        (clk                   ),
        .rst_n      (rst_n                 ),
        .d          (rx_req_sub_sync_cell_in   ),
        .q          (rx_req_sub_sync_cell_out  )
    );

    assign rx_req_main_sync = lwnoc_lp_req_signal_t'(rx_req_main_sync_cell_out);
    assign rx_req_sub_sync  = lwnoc_lp_req_signal_t'(rx_req_sub_sync_cell_out);

    //===========================================================================
    // TX CDC marker
    //===========================================================================
    assign tx_req_main_cdc_buf_in = tx_req_main_cdc;
    assign tx_req_sub_cdc_buf_in  = tx_req_sub_cdc;

    fcip_marker #(
        .DATA_WIDTH(LP_REQ_PLD_WIDTH)
    ) u_lp_tx_cdc_marker_main (
        .I (tx_req_main_cdc_buf_in),
        .Z (tx_req_main_cdc_buf_out)
    );

    fcip_marker #(
        .DATA_WIDTH(LP_REQ_PLD_WIDTH)
    ) u_lp_tx_cdc_marker_sub (
        .I (tx_req_sub_cdc_buf_in),
        .Z (tx_req_sub_cdc_buf_out)
    );
    assign tx_req_main = lwnoc_lp_req_signal_t'(tx_req_main_cdc_buf_out);
    assign tx_req_sub  = lwnoc_lp_req_signal_t'(tx_req_sub_cdc_buf_out);

    //===========================================================================
    // LP FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            lp_state_sub_domain <= LP_MAIN_STOP;
        end else begin
            lp_state_sub_domain <= lp_state_sub_domain_n;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            sub_deact_target_state <= LP_LEVEL0_NOP;
        end
        else if ((lp_state_sub_domain == LP_MAIN_RUN) && (~rx_req_main_sync.stg1_req_and) && (~rx_req_main_sync.stg1_dack_or)) begin
            sub_deact_target_state <= rx_req_main_sync.state;
        end
        else if (lp_state_sub_domain == LP_MAIN_STOP) begin
            sub_deact_target_state <= LP_LEVEL0_NOP;
        end
    end

    always_comb begin
        lp_state_sub_domain_n = lp_state_sub_domain;
        case (lp_state_sub_domain)
            LP_MAIN_STOP: begin
                if (rx_req_main_sync.stg1_req_and && tx_req_main_cdc.stg1_req_and) // bypassing STG1 of main domain
                    lp_state_sub_domain_n = LP_MAIN_ACT_STG1;
            end
            LP_MAIN_ACT_STG1: begin
                if (rx_req_main_sync.stg1_ack_and && tx_req_main_cdc.stg1_ack_and) // main domain STG1 completion; sub domain remains isolated
                    lp_state_sub_domain_n = LP_MAIN_ACT_STG2;
            end
            LP_MAIN_ACT_STG2: begin
                if (rx_req_sub_sync.stg2_ack_and && tx_req_sub_cdc.stg2_ack_and) // sub domain STG2 completion
                    lp_state_sub_domain_n = LP_MAIN_RUN;
            end
            LP_MAIN_RUN: begin
                if (~rx_req_main_sync.stg1_req_and) // leave stable RUN when main-domain STG1 consensus drops
                    lp_state_sub_domain_n = LP_MAIN_DEACT_STG1;
            end
            LP_MAIN_DEACT_STG1: begin
                if (rx_req_main_sync.stg1_dack_or)
                    lp_state_sub_domain_n = LP_MAIN_RUN;
                else if (~(rx_req_main_sync.stg1_ack_or || tx_req_main_cdc.stg1_ack_or)) // main domain STG1 completion; sub domain remains isolated
                    lp_state_sub_domain_n = LP_MAIN_DEACT_STG2;
            end
            LP_MAIN_DEACT_STG2: begin
                if (rx_req_main_sync.stg1_dack_or)
                    lp_state_sub_domain_n = LP_MAIN_RUN;
                else if (~(rx_req_sub_sync.stg2_ack_or || tx_req_sub_cdc.stg2_ack_or)) // sub domain STG2 completion
                    lp_state_sub_domain_n = LP_MAIN_STOP;
            end
            default: lp_state_sub_domain_n = LP_MAIN_STOP;
        endcase
    end

    //===========================================================================
    // Main domain tx control
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                stg1_req_or  : 1'b0,
                stg1_req_and : 1'b0,
                stg1_ack_or  : 1'b0,
                stg1_ack_and : 1'b0,
                stg2_req_or  : 1'b0,
                stg2_req_and : 1'b0,
                stg2_ack_or  : 1'b0,
                stg2_ack_and : 1'b0,
                state        : LP_LEVEL0_NOP,
                stg1_dack_and: 1'b0,
                stg1_dack_or : 1'b0
            };
        end else begin
            case (lp_state_sub_domain)
                LP_MAIN_STOP: begin
                    tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : rx_req_main_sync.stg1_req_or,
                        stg1_req_and : rx_req_main_sync.stg1_req_or,
                        stg1_ack_or  : rx_req_main_sync.stg1_req_or,
                        stg1_ack_and : rx_req_main_sync.stg1_req_or,
                        stg2_req_or  : 1'b0,
                        stg2_req_and : 1'b0,
                        stg2_ack_or  : 1'b0,
                        stg2_ack_and : 1'b0,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
                LP_MAIN_ACT_STG1, LP_MAIN_ACT_STG2: begin
                    tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b1,
                        stg1_req_and : 1'b1,
                        stg1_ack_or  : 1'b1,
                        stg1_ack_and : 1'b1,
                        stg2_req_or  : 1'b0,
                        stg2_req_and : 1'b0,
                        stg2_ack_or  : 1'b0,
                        stg2_ack_and : 1'b0,
                        state        : rx_req_main_sync.state,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
                LP_MAIN_RUN: begin
                    tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b1,
                        stg1_req_and : 1'b1,
                        stg1_ack_or  : 1'b1,
                        stg1_ack_and : 1'b1,
                        stg2_req_or  : 1'b1,
                        stg2_req_and : 1'b1,
                        stg2_ack_or  : 1'b1,
                        stg2_ack_and : 1'b1,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: rx_req_main_sync.stg1_dack_or,
                        stg1_dack_or : rx_req_main_sync.stg1_dack_or
                    };
                end
                LP_MAIN_DEACT_STG1: begin
                    if (rx_req_main_sync.stg1_dack_or) begin
                        tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b1,
                            stg1_req_and : 1'b1,
                            stg1_ack_or  : 1'b1,
                            stg1_ack_and : 1'b1,
                            stg2_req_or  : 1'b1,
                            stg2_req_and : 1'b1,
                            stg2_ack_or  : 1'b1,
                            stg2_ack_and : 1'b1,
                            state        : LP_LEVEL0_NOP,
                            stg1_dack_and: 1'b1,
                            stg1_dack_or : 1'b1
                        };
                    end
                    else begin
                        tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b0,
                            stg1_req_and : 1'b0,
                            stg1_ack_or  : 1'b0,
                            stg1_ack_and : 1'b0,
                            stg2_req_or  : 1'b1,
                            stg2_req_and : 1'b1,
                            stg2_ack_or  : 1'b1,
                            stg2_ack_and : 1'b1,
                            state        : LP_LEVEL0_NOP,
                            stg1_dack_and: 1'b0,
                            stg1_dack_or : 1'b0
                        };
                    end
                end
                LP_MAIN_DEACT_STG2: begin
                    if (rx_req_main_sync.stg1_dack_or) begin
                        tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b1,
                            stg1_req_and : 1'b1,
                            stg1_ack_or  : 1'b1,
                            stg1_ack_and : 1'b1,
                            stg2_req_or  : 1'b1,
                            stg2_req_and : 1'b1,
                            stg2_ack_or  : 1'b1,
                            stg2_ack_and : 1'b1,
                            state        : LP_LEVEL0_NOP,
                            stg1_dack_and: 1'b1,
                            stg1_dack_or : 1'b1
                        };
                    end
                    else begin
                        tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b0,
                            stg1_req_and : 1'b0,
                            stg1_ack_or  : 1'b0,
                            stg1_ack_and : 1'b0,
                            stg2_req_or  : 1'b0,
                            stg2_req_and : 1'b0,
                            stg2_ack_or  : 1'b0,
                            stg2_ack_and : 1'b0,
                            state        : LP_LEVEL0_NOP,
                            stg1_dack_and: 1'b0,
                            stg1_dack_or : 1'b0
                        };
                    end
                end
                default: begin
                    tx_req_main_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b0,
                        stg1_req_and : 1'b0,
                        stg1_ack_or  : 1'b0,
                        stg1_ack_and : 1'b0,
                        stg2_req_or  : 1'b0,
                        stg2_req_and : 1'b0,
                        stg2_ack_or  : 1'b0,
                        stg2_ack_and : 1'b0,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
            endcase
        end
    end


    //===========================================================================
    // Sub domain tx control
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                stg1_req_or  : 1'b0,
                stg1_req_and : 1'b0,
                stg1_ack_or  : 1'b0,
                stg1_ack_and : 1'b0,
                stg2_req_or  : 1'b0,
                stg2_req_and : 1'b0,
                stg2_ack_or  : 1'b0,
                stg2_ack_and : 1'b0,
                state        : LP_LEVEL0_NOP,
                stg1_dack_and: 1'b0,
                stg1_dack_or : 1'b0
            };
        end else begin
            case (lp_state_sub_domain)
                LP_MAIN_STOP: begin
                    tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b0,
                        stg1_req_and : 1'b0,
                        stg1_ack_or  : 1'b0,
                        stg1_ack_and : 1'b0,
                        stg2_req_or  : 1'b0,
                        stg2_req_and : 1'b0,
                        stg2_ack_or  : 1'b0,
                        stg2_ack_and : 1'b0,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
                LP_MAIN_ACT_STG1: begin
                    tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b0,
                        stg1_req_and : 1'b0,
                        stg1_ack_or  : 1'b0,
                        stg1_ack_and : 1'b0,
                        stg2_req_or  : 1'b0,
                        stg2_req_and : 1'b0,
                        stg2_ack_or  : 1'b0,
                        stg2_ack_and : 1'b0,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
                LP_MAIN_ACT_STG2: begin
                    tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b1,
                        stg1_req_and : 1'b1,
                        stg1_ack_or  : 1'b1,
                        stg1_ack_and : 1'b1,
                        stg2_req_or  : 1'b1,
                        stg2_req_and : 1'b1,
                        stg2_ack_or  : 1'b1,
                        stg2_ack_and : 1'b1,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
                LP_MAIN_RUN: begin
                    tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b1,
                        stg1_req_and : 1'b1,
                        stg1_ack_or  : 1'b1,
                        stg1_ack_and : 1'b1,
                        stg2_req_or  : 1'b1,
                        stg2_req_and : 1'b1,
                        stg2_ack_or  : 1'b1,
                        stg2_ack_and : 1'b1,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
                LP_MAIN_DEACT_STG1: begin
                    if (rx_req_main_sync.stg1_dack_or) begin
                        tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b1,
                            stg1_req_and : 1'b1,
                            stg1_ack_or  : 1'b1,
                            stg1_ack_and : 1'b1,
                            stg2_req_or  : 1'b1,
                            stg2_req_and : 1'b1,
                            stg2_ack_or  : 1'b1,
                            stg2_ack_and : 1'b1,
                            state        : LP_LEVEL0_NOP,
                            stg1_dack_and: 1'b0,
                            stg1_dack_or : 1'b0
                        };
                    end
                    else begin
                        tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b1,
                            stg1_req_and : 1'b1,
                            stg1_ack_or  : 1'b1,
                            stg1_ack_and : 1'b1,
                            stg2_req_or  : 1'b1,
                            stg2_req_and : 1'b1,
                            stg2_ack_or  : 1'b1,
                            stg2_ack_and : 1'b1,
                            state        : sub_deact_target_state,
                            stg1_dack_and: 1'b0,
                            stg1_dack_or : 1'b0
                        };
                    end
                end
                LP_MAIN_DEACT_STG2: begin
                    if (rx_req_main_sync.stg1_dack_or) begin
                        tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b1,
                            stg1_req_and : 1'b1,
                            stg1_ack_or  : 1'b1,
                            stg1_ack_and : 1'b1,
                            stg2_req_or  : 1'b1,
                            stg2_req_and : 1'b1,
                            stg2_ack_or  : 1'b1,
                            stg2_ack_and : 1'b1,
                            state        : LP_LEVEL0_NOP,
                            stg1_dack_and: 1'b0,
                            stg1_dack_or : 1'b0
                        };
                    end
                    else begin
                        tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                            stg1_req_or  : 1'b0,
                            stg1_req_and : 1'b0,
                            stg1_ack_or  : 1'b0,
                            stg1_ack_and : 1'b0,
                            stg2_req_or  : 1'b0,
                            stg2_req_and : 1'b0,
                            stg2_ack_or  : 1'b0,
                            stg2_ack_and : 1'b0,
                            state        : sub_deact_target_state,
                            stg1_dack_and: 1'b0,
                            stg1_dack_or : 1'b0
                        };
                    end
                end
                default: begin
                    tx_req_sub_cdc <= lwnoc_lp_req_signal_t'{
                        stg1_req_or  : 1'b0,
                        stg1_req_and : 1'b0,
                        stg1_ack_or  : 1'b0,
                        stg1_ack_and : 1'b0,
                        stg2_req_or  : 1'b0,
                        stg2_req_and : 1'b0,
                        stg2_ack_or  : 1'b0,
                        stg2_ack_and : 1'b0,
                        state        : LP_LEVEL0_NOP,
                        stg1_dack_and: 1'b0,
                        stg1_dack_or : 1'b0
                    };
                end
            endcase
        end
    end
endmodule

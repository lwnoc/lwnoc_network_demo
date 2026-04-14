/*
 * File: lwnoc_lp_stg2_fsm.sv
 * Project: lwnoc_lowpower_component
 * File Created: Monday, 1st September 2025 9:49:10 pm
 * Author: Zou Zhili
 * -----
 * Description:
 *  control stg2 req signal seen by niu
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:08:49 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_stg2_fsm
    import dti_sw_left_dsp0_lwnoc_lp_struct_package::*;
    import dti_sw_left_dsp0_lwnoc_lp_define_package::*;
(
    input  logic                 clk,
    input  logic                 rst_n,
    // lp network interface
    input  logic                 master_mode,
    input  lwnoc_lp_req_signal_t rx_req,
    output lwnoc_lp_req_signal_t stg2_tx_req,
    input  lwnoc_lp_req_signal_t stg1_tx_req,
    // adapter
    output logic                 internal_tx_stg2_req,
    input  logic                 internal_rx_stg2_req
);
    //===========================================================================
    // Internal parameter
    //===========================================================================
    // LP STG2 FSM state
    typedef enum logic [1:0] {
        LP_STG2_RUN,
        LP_STG2_DEACT,
        LP_STG2_STOP,
        LP_STG2_ACT
    } lwnoc_lp_stg2_fsm_state_t;

    //===========================================================================
    // Internal logic
    //===========================================================================
    lwnoc_lp_stg2_fsm_state_t state, state_n;

    //===========================================================================
    // STG2 FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= LP_STG2_STOP;
        else state <= state_n;
    end

    always_comb begin
        state_n = state;
        case (state)
            LP_STG2_STOP: begin
                if (rx_req.stg1_req_and && stg1_tx_req.stg1_req_and) // stg1 finished
                    state_n = LP_STG2_ACT;
            end
            LP_STG2_ACT: begin
                if (stg2_tx_req.stg2_req_and && rx_req.stg2_req_and) // stg2 finished
                state_n = LP_STG2_RUN;
            end
            LP_STG2_RUN: begin
                if ((~rx_req.stg1_req_or) && (~stg1_tx_req.stg1_req_or)) // stg1 finished
                    state_n = LP_STG2_DEACT;
            end
            LP_STG2_DEACT: begin
                if (~(stg2_tx_req.stg2_req_or || rx_req.stg2_req_or)) // stg2 finished
                state_n = LP_STG2_STOP;
            end
            default: state_n = LP_STG2_STOP;
        endcase
    end

    //===========================================================================
    // FSM output to lp network tx signal
    //===========================================================================
    assign stg2_tx_req.stg2_req_or  = internal_rx_stg2_req;
    assign stg2_tx_req.stg2_req_and = internal_rx_stg2_req;

    // tie off stg1 signal
    assign stg2_tx_req.stg1_req_or  = 1'b0;
    assign stg2_tx_req.stg1_req_and = 1'b0;
    assign stg2_tx_req.deny_and     = 1'b0;
    assign stg2_tx_req.deny_or      = 1'b0;
    assign stg2_tx_req.state        = LP_LEVEL0_NOP;
    //===========================================================================
    // FSM output to internal
    //===========================================================================
    always_comb begin
        case (state)
            LP_STG2_RUN: begin
                internal_tx_stg2_req = rx_req.stg2_req_and;  // anyone deassert will trigger
            end
            LP_STG2_DEACT: begin
                internal_tx_stg2_req = master_mode ? rx_req.stg2_req_or : 1'b0;  // everyone deassert will trigger
            end
            LP_STG2_STOP: begin
                internal_tx_stg2_req = rx_req.stg2_req_or;  // anyone assert will trigger
            end
            LP_STG2_ACT: begin
                internal_tx_stg2_req = master_mode ? rx_req.stg2_req_and : 1'b1;   // everyone assert will trigger
            end
            default: begin
                internal_tx_stg2_req = 1'b0;
            end
        endcase
    end
endmodule

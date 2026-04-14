/*
 * File: lwnoc_lp_stg1_fsm.sv
 * Project: lwnoc_lowpower_component
 * File Created: Monday, 1st September 2025 2:29:14 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  control stg1 req/state/deny signal seen by niu
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:08:17 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_stg1_fsm
    import dti_sw_left_noc1_lwnoc_lp_struct_package::*;
    import dti_sw_left_noc1_lwnoc_lp_define_package::*;
(
    input  logic                 clk,
    input  logic                 rst_n,
    // lp network interface
    input  lwnoc_lp_req_signal_t rx_req,
    output lwnoc_lp_req_signal_t tx_req,
    // adapter
    output logic                 internal_tx_stg1_req,
    output lwnoc_lp_state_t      internal_tx_stg1_state,
    output logic                 internal_tx_stg1_deny,
    input  logic                 internal_rx_stg1_req,
    input  lwnoc_lp_state_t      internal_rx_stg1_state,
    input  logic                 internal_rx_stg1_deny,
    output logic                 master_mode
);

    //===========================================================================
    // Internal parameter
    //===========================================================================
    // LP STG1 FSM state
    typedef enum logic [2:0] {
        LP_STG1_RUN,
        LP_STG1_DEACT,
        LP_STG1_DENY,
        LP_STG1_STOP,
        LP_STG1_ACT
    } lwnoc_lp_stg1_fsm_state_t;

    //===========================================================================
    // Internal logic
    //===========================================================================
    lwnoc_lp_stg1_fsm_state_t state, state_n;

    //===========================================================================
    // STG1 FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= LP_STG1_STOP;
        else state <= state_n;
    end

    always_comb begin
        state_n = state;
        case (state)
            LP_STG1_STOP: begin
                if (rx_req.stg1_req_or ||  // external trigger
                    tx_req.stg1_req_or)  // internal trigger
                    state_n = LP_STG1_ACT;
            end
            LP_STG1_ACT: begin
                if (tx_req.stg1_req_and && rx_req.stg1_req_and) state_n = LP_STG1_RUN;
            end
            LP_STG1_RUN: begin
                if ((~rx_req.stg1_req_and) ||  // external trigger
                    ((~tx_req.stg1_req_and)))  // internal trigger
                    state_n = LP_STG1_DEACT;
            end
            LP_STG1_DEACT: begin
                if (~(tx_req.stg1_req_or || rx_req.stg1_req_or)) state_n = LP_STG1_STOP;
                else if (tx_req.deny_or || rx_req.deny_or) state_n = LP_STG1_DENY;
            end
            LP_STG1_DENY: begin
                if ((~(rx_req.deny_or | tx_req.deny_or)) && // deny deassert
                    (tx_req.stg1_req_and && rx_req.stg1_req_and)) // restart
                     state_n = LP_STG1_RUN;
            end
            default: state_n = LP_STG1_STOP;
        endcase
    end

    //===========================================================================
    // recored self trigger
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            master_mode <= 1'b0;
        else if ((state ==LP_STG1_STOP) && tx_req.stg1_req_or)
            master_mode <= 1'b1;
        else if ((state ==LP_STG1_STOP) && rx_req.stg1_req_or)
            master_mode <= 1'b0;
        else if ((state ==LP_STG1_RUN) && (~rx_req.stg1_req_and))
            master_mode <= 1'b0;
        else if ((state ==LP_STG1_RUN) && (~tx_req.stg1_req_and))
            master_mode <= 1'b1;
    end

    //===========================================================================
    // FSM output to lp network tx
    //===========================================================================
    always_comb begin
        case (state)
            LP_STG1_STOP,LP_STG1_RUN: begin
                tx_req.deny_and     = 1'b0;
                tx_req.deny_or      = 1'b0;
            end
            LP_STG1_DEACT: begin
                tx_req.deny_and     = internal_rx_stg1_deny;
                tx_req.deny_or      = internal_rx_stg1_deny;
            end
            LP_STG1_ACT: begin
                tx_req.deny_and     = 1'b0;  // ACT cannot deny
                tx_req.deny_or      = 1'b0;
            end
            LP_STG1_DENY: begin
                tx_req.deny_and     = internal_rx_stg1_deny;
                tx_req.deny_or      = internal_rx_stg1_deny;
            end
            default: begin
                tx_req.deny_and     = 1'b0;
                tx_req.deny_or      = 1'b0;
            end
        endcase
    end
    assign tx_req.stg1_req_or  = internal_rx_stg1_req;
    assign tx_req.stg1_req_and = internal_rx_stg1_req;
    assign tx_req.state        = internal_rx_stg1_state;
    assign tx_req.stg2_req_or  = 1'b0;
    assign tx_req.stg2_req_and = 1'b0;

    //===========================================================================
    // FSM output to internal tx
    //===========================================================================
    always_comb begin
        case (state)
            LP_STG1_RUN: begin
                internal_tx_stg1_req   = rx_req.stg1_req_and;  // anyone deassert will trigger
                internal_tx_stg1_state = rx_req.state;
                internal_tx_stg1_deny  = 1'b0;
            end
            LP_STG1_DEACT: begin
                internal_tx_stg1_req   = master_mode ? rx_req.stg1_req_or : 1'b0;  // everyone deassert will trigger
                internal_tx_stg1_state = rx_req.state;
                    internal_tx_stg1_deny  = rx_req.deny_or | internal_rx_stg1_deny;
            end
            LP_STG1_DENY: begin
                internal_tx_stg1_req   = 1'b1;
                internal_tx_stg1_state = LP_LEVEL0_NOP;
                    internal_tx_stg1_deny  = rx_req.deny_and | internal_rx_stg1_deny;
            end
            LP_STG1_STOP: begin
                internal_tx_stg1_req   = rx_req.stg1_req_or;  // anyone assert will trigger
                internal_tx_stg1_state = LP_LEVEL0_NOP;
                internal_tx_stg1_deny  = 1'b0;
            end

            LP_STG1_ACT: begin
                internal_tx_stg1_req   = master_mode ? rx_req.stg1_req_and : 1'b1;  // everyone assert will trigger
                internal_tx_stg1_state = rx_req.state;
                    internal_tx_stg1_deny  = rx_req.deny_or | internal_rx_stg1_deny;
            end
            default: begin
                internal_tx_stg1_req   = 1'b0;
                internal_tx_stg1_state = LP_LEVEL0_NOP;
                internal_tx_stg1_deny  = 1'b0;
            end
        endcase
    end
endmodule

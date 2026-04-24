/*
 * File: lwnoc_lp_stg1_fsm.sv
 * Project: lwnoc_lowpower_component
 * File Created: Monday, 1st September 2025 2:29:14 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  control stg1 req/state/stg1_dack signal seen by niu
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:08:17 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_stg1_fsm
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
(
    input  logic                 clk,
    input  logic                 rst_n,
    // lp network interface
    input  lwnoc_lp_req_signal_t rx_req,
    output lwnoc_lp_req_signal_t tx_req,
    // device side
    output logic                 device_rx_stg1_req,
    output lwnoc_lp_state_t      device_rx_state,
    output logic                 device_rx_stg1_dack,
    input  logic                 device_tx_stg1_req,
    input  lwnoc_lp_state_t      device_tx_state,
    input  logic                 device_tx_stg1_dack,
    output logic                 master_mode
);

    //===========================================================================
    // Internal parameter
    //===========================================================================
    // LP STG1 FSM state
    typedef enum logic [3:0] {
        LP_STG1_STOP,
        LP_STG1_ACT,
        LP_STG1_ACT_READY,
        LP_STG1_RUN,
        LP_STG1_DEACT,
        LP_STG1_DENY,
        LP_STG1_DEACT_READY,
        LP_STG1_DENY_CONFIRM,
        LP_STG1_ROLLBACK,
        LP_STG1_DENY_LEAVE
    } lwnoc_lp_stg1_fsm_state_t;

    //===========================================================================
    // Internal logic
    //===========================================================================
    lwnoc_lp_stg1_fsm_state_t state, state_n;
    logic                     device_tx_stg1_req_q;
    logic                     local_poweron_seen;
    logic                     local_poweroff_seen;
    logic                     local_active_deny_seen;
    logic                     external_deny_seen;
    logic                     deny_seen;

    //===========================================================================
    // STG1 FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state                <= LP_STG1_STOP;
            device_tx_stg1_req_q <= 1'b0;
        end
        else begin
            state                <= state_n;
            device_tx_stg1_req_q <= device_tx_stg1_req;
        end
    end

    assign local_poweron_seen    = device_tx_stg1_req & (~device_tx_stg1_req_q);
    assign local_poweroff_seen   = (~device_tx_stg1_req) & device_tx_stg1_req_q;
    assign local_active_deny_seen = device_tx_stg1_dack & device_tx_stg1_req;
    assign external_deny_seen    = rx_req.stg1_dack_or;
    assign deny_seen             = local_active_deny_seen | external_deny_seen;

    always_comb begin
        state_n = state;
        case (state)
            LP_STG1_STOP: begin
                if (local_poweron_seen || rx_req.stg1_req_or)
                    state_n = LP_STG1_ACT;
            end
            LP_STG1_ACT: begin
                if (tx_req.stg1_req_and && rx_req.stg1_req_and)
                    state_n = LP_STG1_ACT_READY;
            end
            LP_STG1_ACT_READY: begin
                if (tx_req.stg1_ack_and && rx_req.stg1_ack_and)
                    state_n = LP_STG1_RUN;
            end
            LP_STG1_RUN: begin
                if (local_poweroff_seen || (~rx_req.stg1_req_and))
                    state_n = LP_STG1_DEACT;
            end
            LP_STG1_DEACT: begin
                if (deny_seen)
                    state_n = LP_STG1_DENY;
                else if ((~tx_req.stg1_req_or) && (~rx_req.stg1_req_or))
                    state_n = LP_STG1_DEACT_READY;
            end
            LP_STG1_DEACT_READY: begin
                if ((~tx_req.stg1_ack_or) && (~rx_req.stg1_ack_or))
                    state_n = LP_STG1_STOP;
            end
            LP_STG1_DENY: begin
                if (tx_req.stg1_dack_and)
                    state_n = LP_STG1_DENY_CONFIRM;
            end
            LP_STG1_DENY_CONFIRM: begin
                if (tx_req.stg1_dack_and && rx_req.stg1_dack_and)
                    state_n = LP_STG1_ROLLBACK;
            end
            LP_STG1_ROLLBACK: begin
                if (tx_req.stg1_req_and && rx_req.stg1_req_and)
                    state_n = LP_STG1_DENY_LEAVE;
            end
            LP_STG1_DENY_LEAVE: begin
                if ((~tx_req.stg1_dack_or) && (~rx_req.stg1_dack_or))
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
        else if ((state == LP_STG1_STOP) && local_poweron_seen)
            master_mode <= 1'b1;
        else if ((state == LP_STG1_STOP) && rx_req.stg1_req_or)
            master_mode <= 1'b0;
        else if ((state == LP_STG1_RUN) && (~rx_req.stg1_req_and))
            master_mode <= 1'b0;
        else if ((state == LP_STG1_RUN) && local_poweroff_seen)
            master_mode <= 1'b1;
    end

    //===========================================================================
    // FSM output to lp network tx
    //===========================================================================
    assign tx_req.stg1_req_or  = device_tx_stg1_req;
    assign tx_req.stg1_req_and = device_tx_stg1_req;
    assign tx_req.stg1_ack_or  = (state == LP_STG1_ACT_READY)  ||
                                 (state == LP_STG1_RUN)        ||
                                 (state == LP_STG1_DEACT)      ||
                                 (state == LP_STG1_DENY)       ||
                                 (state == LP_STG1_DENY_CONFIRM) ||
                                 (state == LP_STG1_ROLLBACK)   ||
                                 (state == LP_STG1_DENY_LEAVE);
    assign tx_req.stg1_ack_and = tx_req.stg1_ack_or;
    assign tx_req.state        = (state == LP_STG1_STOP) ? LP_LEVEL0_NOP : device_tx_state;
    assign tx_req.stg2_req_or  = 1'b0;
    assign tx_req.stg2_req_and = 1'b0;
    assign tx_req.stg2_ack_or  = 1'b0;
    assign tx_req.stg2_ack_and = 1'b0;
    assign tx_req.stg1_dack_and = ((state == LP_STG1_DEACT)       ||
                                   (state == LP_STG1_DENY)        ||
                                   (state == LP_STG1_DENY_CONFIRM)||
                                   (state == LP_STG1_ROLLBACK)    ||
                                   (state == LP_STG1_DENY_LEAVE)) ? device_tx_stg1_dack : 1'b0;
    assign tx_req.stg1_dack_or  = tx_req.stg1_dack_and;

    //===========================================================================
    // FSM output to device side
    //===========================================================================
    always_comb begin
        device_rx_stg1_req  = 1'b0;
        device_rx_state     = LP_LEVEL0_NOP;
        device_rx_stg1_dack = 1'b0;

        case (state)
            LP_STG1_ACT,
            LP_STG1_ACT_READY,
            LP_STG1_RUN: begin
                device_rx_stg1_req  = 1'b1;
                device_rx_state     = LP_LEVEL0_NOP;
            end
            LP_STG1_DEACT: begin
                // Use external_deny_seen only on the device-output path to avoid a
                // combinational loop through the local pchn_niu echo of stg1_req/dack.
                // local_active_deny_seen still drives the FSM next-state (deny_seen),
                // so a local deny is captured into LP_STG1_DENY one cycle later and
                // the device sees the deny indication via the LP_STG1_DENY branch.
                device_rx_stg1_req  = external_deny_seen ? 1'b1 : 1'b0;
                device_rx_state     = external_deny_seen ? LP_LEVEL0_NOP : rx_req.state;
                device_rx_stg1_dack = external_deny_seen;
            end
            LP_STG1_DENY: begin
                device_rx_stg1_req  = 1'b1;
                device_rx_state     = LP_LEVEL0_NOP;
                device_rx_stg1_dack = 1'b1;
            end
            LP_STG1_DENY_CONFIRM,
            LP_STG1_ROLLBACK: begin
                device_rx_stg1_req  = 1'b1;
                device_rx_state     = LP_LEVEL0_NOP;
                device_rx_stg1_dack = 1'b1;
            end
            LP_STG1_DENY_LEAVE: begin
                device_rx_stg1_req  = 1'b1;
                device_rx_state     = LP_LEVEL0_NOP;
                device_rx_stg1_dack = 1'b0;
            end
            LP_STG1_DEACT_READY: begin
                device_rx_stg1_req  = 1'b0;
                device_rx_state     = rx_req.state;
            end
            LP_STG1_STOP: begin
                device_rx_stg1_req  = 1'b0;
                device_rx_state     = LP_LEVEL0_NOP;
            end
            default: begin
                device_rx_stg1_req  = 1'b0;
                device_rx_state     = LP_LEVEL0_NOP;
            end
        endcase
    end
endmodule

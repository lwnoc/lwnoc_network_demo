/*
 * File: lwnoc_lp_pchn_fsm.sv
 * Project: allude
 * File Created: Sunday, 31st August 2025 10:57:25 pm
 * Author: Zou Zhili 
 * -----
 * Description:
 *  a pchannel slave module that translate pchannel request to LP network
 * -----
 * Last Modified: Wednesday, 3rd September 2025 7:17:05 am
 * Modified By: Zou Zhili 
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_pchn_niu
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
(
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   preq,
    input  lwnoc_pchannel_state_t  pstate,
    output lwnoc_pchannel_active_t pactive,
    output logic                   paccept,
    output logic                   pdeny,
    // Downstream LP network
    output logic                   tx_stg1_req,
    input  logic                   rx_stg1_req,
    output lwnoc_lp_state_t        tx_state,
    input  lwnoc_lp_state_t        rx_state,
    output logic                   tx_stg1_deny,
    input  logic                   rx_stg1_deny,
    output logic                   tx_stg2_req,
    input  logic                   rx_stg2_req


);
    //===========================================================================
    // Internnal parameter
    //===========================================================================

    typedef enum logic [2:0] {
        LP_PCH_STOP,
        LP_PCH_ACT_STG1,
        LP_PCH_ACT_STG2,
        LP_PCH_RUN,
        LP_PCH_DEACT_STG1,
        LP_PCH_DEACT_STG2,
        LP_PCH_DENY
    } lp_pch_fsm_e;

    //===========================================================================
    // Internnal logic
    //===========================================================================
    lp_pch_fsm_e fsm_cs, fsm_ns;
    logic                   preq_q;  // registered preq for edge
    logic                   preq_rise;
    logic                   dir_up;  // 1: power up (target ON) 0: power down / off level
    lwnoc_lp_state_t        target_lp_state;
    lwnoc_lp_state_t        target_lp_state_latched;
    logic                   transition_in_progress;

    lwnoc_pchannel_active_t pactive_r;
    // paccept/pdeny are level while preq=1 and drop 1 cycle after preq falls
    logic                   paccept_r;
    logic                   pdeny_r;
    logic                   stable_point;
    logic                   new_request;

    //===========================================================================
    // Catch pchannel request
    //===========================================================================
    // preq edge
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) preq_q <= 1'b0;
        else preq_q <= preq;
    end
    assign preq_rise = preq & ~preq_q;

    // Map pstate -> internal target
    always_comb begin
        case (pstate)
            P_POWER_ON:   target_lp_state = LP_LEVEL0_NOP;  // run
            P_LEVEL1_OFF: target_lp_state = LP_LEVEL1_OFF;
            P_LEVEL2_OFF: target_lp_state = LP_LEVEL2_OFF;
            P_LEVEL3_OFF: target_lp_state = LP_LEVEL3_OFF;
            default:      target_lp_state = LP_LEVEL0_NOP;
        endcase
    end

    //===========================================================================
    // Record request direction & target state
    //===========================================================================
    // Latch direction & target when a new upstream request arrives at a stable point
    assign stable_point = (fsm_cs == LP_PCH_STOP) || (fsm_cs == LP_PCH_RUN);
    assign new_request = preq && stable_point && !transition_in_progress;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            dir_up                  <= 1'b0;
            target_lp_state_latched <= LP_LEVEL0_NOP;
        end
        else if (new_request) begin
            dir_up                  <= (pstate == P_POWER_ON);
            target_lp_state_latched <= target_lp_state;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            transition_in_progress <= 1'b0;
        end
        else if (new_request) begin  // receive new request at stable point
            transition_in_progress <= 1'b1;
        end
        else if ((~preq) && stable_point) begin  // request handshake
            transition_in_progress <= 1'b0;
        end
    end

    //===========================================================================
    // Lowpower network status 
    //===========================================================================
    // Stage accept conditions (AND observed)
    wire stg1_all = rx_stg1_req && tx_stg1_req;
    wire stg2_all = rx_stg2_req && tx_stg2_req;
    wire deny_any = rx_stg1_deny | tx_stg1_deny;  // only stage1 deny present

    //===========================================================================
    // LP FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) fsm_cs <= LP_PCH_STOP;
        else fsm_cs <= fsm_ns;
    end

    always_comb begin
        fsm_ns = fsm_cs;
        case (fsm_cs)
            LP_PCH_STOP: begin
                if ((preq && (pstate == P_POWER_ON)) ||  // pchannel trigger
                    rx_stg1_req)  // trigger by others
                    fsm_ns = LP_PCH_ACT_STG1;  // power up sequence
            end
            LP_PCH_ACT_STG1: begin
                if (rx_stg1_req && tx_stg1_req) fsm_ns = LP_PCH_ACT_STG2;
            end
            LP_PCH_ACT_STG2: begin
                if (rx_stg2_req && tx_stg2_req) fsm_ns = LP_PCH_RUN;
            end
            LP_PCH_RUN: begin
                if (preq && (pstate != P_POWER_ON) ||  // pchannel trigger
                    (~rx_stg1_req))  // trigger by others
                    fsm_ns = LP_PCH_DEACT_STG1;  // power down request
            end
            LP_PCH_DEACT_STG1: begin
                if (rx_stg1_deny | tx_stg1_deny) fsm_ns = LP_PCH_DENY;  // treat deny during down as failure
                else if (~(rx_stg1_req | tx_stg1_req)) fsm_ns = LP_PCH_DEACT_STG2;  // all have dropped stage1 (approx)
            end
            LP_PCH_DEACT_STG2: begin
                if (~(rx_stg2_req | tx_stg2_req)) fsm_ns = LP_PCH_STOP;  // all dropped stage2
            end
            LP_PCH_DENY: begin
                if (~(rx_stg1_deny | tx_stg1_deny)) begin
                    fsm_ns = LP_PCH_RUN;
                end
            end
            default: fsm_ns = LP_PCH_STOP;
        endcase
    end

    //===========================================================================
    // LP Network output
    //===========================================================================
    // Drive downstream requests (our side's contribution)
    // NOTE: With only aggregated AND feedback available, we simply assert while needing that stage.
    assign tx_stg1_req = (fsm_cs == LP_PCH_ACT_STG1) || (fsm_cs == LP_PCH_ACT_STG2) || (fsm_cs == LP_PCH_RUN);
    assign tx_stg2_req = (fsm_cs == LP_PCH_ACT_STG2) || (fsm_cs == LP_PCH_DEACT_STG1) || (fsm_cs == LP_PCH_RUN);

    // Desired state forwarded only while ramping in ACT path; once RUN we drive NOP; during power-down we forward new off level until STOP reached.
    always_comb begin
        case (fsm_cs)
            LP_PCH_ACT_STG1, LP_PCH_ACT_STG2:     tx_state = target_lp_state_latched;  // up sequence target
            LP_PCH_RUN:                           tx_state = LP_LEVEL0_NOP;  // running: neutral
            LP_PCH_DEACT_STG1, LP_PCH_DEACT_STG2: tx_state = target_lp_state_latched;  // down target off level
            default:                              tx_state = rx_state;  // STOP / DENY keep network view
        endcase
    end

    // We never actively deny outward in this version
    assign tx_stg1_deny = rx_stg1_deny;


    //===========================================================================
    // pchannel output
    //===========================================================================
    // paccept / pdeny generation
    // Rule: While preq==1, drive decision levels; when preq falls, hold one more cycle, then deassert.
    // Decision levels while preq is asserted
    wire accept_level = (dir_up && (fsm_cs == LP_PCH_RUN)) ||  // up request accepted when RUN reached
 (~dir_up && (fsm_cs == LP_PCH_STOP));  // down/off request accepted when STOP reached

    wire deny_level = (fsm_cs == LP_PCH_DENY);

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            paccept_r <= 1'b0;
            pdeny_r   <= 1'b0;
        end
        else if (transition_in_progress) begin
            // While preq high, drive live decision and remember it
            paccept_r <= accept_level;
            pdeny_r   <= deny_level;
        end
        else begin
            paccept_r <= 1'b0;
            pdeny_r   <= 1'b0;
        end
    end
    assign paccept = paccept_r;
    assign pdeny   = pdeny_r;

    // Active tracking: ON when last accepted up sequence (RUN), OFF when STOP accepted.
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) pactive_r <= P_OFF;
        else if (fsm_cs == LP_PCH_RUN) pactive_r <= P_ON;
        else if (fsm_cs == LP_PCH_STOP) pactive_r <= P_OFF;
    end
    assign pactive = pactive_r;

endmodule

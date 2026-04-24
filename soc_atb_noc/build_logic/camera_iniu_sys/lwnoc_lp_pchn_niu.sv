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
    output logic                   tx_stg1_dack,
    input  logic                   rx_stg1_dack,
    output logic                   tx_stg2_req,
    input  logic                   rx_stg2_req,
    input  logic                   stg1_run_done,
    input  logic                   stg1_stop_done,
    input  logic                   stg2_run_done,
    input  logic                   stg2_stop_done


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
    localparam integer unsigned PDENY_SETTLE_CYCLES = 4;
    localparam integer unsigned PDENY_SETTLE_CNT_W  = (PDENY_SETTLE_CYCLES > 0) ? $clog2(PDENY_SETTLE_CYCLES + 1) : 1;

    lp_pch_fsm_e fsm_cs, fsm_ns;
    logic                   preq_q;  // registered preq for edge
    logic                   preq_rise;
    logic                   dir_up;  // 1: power up (target ON) 0: power down / off level
    logic                   dir_up_active;
    lwnoc_lp_state_t        target_lp_state;
    lwnoc_lp_state_t        target_lp_state_latched;
    logic                   transition_in_progress;

    lwnoc_pchannel_active_t pactive_r;
    // paccept/pdeny are level while preq=1 and drop 1 cycle after preq falls
    logic                   paccept_r;
    logic                   pdeny_r;
    logic                   stable_point;
    logic                   request_failed;
    logic [PDENY_SETTLE_CNT_W-1:0] pdeny_settle_cnt;

    //===========================================================================
    // Catch pchannel request
    //===========================================================================
    // preq edge
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) preq_q <= 1'b0;
        else preq_q <= preq;
    end
    assign preq_rise = preq & ~preq_q;
    assign dir_up_active = (preq_rise && stable_point) ? (pstate == P_POWER_ON) : dir_up;

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

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            dir_up                  <= 1'b0;
            target_lp_state_latched <= LP_LEVEL0_NOP;
        end
        else if (preq_rise && stable_point) begin
            dir_up                  <= (pstate == P_POWER_ON);
            target_lp_state_latched <= target_lp_state;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            transition_in_progress <= 1'b0;
        end
        else if (preq_rise && stable_point) begin  // receive new request at stable point
            transition_in_progress <= 1'b1;
        end
        else if ((~preq) && stable_point) begin  // request handshake
            transition_in_progress <= 1'b0;
        end
    end

    //===========================================================================
    // Lowpower network status
    //===========================================================================
    wire stg1_dack_any = rx_stg1_dack | tx_stg1_dack;
    wire back_to_stable_run = stg1_run_done && (~stg1_dack_any);
    wire pdeny_settle_done  = (pdeny_settle_cnt == PDENY_SETTLE_CNT_W'(PDENY_SETTLE_CYCLES));

    //===========================================================================
    // LP FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) fsm_cs <= LP_PCH_STOP;
        else fsm_cs <= fsm_ns;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            request_failed <= 1'b0;
        end
        else if (preq_rise && stable_point) begin
            request_failed <= 1'b0;
        end
        else if ((fsm_cs == LP_PCH_DEACT_STG1) && stg1_dack_any) begin
            request_failed <= 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            pdeny_settle_cnt <= {PDENY_SETTLE_CNT_W{1'b0}};
        end
        else if ((!transition_in_progress) || (!request_failed) || (!back_to_stable_run)) begin
            pdeny_settle_cnt <= {PDENY_SETTLE_CNT_W{1'b0}};
        end
        else if (!pdeny_settle_done) begin
            pdeny_settle_cnt <= PDENY_SETTLE_CNT_W'(pdeny_settle_cnt + 1'b1);
        end
    end

    always_comb begin
        fsm_ns = fsm_cs;
        case (fsm_cs)
            LP_PCH_STOP: begin
                if ((transition_in_progress && (!request_failed) && dir_up) ||  // latched local pchannel trigger
                    rx_stg1_req)  // trigger by others
                    fsm_ns = LP_PCH_ACT_STG1;  // power up sequence
            end
            LP_PCH_ACT_STG1: begin
                if (stg1_run_done) fsm_ns = LP_PCH_ACT_STG2;
            end
            LP_PCH_ACT_STG2: begin
                if (stg2_run_done) fsm_ns = LP_PCH_RUN;
            end
            LP_PCH_RUN: begin
                if ((transition_in_progress && (!request_failed) && (!dir_up)) ||  // latched local pchannel trigger
                    (((!transition_in_progress) || (!request_failed)) && (~rx_stg1_req)))  // trigger by others unless finishing a denied local request
                    fsm_ns = LP_PCH_DEACT_STG1;  // power down request
            end
            LP_PCH_DEACT_STG1: begin
                if (stg1_dack_any) fsm_ns = LP_PCH_DENY;  // treat dack during down as failure
                else if (stg1_stop_done) fsm_ns = LP_PCH_DEACT_STG2;
            end
            LP_PCH_DEACT_STG2: begin
                if (stg2_stop_done) fsm_ns = LP_PCH_STOP;
            end
            LP_PCH_DENY: begin
                if (back_to_stable_run) begin
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
    assign tx_stg1_req = (fsm_cs == LP_PCH_ACT_STG1) ||
                         (fsm_cs == LP_PCH_ACT_STG2) ||
                         (fsm_cs == LP_PCH_RUN) ||
                         ((fsm_cs == LP_PCH_DENY) && rx_stg1_req);
    assign tx_stg2_req = (fsm_cs == LP_PCH_ACT_STG2) || (fsm_cs == LP_PCH_DEACT_STG1) || (fsm_cs == LP_PCH_RUN) || (fsm_cs == LP_PCH_DENY);
    // Desired state forwarded only while ramping in ACT path; once RUN we drive NOP; during power-down we forward new off level until STOP reached.
    always_comb begin
        case (fsm_cs)
            LP_PCH_STOP:                          tx_state = LP_LEVEL0_NOP;
            LP_PCH_ACT_STG1, LP_PCH_ACT_STG2:     tx_state = target_lp_state_latched;  // up sequence target
            LP_PCH_RUN:                           tx_state = LP_LEVEL0_NOP;  // running: neutral
            LP_PCH_DEACT_STG1, LP_PCH_DEACT_STG2: tx_state = target_lp_state_latched;  // down target off level
            LP_PCH_DENY:                          tx_state = LP_LEVEL0_NOP;  // rollback target
            default:                              tx_state = LP_LEVEL0_NOP;
        endcase
    end

    // The pchannel-facing device participates in the deny/revert handshake as a
    // level-based responder. Once the network requests deny/revert entry, keep
    // tx_stg1_dack asserted until the network releases rx_stg1_dack again.
    assign tx_stg1_dack = (fsm_cs == LP_PCH_DENY) ? rx_stg1_dack : 1'b0;


    //===========================================================================
    // pchannel output
    //===========================================================================
    // paccept / pdeny generation
    // Rule: While preq==1, drive decision levels; when preq falls, hold one more cycle, then deassert.
    // Decision levels while preq is asserted
    wire accept_level = transition_in_progress &&
                        ((dir_up_active && (fsm_cs == LP_PCH_RUN)) ||
                         ((~dir_up_active) && (fsm_cs == LP_PCH_STOP)));

    wire deny_level = request_failed && back_to_stable_run && pdeny_settle_done;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            paccept_r <= 1'b0;
            pdeny_r   <= 1'b0;
        end
        else if (~preq) begin
            paccept_r <= 1'b0;
            pdeny_r   <= 1'b0;
        end
        else if (transition_in_progress) begin
            // While preq high, drive live decision and remember it
            paccept_r <= accept_level;
            pdeny_r   <= deny_level;
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

/*
 * File: lwnoc_lp_slv_adapter.sv
 * Project: lwnoc_lowpower_component
 * File Created: Tuesday, 2nd September 2025 4:19:38 am
 * Author: Zou Zhili
 * -----
 * Description:
 *    Implements the Low Power Slave Adapter for LWNoC. This module converts
 *    low power network requests and states into slave-side commands, manages
 *    stage 1/2 handshake signals, and handles power-off timeouts and denial
 *    logic.
 *
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:05:13 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_slv_adapter
    import sys_npu_lwnoc_lp_struct_package::*;
    import sys_npu_lwnoc_lp_define_package::*;
#(
    parameter integer unsigned HAS_TIME_OUT   = 1,
    parameter integer unsigned TIME_OUT_WIDTH = 10
) (
    input  logic                                   clk,
    input  logic                                   rst_n,
    // config
    input  logic              [TIME_OUT_WIDTH-1:0] timeout_val,
    // lp network side
    output logic                                   tx_stg1_req,
    input  logic                                   rx_stg1_req,
    output lwnoc_lp_state_t                        tx_state,
    input  lwnoc_lp_state_t                        rx_state,
    output logic                                   tx_stg1_deny,
    input  logic                                   rx_stg1_deny,
    output logic                                   tx_stg2_req,
    input  logic                                   rx_stg2_req,
    // mst/slv side
    output logic                                   mst_stg1_req,
    input  logic                                   mst_stg1_ack,
    output lwnoc_lp_slv_cmd_t                      mst_cmd,
    output logic                                   mst_stg2_req,
    input  logic                                   mst_stg2_ack
);
    //===========================================================================
    // Internal parameter
    //===========================================================================
    typedef enum logic [2:0] {
        LP_SLV_FSM_IDLE,
        LP_SLV_FSM_REQ_OFF,
        LP_SLV_FSM_REQ_ON,
        LP_SLV_FSM_REVERT
    } lwnoc_lp_slv_fsm_state_t;
    //===========================================================================
    // Internal logic
    //===========================================================================
    // LP signal listening
    logic                                   rx_stg1_req_r;
    logic                                   rx_stg1_req_rise;
    logic                                   rx_stg1_req_fall;
    logic                                   rx_stg2_req_r;
    logic                                   rx_stg2_req_rise;
    logic                                   rx_stg2_req_fall;
    logic                                   rx_deny_r;
    logic                                   rx_deny_rise;
    // Timeout
    logic              [TIME_OUT_WIDTH-1:0] timeout_cnt;
    logic                                   timeout_flag;
    // record previous output for reverting
    logic                                   tx_stg1_previous;
    // Command conversion
    lwnoc_lp_slv_cmd_t                      conv_cmd;

    lwnoc_lp_slv_fsm_state_t stg1_fsm_state, stg1_fsm_state_n;
    lwnoc_lp_slv_fsm_state_t stg2_fsm_state, stg2_fsm_state_n;


    //===========================================================================
    // listen to req
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_stg1_req_r <= 1'b0;
            rx_stg2_req_r <= 1'b0;
            rx_deny_r     <= 1'b0;
        end
        else begin
            rx_stg1_req_r <= rx_stg1_req;
            rx_stg2_req_r <= rx_stg2_req;
            rx_deny_r     <= rx_stg1_deny;
        end
    end

    assign rx_stg1_req_rise = rx_stg1_req & ~rx_stg1_req_r;
    assign rx_stg1_req_fall = ~rx_stg1_req & rx_stg1_req_r;
    assign rx_stg2_req_rise = rx_stg2_req & ~rx_stg2_req_r;
    assign rx_stg2_req_fall = ~rx_stg2_req & rx_stg2_req_r;
    assign rx_deny_rise     = rx_stg1_deny & ~rx_deny_r;

    //===========================================================================
    // LP state to Command conversion
    //===========================================================================
    always_comb begin
        if (rx_stg1_req) begin
            conv_cmd = LP_SLV_CMD_ON;
        end
        else begin
            case (rx_state)
                LP_LEVEL1_OFF: conv_cmd = LP_SLV_CMD_LEVEL1_OFF;
                LP_LEVEL2_OFF: conv_cmd = LP_SLV_CMD_LEVEL2_OFF;
                LP_LEVEL3_OFF: conv_cmd = LP_SLV_CMD_LEVEL3_OFF;
                default:       conv_cmd = LP_SLV_CMD_ON;
            endcase
        end
    end

    //===========================================================================
    // SLV FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            stg1_fsm_state <= LP_SLV_FSM_IDLE;
            stg2_fsm_state <= LP_SLV_FSM_IDLE;
        end
        else begin
            stg1_fsm_state <= stg1_fsm_state_n;
            stg2_fsm_state <= stg2_fsm_state_n;
        end
    end

    // STG1 FSM state transfer
    generate
        if (HAS_TIME_OUT == 0) begin : gen_stg1_fsm_no_timeout
            always_comb begin
                stg1_fsm_state_n = stg1_fsm_state;
                case (stg1_fsm_state)
                    LP_SLV_FSM_IDLE: begin
                        if (rx_stg1_req_rise) stg1_fsm_state_n = LP_SLV_FSM_REQ_ON;
                        else if (rx_deny_rise)
                            stg1_fsm_state_n = LP_SLV_FSM_REQ_ON;
                        else if (rx_stg1_req_fall) stg1_fsm_state_n = LP_SLV_FSM_REQ_OFF;
                    end
                    LP_SLV_FSM_REQ_ON: begin
                        if (mst_stg1_ack) stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                    end
                    LP_SLV_FSM_REQ_OFF: begin
                        if (mst_stg1_ack) stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                    end
                    default: stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                endcase
            end
        end else begin : gen_stg1_fsm_with_timeout
            always_comb begin
                stg1_fsm_state_n = stg1_fsm_state;
                case (stg1_fsm_state)
                    LP_SLV_FSM_IDLE: begin
                        if (rx_stg1_req_rise) stg1_fsm_state_n = LP_SLV_FSM_REQ_ON;
                        else if (rx_deny_rise)  // ONLY POWER off can deny
                            stg1_fsm_state_n = LP_SLV_FSM_REQ_ON;
                        else if (rx_stg1_req_fall) stg1_fsm_state_n = LP_SLV_FSM_REQ_OFF;
                    end
                    LP_SLV_FSM_REQ_ON: begin
                        if (mst_stg1_ack) stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                    end
                    LP_SLV_FSM_REQ_OFF: begin
                        if (mst_stg1_ack) stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                        else if ((timeout_flag || tx_stg1_deny))
                            stg1_fsm_state_n = LP_SLV_FSM_REVERT;
                    end
                    LP_SLV_FSM_REVERT: begin
                        if (tx_stg1_deny && rx_stg1_req) stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                    end

                    default: stg1_fsm_state_n = LP_SLV_FSM_IDLE;
                endcase
            end
        end
    endgenerate

    // STG2 FSM state transfer
    always_comb begin
        stg2_fsm_state_n = stg2_fsm_state;
        case (stg2_fsm_state)
            LP_SLV_FSM_IDLE: begin
                if (rx_stg2_req_rise) stg2_fsm_state_n = LP_SLV_FSM_REQ_ON;
                else if (rx_stg2_req_fall) stg2_fsm_state_n = LP_SLV_FSM_REQ_OFF;
            end
            LP_SLV_FSM_REQ_ON: begin
                if (mst_stg2_ack) stg2_fsm_state_n = LP_SLV_FSM_IDLE;
            end
            LP_SLV_FSM_REQ_OFF: begin
                if (mst_stg2_ack) stg2_fsm_state_n = LP_SLV_FSM_IDLE;
            end
            default: stg2_fsm_state_n = LP_SLV_FSM_IDLE;
        endcase
    end

    //===========================================================================
    // Timeout logic
    //===========================================================================
    generate
        if (HAS_TIME_OUT == 0) begin : gen_no_timeout
            assign timeout_cnt  = {TIME_OUT_WIDTH{1'b0}};
            assign timeout_flag = 1'b0;
        end
        else begin : gen_with_timeout
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n)
                    timeout_cnt <= {TIME_OUT_WIDTH{1'b0}};
                else if (stg1_fsm_state == LP_SLV_FSM_IDLE)
                    timeout_cnt <= timeout_val;
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_OFF) &&  // only power off level1 can trigger timeout
                        (conv_cmd == LP_SLV_CMD_LEVEL1_OFF)    &&
                        (timeout_cnt != {TIME_OUT_WIDTH{1'b0}}))
                    timeout_cnt <= TIME_OUT_WIDTH'(timeout_cnt - 1'b1);
            end

            assign timeout_flag = (timeout_cnt == {TIME_OUT_WIDTH{1'b0}}) &&
                                  (stg1_fsm_state != LP_SLV_FSM_IDLE);
        end
    endgenerate

    //===========================================================================
    // LP Network side signal
    //===========================================================================
    // STG1 PART
    generate
        if (HAS_TIME_OUT == 0) begin : gen_stg1_tx_no_timeout
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    tx_state         <= LP_LEVEL0_NOP;
                    tx_stg1_req      <= 1'b0;
                    tx_stg1_previous <= 1'b0;
                    tx_stg1_deny     <= 1'b0;
                end
                else if (stg1_fsm_state == LP_SLV_FSM_IDLE) begin
                    tx_state         <= rx_state;
                    tx_stg1_req      <= tx_stg1_req;
                    tx_stg1_previous <= tx_stg1_req;
                    tx_stg1_deny     <= 1'b0;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_ON) && mst_stg1_ack) begin
                    tx_state         <= tx_state;
                    tx_stg1_req      <= 1'b1;
                    tx_stg1_previous <= tx_stg1_previous;
                    tx_stg1_deny     <= 1'b0;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_OFF) && mst_stg1_ack) begin
                    tx_state         <= tx_state;
                    tx_stg1_req      <= 1'b0;
                    tx_stg1_previous <= tx_stg1_previous;
                    tx_stg1_deny     <= 1'b0;
                end
                else begin
                    tx_state         <= tx_state;
                    tx_stg1_req      <= tx_stg1_req;
                    tx_stg1_previous <= tx_stg1_previous;
                    tx_stg1_deny     <= 1'b0;
                end
            end
        end else begin : gen_stg1_tx_with_timeout
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    tx_state         <= LP_LEVEL0_NOP;
                    tx_stg1_req      <= 1'b0;
                    tx_stg1_previous <= 1'b0;
                    tx_stg1_deny     <= 1'b0;
                end
                else if (stg1_fsm_state == LP_SLV_FSM_IDLE) begin
                    tx_state         <= rx_state;
                    tx_stg1_req      <= tx_stg1_req;
                    tx_stg1_previous <= tx_stg1_req;
                    tx_stg1_deny     <= 1'b0;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_ON) && mst_stg1_ack) begin
                    tx_state         <= tx_state;
                    tx_stg1_req      <= 1'b1;
                    tx_stg1_previous <= tx_stg1_previous;
                    tx_stg1_deny     <= 1'b0;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_OFF) && mst_stg1_ack) begin
                    tx_state         <= tx_state;
                    tx_stg1_req      <= 1'b0;
                    tx_stg1_previous <= tx_stg1_previous;
                    tx_stg1_deny     <= 1'b0;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REVERT)) begin
                    tx_state         <= LP_LEVEL0_NOP;
                    tx_stg1_req      <= tx_stg1_previous;
                    tx_stg1_previous <= tx_stg1_previous;
                    tx_stg1_deny     <= 1'b1;
                end
            end
        end
    endgenerate

    // STG2 PART
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            tx_stg2_req <= 1'b0;
        end
        else if (stg2_fsm_state == LP_SLV_FSM_IDLE) begin
            tx_stg2_req <= tx_stg2_req;
        end
        else if ((stg2_fsm_state == LP_SLV_FSM_REQ_ON) && mst_stg2_ack) begin
            tx_stg2_req <= 1'b1;
        end
        else if ((stg2_fsm_state == LP_SLV_FSM_REQ_OFF) && mst_stg2_ack) begin
            tx_stg2_req <= 1'b0;
        end
    end

    //===========================================================================
    // MST/SLV side signal
    //===========================================================================

    // STG1
    generate
        if (HAS_TIME_OUT == 0) begin : gen_mst_stg1_no_timeout
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    mst_stg1_req <= 1'b0;
                    mst_cmd      <= LP_SLV_CMD_ON;
                end
                else if (stg1_fsm_state == LP_SLV_FSM_IDLE) begin
                    mst_stg1_req <= 1'b0;
                    mst_cmd      <= mst_cmd;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_ON)) begin
                    mst_stg1_req <= 1'b1;
                    mst_cmd      <= conv_cmd;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_OFF)) begin
                    mst_stg1_req <= 1'b1;
                    mst_cmd      <= conv_cmd;
                end
                else begin
                    mst_stg1_req <= mst_stg1_req;
                    mst_cmd      <= mst_cmd;
                end
            end
        end else begin : gen_mst_stg1_with_timeout
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    mst_stg1_req <= 1'b0;
                    mst_cmd      <= LP_SLV_CMD_ON;
                end
                else if (stg1_fsm_state == LP_SLV_FSM_IDLE) begin
                    mst_stg1_req <= 1'b0;
                    mst_cmd      <= mst_cmd;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_ON)) begin
                    mst_stg1_req <= 1'b1;
                    mst_cmd      <= conv_cmd;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REQ_OFF)) begin
                    mst_stg1_req <= 1'b1;
                    mst_cmd      <= conv_cmd;
                end
                else if ((stg1_fsm_state == LP_SLV_FSM_REVERT)) begin
                    mst_stg1_req <= 1'b1;
                    if (conv_cmd != LP_SLV_CMD_ON)  // only POWEROFF can revert
                        mst_cmd <= LP_SLV_CMD_ON;
                end
                else begin
                    mst_stg1_req <= mst_stg1_req;
                    mst_cmd      <= mst_cmd;
                end
            end
        end
    endgenerate

    // STG2
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mst_stg2_req <= 1'b0;
        end
        else if (stg2_fsm_state == LP_SLV_FSM_IDLE) begin
            mst_stg2_req <= 1'b0;
        end
        else if ((stg2_fsm_state == LP_SLV_FSM_REQ_ON)) begin
            mst_stg2_req <= 1'b1;
        end
        else if ((stg2_fsm_state == LP_SLV_FSM_REQ_OFF)) begin
            mst_stg2_req <= 1'b1;
        end
        else begin
            mst_stg2_req <= mst_stg2_req;
        end
    end
endmodule

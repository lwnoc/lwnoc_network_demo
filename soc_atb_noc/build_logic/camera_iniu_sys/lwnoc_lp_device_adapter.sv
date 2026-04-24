/*
 * File: lwnoc_lp_device_adapter.sv
 * Project: lwnoc_lowpower_component
 * File Created: Tuesday, 2nd September 2025 4:19:38 am
 * Author: Zou Zhili
 * -----
 * Description:
 *    Implements the Low Power Device Adapter for LWNoC. This module converts
 *    local device-facing stage 1/2 requests into master/slave commands,
 *    manages synchronous req/dack handshakes, and handles power-off timeout
 *    triggered revert behavior.
 *
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_device_adapter
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
#(
    parameter integer unsigned HAS_TIME_OUT   = 1,
    parameter integer unsigned TIME_OUT_WIDTH = 10
) (
    input  logic                                   clk,
    input  logic                                   rst_n,
    // config
    input  logic              [TIME_OUT_WIDTH-1:0] timeout_val,
    // device side
    output logic                                   device_tx_stg1_req,
    input  logic                                   device_rx_stg1_req,
    output lwnoc_lp_state_t                        device_tx_state,
    input  lwnoc_lp_state_t                        device_rx_state,
    output logic                                   device_tx_stg1_dack,
    input  logic                                   device_rx_stg1_dack,
    output logic                                   device_tx_stg2_req,
    input  logic                                   device_rx_stg2_req,
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
    typedef enum logic [1:0] {
        LP_DEVICE_FSM_IDLE,
        LP_DEVICE_FSM_REQ_OFF,
        LP_DEVICE_FSM_REQ_ON,
        LP_DEVICE_FSM_REVERT
    } lwnoc_lp_device_fsm_state_t;

    //===========================================================================
    // Internal logic
    //===========================================================================
    logic                                   device_rx_stg1_req_r;
    logic                                   device_rx_stg1_req_rise;
    logic                                   device_rx_stg1_req_fall;
    logic                                   device_rx_stg2_req_r;
    logic                                   device_rx_stg2_req_rise;
    logic                                   device_rx_stg2_req_fall;
    logic              [TIME_OUT_WIDTH-1:0] timeout_cnt;
    logic                                   timeout_flag;
    logic                                   peer_dack_seen;
    lwnoc_lp_slv_cmd_t                      conv_cmd;

    lwnoc_lp_device_fsm_state_t             stg1_fsm_state, stg1_fsm_state_n;
    lwnoc_lp_device_fsm_state_t             stg2_fsm_state, stg2_fsm_state_n;

    //===========================================================================
    // listen to req
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            device_rx_stg1_req_r <= 1'b0;
            device_rx_stg2_req_r <= 1'b0;
        end
        else begin
            device_rx_stg1_req_r <= device_rx_stg1_req;
            device_rx_stg2_req_r <= device_rx_stg2_req;
        end
    end

    assign device_rx_stg1_req_rise = device_rx_stg1_req & ~device_rx_stg1_req_r;
    assign device_rx_stg1_req_fall = ~device_rx_stg1_req & device_rx_stg1_req_r;
    assign device_rx_stg2_req_rise = device_rx_stg2_req & ~device_rx_stg2_req_r;
    assign device_rx_stg2_req_fall = ~device_rx_stg2_req & device_rx_stg2_req_r;

    //===========================================================================
    // LP state to Command conversion
    //===========================================================================
    always_comb begin
        if (device_rx_stg1_req) begin
            conv_cmd = LP_SLV_CMD_ON;
        end
        else begin
            case (device_rx_state)
                LP_LEVEL1_OFF: conv_cmd = LP_SLV_CMD_LEVEL1_OFF;
                LP_LEVEL2_OFF: conv_cmd = LP_SLV_CMD_LEVEL2_OFF;
                LP_LEVEL3_OFF: conv_cmd = LP_SLV_CMD_LEVEL3_OFF;
                default:       conv_cmd = LP_SLV_CMD_ON;
            endcase
        end
    end

    //===========================================================================
    // device FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            stg1_fsm_state <= LP_DEVICE_FSM_IDLE;
            stg2_fsm_state <= LP_DEVICE_FSM_IDLE;
        end
        else begin
            stg1_fsm_state <= stg1_fsm_state_n;
            stg2_fsm_state <= stg2_fsm_state_n;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            peer_dack_seen <= 1'b0;
        end
        else if (stg1_fsm_state != LP_DEVICE_FSM_REVERT) begin
            peer_dack_seen <= 1'b0;
        end
        else if (device_rx_stg1_dack) begin
            peer_dack_seen <= 1'b1;
        end
    end

    // STG1 FSM state transfer
    always_comb begin
        stg1_fsm_state_n = stg1_fsm_state;
        case (stg1_fsm_state)
            LP_DEVICE_FSM_IDLE: begin
                if (device_rx_stg1_dack)
                    stg1_fsm_state_n = LP_DEVICE_FSM_REVERT;
                else if (device_rx_stg1_req_rise)
                    stg1_fsm_state_n = LP_DEVICE_FSM_REQ_ON;
                else if (device_rx_stg1_req_fall)
                    stg1_fsm_state_n = LP_DEVICE_FSM_REQ_OFF;
            end
            LP_DEVICE_FSM_REQ_ON: begin
                if (device_rx_stg1_dack)
                    stg1_fsm_state_n = LP_DEVICE_FSM_REVERT;
                else if (mst_stg1_ack)
                    stg1_fsm_state_n = LP_DEVICE_FSM_IDLE;
            end
            LP_DEVICE_FSM_REQ_OFF: begin
                if (timeout_flag || device_rx_stg1_dack)
                    stg1_fsm_state_n = LP_DEVICE_FSM_REVERT;
                else if (mst_stg1_ack)
                    stg1_fsm_state_n = LP_DEVICE_FSM_IDLE;
            end
            LP_DEVICE_FSM_REVERT: begin
                if (device_tx_stg1_req && device_rx_stg1_req && peer_dack_seen && (~device_rx_stg1_dack))
                    stg1_fsm_state_n = LP_DEVICE_FSM_IDLE;
            end
            default: stg1_fsm_state_n = LP_DEVICE_FSM_IDLE;
        endcase
    end

    // STG2 FSM state transfer
    always_comb begin
        stg2_fsm_state_n = stg2_fsm_state;
        case (stg2_fsm_state)
            LP_DEVICE_FSM_IDLE: begin
                if (device_rx_stg2_req_rise)
                    stg2_fsm_state_n = LP_DEVICE_FSM_REQ_ON;
                else if (device_rx_stg2_req_fall)
                    stg2_fsm_state_n = LP_DEVICE_FSM_REQ_OFF;
            end
            LP_DEVICE_FSM_REQ_ON: begin
                if (mst_stg2_ack)
                    stg2_fsm_state_n = LP_DEVICE_FSM_IDLE;
            end
            LP_DEVICE_FSM_REQ_OFF: begin
                if (mst_stg2_ack)
                    stg2_fsm_state_n = LP_DEVICE_FSM_IDLE;
            end
            default: stg2_fsm_state_n = LP_DEVICE_FSM_IDLE;
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
                else if (stg1_fsm_state == LP_DEVICE_FSM_IDLE)
                    timeout_cnt <= timeout_val;
                else if ((stg1_fsm_state == LP_DEVICE_FSM_REQ_OFF) &&
                         (conv_cmd == LP_SLV_CMD_LEVEL1_OFF)   &&
                         (timeout_cnt != {TIME_OUT_WIDTH{1'b0}}))
                    timeout_cnt <= TIME_OUT_WIDTH'(timeout_cnt - 1'b1);
            end

            assign timeout_flag = (timeout_cnt == {TIME_OUT_WIDTH{1'b0}}) &&
                                  (stg1_fsm_state == LP_DEVICE_FSM_REQ_OFF);
        end
    endgenerate

    //===========================================================================
    // device-facing handshake to network-side FSM
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            device_tx_state      <= LP_LEVEL0_NOP;
            device_tx_stg1_req   <= 1'b0;
            device_tx_stg1_dack  <= 1'b0;
        end
        else if (stg1_fsm_state == LP_DEVICE_FSM_IDLE) begin
            device_tx_state      <= device_rx_state;
            device_tx_stg1_req   <= device_tx_stg1_req;
            device_tx_stg1_dack  <= 1'b0;
        end
        else if ((stg1_fsm_state == LP_DEVICE_FSM_REQ_ON) && mst_stg1_ack) begin
            device_tx_state      <= device_tx_state;
            device_tx_stg1_req   <= 1'b1;
            device_tx_stg1_dack  <= 1'b0;
        end
        else if ((stg1_fsm_state == LP_DEVICE_FSM_REQ_OFF) && mst_stg1_ack) begin
            device_tx_state      <= device_tx_state;
            device_tx_stg1_req   <= 1'b0;
            device_tx_stg1_dack  <= 1'b0;
        end
        else if (stg1_fsm_state == LP_DEVICE_FSM_REVERT) begin
            device_tx_state      <= LP_LEVEL0_NOP;
            device_tx_stg1_req   <= (device_rx_stg1_req && (mst_stg1_ack || device_tx_stg1_req)) ? 1'b1 : device_tx_stg1_req;
            device_tx_stg1_dack  <= 1'b1;
        end
    end

    // STG2 PART
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            device_tx_stg2_req <= 1'b0;
        end
        else if (stg2_fsm_state == LP_DEVICE_FSM_IDLE) begin
            device_tx_stg2_req <= device_tx_stg2_req;
        end
        else if ((stg2_fsm_state == LP_DEVICE_FSM_REQ_ON) && mst_stg2_ack) begin
            device_tx_stg2_req <= 1'b1;
        end
        else if ((stg2_fsm_state == LP_DEVICE_FSM_REQ_OFF) && mst_stg2_ack) begin
            device_tx_stg2_req <= 1'b0;
        end
    end

    //===========================================================================
    // MST/SLV side signal
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mst_stg1_req <= 1'b0;
            mst_cmd      <= LP_SLV_CMD_ON;
        end
        else if (stg1_fsm_state == LP_DEVICE_FSM_IDLE) begin
            mst_stg1_req <= 1'b0;
            mst_cmd      <= mst_cmd;
        end
        else if (stg1_fsm_state == LP_DEVICE_FSM_REQ_ON) begin
            mst_stg1_req <= 1'b1;
            mst_cmd      <= conv_cmd;
        end
        else if (stg1_fsm_state == LP_DEVICE_FSM_REQ_OFF) begin
            mst_stg1_req <= 1'b1;
            mst_cmd      <= conv_cmd;
        end
        else begin
            mst_stg1_req <= ~device_tx_stg1_req;
            mst_cmd      <= LP_SLV_CMD_ON;
        end
    end

    // STG2
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mst_stg2_req <= 1'b0;
        end
        else if (stg2_fsm_state == LP_DEVICE_FSM_IDLE) begin
            mst_stg2_req <= 1'b0;
        end
        else if (stg2_fsm_state == LP_DEVICE_FSM_REQ_ON) begin
            mst_stg2_req <= 1'b1;
        end
        else if (stg2_fsm_state == LP_DEVICE_FSM_REQ_OFF) begin
            mst_stg2_req <= 1'b1;
        end
        else begin
            mst_stg2_req <= mst_stg2_req;
        end
    end
endmodule

/*
 * File: lwnoc_lp_tniu_func_iniu.sv
 * Project: lwnoc_lowpower_component
 * File Created: Wednesday, 27th August 2025 2:40:18 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  lp tnui for functional iniu
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:14:46 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_tniu_func_iniu
    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
#(
    parameter integer unsigned HAS_TIME_OUT   = 1,
    parameter integer unsigned TIME_OUT_WIDTH = 10
) (
    input  logic                                      clk,
    input  logic                                      rst_n,
    // LP NOC
    input  lwnoc_lp_req_signal_t                      rx_req,
    output lwnoc_lp_req_signal_t                      tx_req,
    // Function Ctrl
    output logic                                      stall,
    output logic                                      partial_reset,
    input  logic                                      trans_idle,
    input  logic                 [TIME_OUT_WIDTH-1:0] timeout_val
);

    //===========================================================================
    // Internal signal
    //===========================================================================
    logic              mst_stg1_req;
    logic              mst_stg1_ack;
    lwnoc_lp_slv_cmd_t mst_cmd;
    logic              mst_stg2_req;
    logic              mst_stg2_ack;

    //===========================================================================
    // Protocol convert
    //===========================================================================
    lwnoc_lp_slv_wrapper #(
        .HAS_TIME_OUT  (HAS_TIME_OUT),
        .TIME_OUT_WIDTH(TIME_OUT_WIDTH)
    ) u_slv_protocol_convert (
        .clk         (clk),
        .rst_n       (rst_n),
        .timeout_val (timeout_val),
        .rx_req      (rx_req),
        .tx_req      (tx_req),
        .mst_stg1_req(mst_stg1_req),
        .mst_stg1_ack(mst_stg1_ack),
        .mst_cmd     (mst_cmd),
        .mst_stg2_req(mst_stg2_req),
        .mst_stg2_ack(mst_stg2_ack)
    );

    //===========================================================================
    // STG1 control switch
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            stall         <= 1'b1;
            partial_reset <= 1'b0;
        end else if (mst_stg1_req) begin
            case (mst_cmd)
                LP_SLV_CMD_ON: begin
                    stall         <= 1'b0;
                    partial_reset <= 1'b0;
                end
                LP_SLV_CMD_LEVEL1_OFF: begin
                    stall         <= trans_idle;
                    partial_reset <= 1'b0;
                end
                LP_SLV_CMD_LEVEL2_OFF: begin
                    stall         <= 1'b1;
                    partial_reset <= 1'b0;
                end
                LP_SLV_CMD_LEVEL3_OFF: begin
                    stall         <= 1'b1;
                    partial_reset <= 1'b1;
                end
                default: begin
                    stall         <= 1'b1;
                    partial_reset <= 1'b0;
                end
            endcase
        end
    end

    // ack
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) mst_stg1_ack <= 1'b0;
        else if (mst_stg1_req && (mst_cmd == LP_SLV_CMD_ON)) mst_stg1_ack <= 1'b1;
        else if (mst_stg1_req) mst_stg1_ack <= trans_idle;
        else mst_stg1_ack <= 1'b0;
    end

    //===========================================================================
    // STG2 do fucking nothing
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) mst_stg2_ack <= 1'b0;
        else begin
            mst_stg2_ack <= mst_stg2_req;
        end
    end

endmodule

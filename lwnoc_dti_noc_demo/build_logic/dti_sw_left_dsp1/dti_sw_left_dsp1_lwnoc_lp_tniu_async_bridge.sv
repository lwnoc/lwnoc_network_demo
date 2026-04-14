/*
 * File: lwnoc_lp_tniu_async_bridge.sv
 * Project: lwnoc_lowpower_component
 * File Created: Wednesday, 27th August 2025 2:34:45 am
 * Author: Zou Zhili
 * -----
 * Description:
 *  lp tniu for async bridge
 * -----
 * Last Modified: Wednesday, 3rd September 2025 6:13:02 am
 * Modified By: Zou Zhili
 * -----
 * Copyright BeYourDad Co., Ltd.
 */

module lwnoc_lp_tniu_async_bridge
    import dti_sw_left_dsp1_lwnoc_lp_define_package::*;
    import dti_sw_left_dsp1_lwnoc_lp_struct_package::*;
(
    input  logic                                      clk,
    input  logic                                      rst_n,
    // LP NOC
    input  lwnoc_lp_req_signal_t                      rx_req,
    output lwnoc_lp_req_signal_t                      tx_req,
    // Function Ctrl
    output logic                                      stall_ptr,
    output logic                                      clear_ptr,
    input  logic                                      trans_idle,
    input  logic                                      full_zero
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
        .HAS_TIME_OUT  (0),
        .TIME_OUT_WIDTH(1)
    ) u_slv_protocol_convert (
        .clk         (clk),
        .rst_n       (rst_n),
        .timeout_val (1'b0),
        .rx_req      (rx_req),
        .tx_req      (tx_req),
        .mst_stg1_req(mst_stg1_req),
        .mst_stg1_ack(mst_stg1_ack),
        .mst_cmd     (mst_cmd),
        .mst_stg2_req(mst_stg2_req),
        .mst_stg2_ack(mst_stg2_ack)
    );

    //===========================================================================
    // STG1 control stall
    //===========================================================================
    // control stall
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            stall_ptr <= 1'b1;
        else if (mst_stg1_req) begin
            case (mst_cmd)
                LP_SLV_CMD_ON: begin
                    stall_ptr <= 1'b0;
                end
                LP_SLV_CMD_LEVEL1_OFF, LP_SLV_CMD_LEVEL2_OFF, LP_SLV_CMD_LEVEL3_OFF: begin
                    stall_ptr <= 1'b1;
                end
                default: begin
                    stall_ptr <= 1'b0;
                end
            endcase
        end
    end

    // ack
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            mst_stg1_ack <= 1'b0;
        else if (mst_stg1_req)
            mst_stg1_ack <= trans_idle;
        else
            mst_stg1_ack <= 1'b0;
    end

    //===========================================================================
    // STG2 control clear
    //===========================================================================
    // control clear
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            clear_ptr <= 1'b1;
        else if (mst_stg2_req) begin
            case (mst_cmd)
                LP_SLV_CMD_ON: begin
                    clear_ptr <= 1'b0;
                end
                LP_SLV_CMD_LEVEL1_OFF, LP_SLV_CMD_LEVEL2_OFF, LP_SLV_CMD_LEVEL3_OFF: begin
                    clear_ptr <= 1'b1;
                end
                default: begin
                    clear_ptr <= 1'b0;
                end
            endcase
        end
    end

    // ack
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) mst_stg2_ack <= 1'b0;
        else if (mst_stg2_req) mst_stg2_ack <= full_zero;
        else mst_stg2_ack <= 1'b0;
    end

endmodule

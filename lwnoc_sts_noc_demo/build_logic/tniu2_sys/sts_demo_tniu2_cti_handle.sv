module sts_demo_tniu2_cti_handle
import sts_demo_tniu2_lwnoc_sts_pack::*;
#(
    parameter integer unsigned SYNC_STAGE   = 2
) (
    input logic clk_src ,
    input logic clk_dst ,
    input logic rstn_src,
    input logic rstn_dst,

    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_in_req,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_in_ack,

    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_event_out_req,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_event_out_ack,

    input   logic [CTI_EVENT_WIDTH-1:0]     cti_channel_in,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_channel_in_req,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_channel_in_ack,

    output  logic [CTI_EVENT_WIDTH-1:0]     cti_channel_out,
    input   logic [CTI_EVENT_WIDTH-1:0]     cti_channel_out_req,
    output  logic [CTI_EVENT_WIDTH-1:0]     cti_channel_out_ack
);

    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTI_CHANNEL_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_channel_out_async (
        .clk_rx        (clk_src             ),
        .rstn_rx       (rstn_src            ),
        .pulse_in      (cti_channel_in      ),
        .pulse_req     (cti_channel_in_req  ),
        .pulse_ack     (cti_channel_in_ack  ),
        .clk_rx_qactive() //NC
    );

    pulse_async_bridge_transmitter_qactive #(
        .DATA_WIDTH   (CTI_CHANNEL_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_channel_in_async (
        .clk_tx        (clk_dst),
        .rstn_tx       (rstn_dst),
        .pulse_out     (cti_channel_out     ),
        .pulse_req     (cti_channel_out_req ),
        .pulse_ack     (cti_channel_out_ack ),
        .clk_tx_qactive() //NC
    );

    pulse_async_bridge_receiver_qactive #(
        .DATA_WIDTH   (CTI_CHANNEL_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_event_out_async (
        .clk_rx        (clk_src             ),
        .rstn_rx       (rstn_src            ),
        .pulse_in      (cti_event_in        ),
        .pulse_req     (cti_event_in_req    ),
        .pulse_ack     (cti_event_in_ack    ),
        .clk_rx_qactive() //NC
    );

    pulse_async_bridge_transmitter_qactive #(
        .DATA_WIDTH   (CTI_CHANNEL_WIDTH),
        .FF_SYNC_DEPTH(SYNC_STAGE)
    ) u_event_in_async (
        .clk_tx        (clk_dst             ),
        .rstn_tx       (rstn_dst            ),
        .pulse_out     (cti_event_out       ),
        .pulse_req     (cti_event_out_req   ),
        .pulse_ack     (cti_event_out_ack   ),
        .clk_tx_qactive() //NC
    );
endmodule

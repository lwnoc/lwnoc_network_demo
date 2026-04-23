module camera_ss_trig_ctrl
(
    input   logic clk,
    input   logic rst_n,

    output  logic sync_req_out,
    input   logic sync_req_in,
    input   logic sync_req_done,

    output  logic flush_req_out,
    input   logic flush_req_in,
    input   logic flush_req_done
);

    camera_ss_trig_ctrl_fsm u_sync_trig_fsm (
        .clk    (clk),
        .rst_n   (rst_n),
        .req_out(sync_req_out),
        .req_in (sync_req_in),
        .done   (sync_req_done)
    );

    camera_ss_trig_ctrl_fsm u_flush_trig_fsm (
        .clk    (clk),
        .rst_n   (rst_n),
        .req_out(flush_req_out),
        .req_in (flush_req_in),
        .done   (flush_req_done)
    );
    
endmodule
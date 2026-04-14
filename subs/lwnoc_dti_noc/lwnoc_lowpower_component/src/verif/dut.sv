module dut
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;
(
    input  logic                   clk_sys,
    input  logic                   clk_noc,
    input  logic                   rst_n_sys,
    input  logic                   rst_n_noc, 
    // P channel from rsc
    input  logic                   preq,
    input  lwnoc_pchannel_state_t  pstate,
    output lwnoc_pchannel_active_t pactive,
    output logic                   paccept,
    output logic                   pdeny

);

    //===========================================================================
    // Internal logic
    //===========================================================================
    lwnoc_lp_req_signal_t nest_rx_req_main;
    lwnoc_lp_req_signal_t nest_tx_req_main;
    lwnoc_lp_req_signal_t nest_rx_req_sub;
    lwnoc_lp_req_signal_t nest_tx_req_sub;

    lwnoc_lp_req_signal_t v_main_hub_rx_req         [5-1:0];
    lwnoc_lp_req_signal_t v_main_hub_tx_req         [5-1:0];

    lwnoc_lp_req_signal_t v_sub_hub_rx_req          [5-1:0];
    lwnoc_lp_req_signal_t v_sub_hub_tx_req          [5-1:0];

    lwnoc_lp_req_signal_t iniu_rx_req;
    lwnoc_lp_req_signal_t iniu_tx_req;

    lwnoc_lp_req_signal_t async_src_sys_side_rx_req;
    lwnoc_lp_req_signal_t async_src_sys_side_tx_req;

    lwnoc_lp_req_signal_t async_dst_sys_side_rx_req;
    lwnoc_lp_req_signal_t async_dst_sys_side_tx_req;

    lwnoc_lp_req_signal_t async_dst_noc_side_rx_req;
    lwnoc_lp_req_signal_t async_dst_noc_side_tx_req;

    lwnoc_lp_req_signal_t async_src_noc_side_rx_req;
    lwnoc_lp_req_signal_t async_src_noc_side_tx_req;

    lwnoc_lp_req_signal_t stall_logic_rx_req;
    lwnoc_lp_req_signal_t stall_logic_tx_req;

    lwnoc_lp_req_signal_t default_slave_rx_req;
    lwnoc_lp_req_signal_t default_slave_tx_req;
    logic                 default_slave_switch;
    logic                 default_slave_switch_done;

    lwnoc_lp_req_signal_t func_tniu_rx_req;
    lwnoc_lp_req_signal_t func_tniu_tx_req;
    //===========================================================================
    // Hub
    //===========================================================================
    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL(5)
    ) u_lp_main_hub (
        .clk(clk_sys),
        .rst_n(rst_n_sys),
        .v_rx_req(v_main_hub_rx_req),
        .v_tx_req(v_main_hub_tx_req)
    );

    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL(5)
    ) u_lp_sub_hub (
        .clk(clk_sys),
        .rst_n(rst_n_sys),
        .clk(clk_sys),
        .rst_n(rst_n_sys),
        .v_rx_req(v_sub_hub_rx_req),
        .v_tx_req(v_sub_hub_tx_req)
    );

    //===========================================================================
        .clk(clk_sys),
        .rst_n(rst_n_sys),
    // INIU
    //===========================================================================
    lwnoc_lp_iniu u_iniu (
        .clk    (clk_sys),
        .rst_n  (rst_n_sys),
        .rx_req (iniu_rx_req),
        .tx_req (iniu_tx_req),
        .preq   (preq),
        .pstate (pstate),
        .pactive(pactive),
        .paccept(paccept),
        .pdeny  (pdeny)
    );

    //===========================================================================
    // Async bridge src (sysside)
    //===========================================================================
    lwnoc_lp_tniu_async_bridge u_ab_src_sys_side (
        .clk       (clk_sys),
        .rst_n     (rst_n_sys),
        .rx_req    (async_src_sys_side_rx_req),
        .tx_req    (async_src_sys_side_tx_req),
        .stall_ptr (),
        .clear_ptr (),
        .trans_idle(1'b1),
        .full_zero (1'b1)
    );

    //===========================================================================
    // Async bridge dst (sysside)
    //===========================================================================
    lwnoc_lp_tniu_async_bridge u_ab_dst_sys_side (
        .clk       (clk_sys),
        .rst_n     (rst_n_sys),
        .rx_req    (async_dst_sys_side_rx_req),
        .tx_req    (async_dst_sys_side_tx_req),
        .stall_ptr (),
        .clear_ptr (),
        .trans_idle(1'b1),
        .full_zero (1'b1)
    );

    //===========================================================================
    // Async bridge src (nocside)
    //===========================================================================
    lwnoc_lp_tniu_async_bridge u_ab_src_noc_side (
        .clk       (clk_noc),
        .rst_n     (rst_n_noc),
        .rx_req    (async_src_noc_side_rx_req),
        .tx_req    (async_src_noc_side_tx_req),
        .stall_ptr (),
        .clear_ptr (),
        .trans_idle(1'b1),
        .full_zero (1'b1)
    );

    //===========================================================================
    // Async bridge dst (nocside)
    //===========================================================================
    lwnoc_lp_tniu_async_bridge u_ab_dst_noc_side (
        .clk       (clk_noc),
        .rst_n     (rst_n_noc),
        .rx_req    (async_dst_noc_side_rx_req),
        .tx_req    (async_dst_noc_side_tx_req),
        .stall_ptr (),
        .clear_ptr (),
        .trans_idle(1'b1),
        .full_zero (1'b1)
    );

    //===========================================================================
    // default slave
    //===========================================================================
    lwnoc_lp_tniu_default_slv #(
        .TIME_OUT_WIDTH(10)
    ) u_default_slv (
        .clk        (clk_noc),
        .rst_n      (rst_n_noc),
        .rx_req     (default_slave_rx_req),
        .tx_req     (default_slave_tx_req),
        .hard_switch(default_slave_hard_switch),
        .soft_switch(default_slave_soft_switch),
        .switch_done(default_slave_switch_done),
        .trans_idle (1'b1),
        .timeout_val(10'd100)
    );

    always_ff @(posedge clk_noc or negedge rst_n_noc) begin
        if (~rst_n_noc) begin
            default_slave_switch_done <= 1'b0;
        end else begin
            default_slave_switch_done <= default_slave_hard_switch|default_slave_soft_switch;
        end
    end

    //===========================================================================
    // Stall logic
    //===========================================================================
    lwnoc_lp_tniu_stall_logic #(
        .TIME_OUT_WIDTH(10)
    ) u_stall_logic (
        .clk        (clk_noc),
        .rst_n      (rst_n_noc),
        .rx_req     (stall_logic_rx_req),
        .tx_req     (stall_logic_tx_req),
        .stall      (),
        .trans_idle (1'b1),
        .timeout_val(10'd100)
    );

    //===========================================================================
    // function tniu
    //===========================================================================
    lwnoc_lp_tniu_func_tniu #(
        .TIME_OUT_WIDTH(10)
    ) u_func_tniu (
        .clk          (clk_noc),
        .rst_n        (rst_n_noc),
        .rx_req       (func_tniu_rx_req),
        .tx_req       (func_tniu_tx_req),
        .partial_reset(),
        .trans_idle   (1'b1),
        .timeout_val  (10'd100)
    );

    //===========================================================================
    // lp_nest
    //===========================================================================
    lwnoc_lp_nest u_lp_nest (
        .clk        (clk_sys),
        .rst_n      (rst_n_sys),
        .rx_req_main(nest_rx_req_main),
        .tx_req_main(nest_tx_req_main),
        .rx_req_sub (nest_rx_req_sub),
        .tx_req_sub (nest_tx_req_sub)
    );

    //===========================================================================
    // sub hub wiring
    //===========================================================================

    assign v_sub_hub_rx_req[0]       = async_src_sys_side_tx_req;
    assign async_src_sys_side_rx_req = v_sub_hub_tx_req[0];

    assign v_sub_hub_rx_req[1]       = async_dst_sys_side_tx_req;
    assign async_dst_sys_side_rx_req = v_sub_hub_tx_req[1];

    assign v_sub_hub_rx_req[2]       = async_dst_noc_side_tx_req;
    assign async_dst_noc_side_rx_req = v_sub_hub_tx_req[2];

    assign v_sub_hub_rx_req[3]       = async_src_noc_side_tx_req;
    assign async_src_noc_side_rx_req = v_sub_hub_tx_req[3];

    assign v_sub_hub_rx_req[4]       = nest_tx_req_sub;
    assign nest_rx_req_sub           = v_sub_hub_tx_req[4];

    //===========================================================================
    // main hub wiring
    //===========================================================================
    assign v_main_hub_rx_req[0]      = iniu_tx_req;
    assign iniu_rx_req               = v_main_hub_tx_req[0];

    assign v_main_hub_rx_req[1]      = default_slave_tx_req;
    assign default_slave_rx_req      = v_main_hub_tx_req[1];

    assign v_main_hub_rx_req[2]      = func_tniu_tx_req;
    assign func_tniu_rx_req          = v_main_hub_tx_req[2];

    assign v_main_hub_rx_req[3]      = nest_tx_req_main;
    assign nest_rx_req_main          = v_main_hub_tx_req[3];

    assign v_main_hub_rx_req[4]      = stall_logic_tx_req;
    assign stall_logic_rx_req        = v_main_hub_tx_req[4];

endmodule

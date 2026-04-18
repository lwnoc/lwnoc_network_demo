module intr_tniu_top_interrupt_tniu_aync_top_side

#(
    parameter integer unsigned ASYNC_FIFO_DEPTH = 10,
    parameter integer unsigned TIME_OUT_WIDTH = 10,
    localparam integer unsigned LP_REQ_WIDTH = $bits(lwnoc_lp_struct_package::lwnoc_lp_req_signal_t)
)(
    input  logic clk,
    input  logic rst_n,
    //async fifo interface
    output logic [ASYNC_FIFO_DEPTH-1:0] wptr_async,
    input  logic [ASYNC_FIFO_DEPTH-1:0] rptr_async,
    input  logic [ASYNC_FIFO_DEPTH-1:0] rptr_sync,
    output logic [40+8+8+4+1:0]         pld_sync,
    //lp interface
    input  logic [TIME_OUT_WIDTH-1:0] timeout_val,
    input  logic [LP_REQ_WIDTH-1:0]   lp_hub_rx_req,
    output logic [LP_REQ_WIDTH-1:0]   lp_hub_tx_req,
    input  logic [LP_REQ_WIDTH-1:0]   s_niu_lp_hub_rx_req,
    output logic [LP_REQ_WIDTH-1:0]   s_niu_lp_hub_tx_req,
    input  logic [LP_REQ_WIDTH-1:0]   s_async_master_hub_rx_req,
    output logic [LP_REQ_WIDTH-1:0]   s_async_master_hub_tx_req,
    input  logic                      req_valid,
    output logic                      req_ready,
    input  logic [39:0]               req_payload,
    input  logic [7:0]                req_srcid,
    input  logic [7:0]                req_tgtid,
    input  logic [3:0]                req_qos,
    input  logic                      req_last,
    output                            req_threshold
);
//===========================================================================
// logic declarations
//===========================================================================

    logic                                   req_ready_func              ;
    logic                                   ds_switch_done              ;
    logic                                   switch_ds                   ;
    logic                                   soft_switch_pending         ;

    logic                                   ds_hard_switch              ;
    logic                                   ds_soft_switch              ;
    logic                                   async_write_stall           ;
    logic                                   async_write_clear           ;
    logic                                   async_write_full_zero       ;
    logic                                   async_write_almost_full     ;
    logic [40+8+8+4+1-1                 :0] req_pld_vector              ;

    typedef lwnoc_lp_struct_package::lwnoc_lp_req_signal_t lwnoc_lp_req_signal_t;

    lwnoc_lp_req_signal_t                   lp_hub_rx_req_t             ;
    lwnoc_lp_req_signal_t                   lp_hub_tx_req_t             ;
    lwnoc_lp_req_signal_t                   s_niu_lp_hub_rx_req_t       ;
    lwnoc_lp_req_signal_t                   s_niu_lp_hub_tx_req_t       ;
    lwnoc_lp_req_signal_t                   s_async_master_hub_rx_req_t ;
    lwnoc_lp_req_signal_t                   s_async_master_hub_tx_req_t ;
    lwnoc_lp_req_signal_t                   barrier_lp_hub_rx_req       ;
    lwnoc_lp_req_signal_t                   barrier_lp_hub_tx_req       ;
    lwnoc_lp_req_signal_t                   barrier_lp_hub_rx_req_raw   ;
    lwnoc_lp_req_signal_t                   barrier_lp_sub_hub_rx_req   ;
    lwnoc_lp_req_signal_t                   barrier_lp_sub_hub_tx_req   ;
    lwnoc_lp_req_signal_t                   async_slave_hub_rx_req      ;
    lwnoc_lp_req_signal_t                   async_slave_hub_tx_req      ;
    lwnoc_lp_req_signal_t                   ds_lp_hub_rx_req            ;
    lwnoc_lp_req_signal_t                   ds_lp_hub_tx_req            ;

    lwnoc_lp_req_signal_t                   v_stage_1_hub_rx_req    [3:0];
    lwnoc_lp_req_signal_t                   v_stage_1_hub_tx_req    [3:0];
    lwnoc_lp_req_signal_t                   v_stage_2_hub_rx_req    [2:0];
    lwnoc_lp_req_signal_t                   v_stage_2_hub_tx_req    [2:0];

//===========================================================================
// lp
//===========================================================================
    assign lp_hub_rx_req_t             = lwnoc_lp_req_signal_t'(lp_hub_rx_req);
    assign lp_hub_tx_req               = lp_hub_tx_req_t;
    assign s_niu_lp_hub_rx_req_t       = lwnoc_lp_req_signal_t'(s_niu_lp_hub_rx_req);
    assign s_niu_lp_hub_tx_req         = s_niu_lp_hub_tx_req_t;
    assign s_async_master_hub_rx_req_t = lwnoc_lp_req_signal_t'(s_async_master_hub_rx_req);
    assign s_async_master_hub_tx_req   = s_async_master_hub_tx_req_t;

    assign v_stage_1_hub_rx_req[0]  = lp_hub_rx_req_t;
    assign v_stage_1_hub_rx_req[1]  = s_niu_lp_hub_rx_req_t;
    assign v_stage_1_hub_rx_req[2]  = barrier_lp_hub_rx_req;
    assign v_stage_1_hub_rx_req[3]  = ds_lp_hub_rx_req;

    assign lp_hub_tx_req_t          = v_stage_1_hub_tx_req[0];
    assign s_niu_lp_hub_tx_req_t    = v_stage_1_hub_tx_req[1];
    assign barrier_lp_hub_tx_req    = v_stage_1_hub_tx_req[2];
    assign ds_lp_hub_tx_req         = v_stage_1_hub_tx_req[3];

    assign barrier_lp_hub_rx_req = barrier_lp_hub_rx_req_raw;

    assign v_stage_2_hub_rx_req[0]  = barrier_lp_sub_hub_rx_req;
    assign v_stage_2_hub_rx_req[1]  = async_slave_hub_rx_req;
    assign v_stage_2_hub_rx_req[2]  = s_async_master_hub_rx_req_t;

    assign barrier_lp_sub_hub_tx_req= v_stage_2_hub_tx_req[0];
    assign async_slave_hub_tx_req   = v_stage_2_hub_tx_req[1];
    assign s_async_master_hub_tx_req_t = v_stage_2_hub_tx_req[2];

    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL       (4                          )
    ) u_stage_1_hub (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .v_rx_req           (v_stage_1_hub_rx_req       ),
        .v_tx_req           (v_stage_1_hub_tx_req       )
    );

    lwnoc_lp_tniu_default_slv #(
        .TIME_OUT_WIDTH     (TIME_OUT_WIDTH             )
    )u_lwnoc_lp_tniu_default_slv(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (ds_lp_hub_tx_req           ),
        .tx_req             (ds_lp_hub_rx_req           ),

        .hard_switch        (ds_hard_switch             ),
        .soft_switch        (ds_soft_switch             ),
        .switch_done        (ds_switch_done             ),
        .trans_idle         (1'b1                       ),
        .timeout_val        (timeout_val + TIME_OUT_WIDTH'(32))
    );

    lwnoc_lp_nest u_lwnoc_lp_nest(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req_main        (barrier_lp_hub_tx_req      ),
        .tx_req_main        (barrier_lp_hub_rx_req_raw  ),
        .rx_req_sub         (barrier_lp_sub_hub_tx_req  ),
        .tx_req_sub         (barrier_lp_sub_hub_rx_req  )

    );


    lwnoc_lp_hub_wrapper #(
        .NUM_TERMINAL       (3                          )
    ) u_stage_2_hub (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .v_rx_req           (v_stage_2_hub_rx_req       ),
        .v_tx_req           (v_stage_2_hub_tx_req       )
    );


    lwnoc_lp_tniu_async_bridge u_slv_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (async_slave_hub_tx_req     ),
        .tx_req             (async_slave_hub_rx_req     ),

        .stall_ptr          (async_write_stall          ),
        .clear_ptr          (async_write_clear          ),
        .trans_idle         (1'b1                       ),
        .full_zero          (async_write_full_zero      )
    );

//===========================================================================
// ds
//===========================================================================
    assign ds_switch_done = switch_ds;
    assign req_ready = switch_ds ? 1'b1 : req_ready_func;
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            soft_switch_pending <= 1'b0;
        end
        else if(ds_hard_switch)begin
            soft_switch_pending <= 1'b0;
        end
        else if(ds_soft_switch)begin
            soft_switch_pending <= 1'b1;
        end
        else if(~ds_soft_switch && ~ds_hard_switch && switch_ds)begin
            soft_switch_pending <= 1'b0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            switch_ds <= 1'b0;
        end
        else if(ds_hard_switch)begin
            switch_ds <= 1'b1;
        end
        else if((ds_soft_switch || soft_switch_pending) && ~req_valid)begin
            switch_ds <= 1'b1;
        end
        else if(~ds_soft_switch && ~ds_hard_switch)begin
            switch_ds <= 1'b0;
        end
    end
//===========================================================================
// async fifo
//===========================================================================
    assign req_pld_vector = {req_payload,req_srcid,req_tgtid,req_qos,req_last};
    fcip_afifo_slv #(
        .DATA_WIDTH         (40+8+8+4+1           ),
        .FIFO_DEPTH         (ASYNC_FIFO_DEPTH     )
    ) u_intr_async_fifo (
        .clk               (clk                    ),
        .rst_n             (rst_n                  ),
        .stall             (async_write_stall      ),
        .clear             (async_write_clear      ),
        .full_zero         (async_write_full_zero  ),
        .almost_full       (async_write_almost_full),

        .s_vld             (req_valid              ),
        .s_pld             (req_pld_vector         ),
        .s_rdy             (req_ready_func         ),

        .wptr_async        (wptr_async             ),

        .rptr_async        (rptr_async             ),
        .rptr_sync         (rptr_sync              ),
        .pld_sync          (pld_sync               )
    );



endmodule

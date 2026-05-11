module dsp_ss_tniu_interrupt_tniu_async_top_side

    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
    import dsp_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned ASYNC_FIFO_DEPTH = `dsp_ss_tniu_INTR_TNIU_TOP_ASYNC_FIFO_DEPTH    ,
    parameter integer unsigned TIME_OUT_WIDTH   = `dsp_ss_tniu_INTR_TNIU_TIME_OUT_WIDTH           ,
    localparam integer unsigned PLD_ORG_WIDTH   = 40+8+8+4+1,
    localparam integer unsigned ECC_CODE_WIDTH  = ($clog2(PLD_ORG_WIDTH)+PLD_ORG_WIDTH+1 <= 2**$clog2(PLD_ORG_WIDTH))? $clog2(PLD_ORG_WIDTH) : $clog2(PLD_ORG_WIDTH)+1,
    localparam integer unsigned ECC_OVERHEAD    = ECC_CODE_WIDTH + 1,
    localparam integer unsigned PLD_ECC_WIDTH   = PLD_ORG_WIDTH + ECC_OVERHEAD,
    localparam integer unsigned FIFO_DATA_WIDTH = PLD_ECC_WIDTH

)(
    input  logic                                    clk                             ,
    input  logic                                    rst_n                           ,
    //async fifo interface
    output logic [ASYNC_FIFO_DEPTH-1            :0] wptr_async                      ,
    input  logic [ASYNC_FIFO_DEPTH-1            :0] rptr_async                      ,
    input  logic [ASYNC_FIFO_DEPTH-1            :0] rptr_sync                       ,
    output logic [FIFO_DATA_WIDTH                :0] pld_sync                        ,
    //lp interface
    input  logic [TIME_OUT_WIDTH-1              :0] timeout_val                     ,

    input  lwnoc_lp_req_signal_t                    s_async_master_hub_rx_req       ,
    output lwnoc_lp_req_signal_t                    s_async_master_hub_tx_req       ,


    input  logic                                    req_valid                       ,
    output logic                                    req_ready                       ,
    input  logic [39                            :0] req_payload                     ,
    input  logic [7                             :0] req_srcid                       ,
    input  logic [7                             :0] req_tgtid                       ,
    input  logic [3                             :0] req_qos                         ,
    input  logic                                    req_last                        ,
    output                                          req_threshold


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

    lwnoc_lp_req_signal_t                   async_slave_hub_rx_req      ;
    lwnoc_lp_req_signal_t                   async_slave_hub_tx_req      ;
    lwnoc_lp_req_signal_t                   ds_lp_hub_rx_req            ;
    lwnoc_lp_req_signal_t                   ds_lp_hub_tx_req            ;

    lwnoc_lp_req_signal_t                   v_stage_2_hub_rx_req    [2:0];
    lwnoc_lp_req_signal_t                   v_stage_2_hub_tx_req    [2:0];

//===========================================================================
// lp port 0-connect with tniu sys side
// lp port 1-connect with async bridge slave
// lp port 2-connect with ds lp hub
//===========================================================================

    assign v_stage_2_hub_rx_req[0]  = s_async_master_hub_rx_req;
    assign v_stage_2_hub_rx_req[1]  = async_slave_hub_rx_req;
    assign v_stage_2_hub_rx_req[2]  = ds_lp_hub_rx_req;

    assign s_async_master_hub_tx_req= v_stage_2_hub_tx_req[0];
    assign async_slave_hub_tx_req   = v_stage_2_hub_tx_req[1];
    assign ds_lp_hub_tx_req         = v_stage_2_hub_tx_req[2];

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
    assign req_threshold  = 1'b1;
    assign req_pld_vector = {req_payload,req_srcid,req_tgtid,req_qos,req_last};
    logic [FIFO_DATA_WIDTH-1:0] req_pld_ecc;
    fcip_ecc_enc #(.DATA_WIDTH(PLD_ORG_WIDTH)) u_req_afifo_ecc_enc (
        .data       (req_pld_vector ),
        .encode_data(req_pld_ecc    )
    );
    fcip_afifo_slv #(
        .DATA_WIDTH         (FIFO_DATA_WIDTH       ),
        .FIFO_DEPTH         (ASYNC_FIFO_DEPTH     )
    ) u_intr_async_fifo (
        .clk               (clk                    ),
        .rst_n             (rst_n                  ),
        .stall             (async_write_stall      ),
        .clear             (async_write_clear      ),
        .full_zero         (async_write_full_zero  ),
        .almost_full       (async_write_almost_full),

        .s_vld             (req_valid              ),
    .s_pld             (req_pld_ecc            ),
        .s_rdy             (req_ready_func         ),

        .wptr_async        (wptr_async             ),

        .rptr_async        (rptr_async             ),
        .rptr_sync         (rptr_sync              ),
        .pld_sync          (pld_sync               )
    );



endmodule

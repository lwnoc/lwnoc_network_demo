module interrupt_iniu_async_top_side

    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
    import interrupt_iniu_pkg::*;
#(
    parameter integer unsigned ASYNC_FIFO_DEPTH = 16

)(
    input  logic                                    clk                             ,
    input  logic                                    rst_n                           ,
    //async fifo interface
    input  logic [ASYNC_FIFO_DEPTH-1            :0] wptr_async                      ,
    output logic [ASYNC_FIFO_DEPTH-1            :0] rptr_async                      ,
    output logic [ASYNC_FIFO_DEPTH-1            :0] rptr_sync                       ,
    input  logic [40+8+8+4+1                    :0] pld_sync                        ,
    //lp interface

    output lwnoc_lp_req_signal_t                    m_async_master_hub_rx_req       ,
    input  lwnoc_lp_req_signal_t                    m_async_master_hub_tx_req       ,

    output logic                                    req_valid                       ,
    input  logic                                    req_ready                       ,
    output logic [39                            :0] req_payload                     ,
    output logic [7                             :0] req_srcid                       ,
    output logic [7                             :0] req_tgtid                       ,
    output logic [3                             :0] req_qos                         ,
    output logic                                    req_last                        ,
    input  logic                                    req_threshold


);
//===========================================================================
// logic declarations
//===========================================================================
    logic                                    resp_valid;
    logic                                    resp_ready;
    logic [40+8+8+4+1-1                  :0] resp_pld_vector;

    logic                                    async_stall;
    logic                                    async_clear;
    logic                                    async_idle;
    logic                                    async_full_zero;
    logic                                    async_almost_empty;
//===========================================================================
// package
//===========================================================================

    assign req_valid            = resp_valid;
    assign resp_ready           = req_ready;
    assign req_last             = resp_pld_vector[0];
    assign req_qos              = resp_pld_vector[4:1];
    assign req_tgtid            = resp_pld_vector[12:5];
    assign req_srcid            = resp_pld_vector[20:13];
    assign req_payload          = resp_pld_vector[60:21];
//===========================================================================
// lp
//===========================================================================
    lwnoc_lp_tniu_async_bridge u_mst_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (m_async_master_hub_tx_req  ),
        .tx_req             (m_async_master_hub_rx_req  ),

        .stall_ptr          (async_stall                ),
        .clear_ptr          (async_clear                ),
        .trans_idle         (async_idle                 ),
        .full_zero          (async_full_zero            )
    );



//===========================================================================
// async fifo
//===========================================================================
    fcip_afifo_mst #(
        .DATA_WIDTH         (40+8+8+4+1             ),
        .FIFO_DEPTH         (ASYNC_FIFO_DEPTH       )
    ) u_intr_async_fifo (
        .clk                (clk                    ),
        .rst_n              (rst_n                  ),
        .stall              (async_stall            ),
        .clear              (async_clear            ),
        .full_zero          (async_full_zero        ),
        .idle               (async_idle             ),
        .almost_empty       (async_almost_empty     ),

        .m_vld              (resp_valid             ),
        .m_pld              (resp_pld_vector        ),
        .m_rdy              (resp_ready             ),

        .wptr_async         (wptr_async             ),

        .rptr_async         (rptr_async             ),
        .rptr_sync          (rptr_sync              ),
        .pld_sync           (pld_sync               )
    );



endmodule

module noc_ss_iniu_interrupt_iniu_async_top_side

    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
    import noc_ss_iniu_interrupt_iniu_pkg::*;
#(
    parameter integer unsigned ASYNC_FIFO_DEPTH  = `noc_ss_iniu_INTR_INIU_TOP_ASYNC_FIFO_DEPTH,
    parameter logic            FUSA_ECC_EN       = `noc_ss_iniu_INTR_INIU_FUSA_ECC_EN,
    parameter integer unsigned ERR_INT_CNT_WIDTH = `noc_ss_iniu_INTR_INIU_ERR_INT_CNT_WIDTH,
    localparam integer unsigned PLD_ORG_WIDTH     = 40+8+8+4+1,
    localparam integer unsigned ECC_CODE_WIDTH    = ($clog2(PLD_ORG_WIDTH)+PLD_ORG_WIDTH+1 <= 2**$clog2(PLD_ORG_WIDTH))? $clog2(PLD_ORG_WIDTH) : $clog2(PLD_ORG_WIDTH)+1,
    localparam integer unsigned ECC_OVERHEAD      = ECC_CODE_WIDTH + 1,
    localparam integer unsigned PLD_ECC_WIDTH     = PLD_ORG_WIDTH + ECC_OVERHEAD,
    localparam integer unsigned FIFO_DATA_WIDTH   = PLD_ECC_WIDTH,
    localparam int LP_SIG_WIDTH = $bits(lwnoc_lp_req_signal_t)

)(
    input  logic                                    clk                             ,
    input  logic                                    rst_n                           ,
    //async fifo interface
    input  logic [ASYNC_FIFO_DEPTH-1            :0] wptr_async                      ,
    output logic [ASYNC_FIFO_DEPTH-1            :0] rptr_async                      ,
    output logic [ASYNC_FIFO_DEPTH-1            :0] rptr_sync                       ,
    input  logic [FIFO_DATA_WIDTH                :0] pld_sync                        ,
    output logic                                    afifo_sb_err                     ,
    output logic                                    afifo_db_err                     ,
    //lp interface

    output logic [LP_SIG_WIDTH-1:0]                 m_async_master_hub_rx_req       ,
    input  logic [LP_SIG_WIDTH-1:0]                 m_async_master_hub_tx_req       ,

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
    logic [FIFO_DATA_WIDTH-1            :0] afifo_mst_pld;

    logic                                    async_stall;
    logic                                    async_clear;
    logic                                    async_idle;
    logic                                    async_full_zero;
    logic                                    async_almost_empty;
    lwnoc_lp_req_signal_t                   m_async_master_hub_rx_req_typed;
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
    // LP type casts (ports are flat vectors)
    assign m_async_master_hub_rx_req = m_async_master_hub_rx_req_typed;
//===========================================================================
// lp
//===========================================================================
    lwnoc_lp_tniu_async_bridge u_mst_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (lwnoc_lp_req_signal_t'(m_async_master_hub_tx_req)  ),
        .tx_req             (m_async_master_hub_rx_req_typed                    ),

        .stall_ptr          (async_stall                ),
        .clear_ptr          (async_clear                ),
        .trans_idle         (async_idle                 ),
        .full_zero          (async_full_zero            )
    );



//===========================================================================
// async fifo
//===========================================================================
    fcip_afifo_mst #(
        .DATA_WIDTH         (FIFO_DATA_WIDTH        ),
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
        .m_pld              (afifo_mst_pld          ),
        .m_rdy              (resp_ready             ),

        .wptr_async         (wptr_async             ),

        .rptr_async         (rptr_async             ),
        .rptr_sync          (rptr_sync              ),
        .pld_sync           (pld_sync               )
    );

    logic ecc_sb_err_raw;
    logic ecc_db_err_raw;
    fcip_ecc_dec #(.DATA_WIDTH(PLD_ORG_WIDTH)) u_rsp_afifo_ecc_dec (
        .encode_data(afifo_mst_pld   ),
        .data       (resp_pld_vector ),
        .sb_err     (ecc_sb_err_raw  ),
        .db_err     (ecc_db_err_raw  )
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_sb (
        .clk(clk), .rst_n(rst_n), .err_in(ecc_sb_err_raw), .intr_out(afifo_sb_err)
    );
    fcip_fusa_pulse_gen #(.CNT_WIDTH(ERR_INT_CNT_WIDTH)) u_pulse_db (
        .clk(clk), .rst_n(rst_n), .err_in(ecc_db_err_raw), .intr_out(afifo_db_err)
    );



endmodule

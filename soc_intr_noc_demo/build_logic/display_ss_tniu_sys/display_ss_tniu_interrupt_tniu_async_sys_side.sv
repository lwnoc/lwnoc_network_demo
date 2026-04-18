module display_ss_tniu_interrupt_tniu_aync_sys_side

    import display_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned INTERRUPT_NUM = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM),
    parameter integer unsigned TIME_OUT_WIDTH = 10,
    parameter integer unsigned ASYNC_FIFO_DEPTH = 10,
    localparam integer unsigned LP_REQ_WIDTH = $bits(lwnoc_lp_struct_package::lwnoc_lp_req_signal_t)
)(
    input  logic clk,
    input  logic rst_n,
    // interrupt interface
    input  logic [NIU_ID_WIDTH-1:0]     tniu_tgt_id,
    output logic [INTERRUPT_NUM-1:0]    v_interrupt,
    output logic [INTERRUPT_NUM/32-1:0] v_merge_interrupt,
    // apb interface
	input  logic [31:0] p_addr,
	input  logic        p_sel,
	input  logic        p_enable,
	input  logic        p_write,
	input  logic [31:0] p_wdata,
	output logic        p_ready,
	output logic [31:0] p_rdata,
	output logic        p_slverr,
    //async fifo interface
    input  logic [ASYNC_FIFO_DEPTH-1:0] wptr_async,
    output logic [ASYNC_FIFO_DEPTH-1:0] rptr_async,
    output logic [ASYNC_FIFO_DEPTH-1:0] rptr_sync,
    input  logic [40+8+8+4+1:0]         pld_sync,
    //lp interface
    input  logic [TIME_OUT_WIDTH-1:0] timeout_val,
    output logic [LP_REQ_WIDTH-1:0]   m_async_master_hub_rx_req,
    input  logic [LP_REQ_WIDTH-1:0]   m_async_master_hub_tx_req,
    output logic [LP_REQ_WIDTH-1:0]   m_niu_lp_hub_rx_req,
    input  logic [LP_REQ_WIDTH-1:0]   m_niu_lp_hub_tx_req
);

//===========================================================================
// logic declarations
//===========================================================================
    logic                                   req_valid                   ;
    logic                                   req_ready                   ;
    logic [39                           :0] req_payload                 ;
    logic [7                            :0] req_srcid                   ;
    logic [7                            :0] req_tgtid                   ;
    logic [3                            :0] req_qos                     ;
    logic                                   req_last                    ;
    logic                                   req_threshold               ;

    logic                                   resp_valid                  ;
    logic                                   resp_ready                  ;
    logic [40+8+8+4+1-1                 :0] resp_pld_vector             ;

    logic                                   async_stall                 ;
    logic                                   async_clear                 ;
    logic                                   async_idle                  ;
    logic                                   async_full_zero             ;
    logic                                   async_almost_empty          ;

    logic                                   niu_partical_rst            ;
    logic                                   niu_idle                    ;

    logic [INTERRUPT_NUM_WIDTH-1        :0] mem_addr                    ;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] mem_din                     ;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] mem_dout                    ;
    logic                                   mem_en                      ;
    logic                                   mem_wren                    ;

    typedef lwnoc_lp_struct_package::lwnoc_lp_req_signal_t lwnoc_lp_req_signal_t;

    lwnoc_lp_req_signal_t                   m_niu_lp_hub_rx_req_t       ;
    lwnoc_lp_req_signal_t                   m_niu_lp_hub_tx_req_t       ;

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


    lwnoc_lp_tniu_func_tniu #(
        .TIME_OUT_WIDTH     (TIME_OUT_WIDTH             )
    ) u_intr_lp_tniu(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),

        .rx_req             (m_niu_lp_hub_tx_req_t      ),
        .tx_req             (m_niu_lp_hub_rx_req_t      ),

        .partial_reset      (niu_partical_rst           ),
        .trans_idle         (niu_idle                   ),
        .timeout_val        (timeout_val + TIME_OUT_WIDTH'(32))
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
//===========================================================================
// niu
//===========================================================================
    assign m_niu_lp_hub_rx_req         = m_niu_lp_hub_rx_req_t;
    assign m_niu_lp_hub_tx_req_t       = lwnoc_lp_req_signal_t'(m_niu_lp_hub_tx_req);


    display_ss_tniu_interrupt_tniu #(
        .INTERRUPT_NUM  (INTERRUPT_NUM          )
    )u_interrupt_tniu (
        .clk            (clk                            ),
        .rst_n          (rst_n                          ),

        .tniu_tgt_id    (tniu_tgt_id                    ),

        .req_valid      (req_valid                      ),
        .req_ready      (req_ready                      ),
        .req_payload    (req_payload                    ),
        .req_srcid      (req_srcid                      ),
        .req_tgtid      (req_tgtid                      ),
        .req_qos        (req_qos                        ),
        .req_last       (req_last                       ),
        .req_threshold  (req_threshold                  ),

        .p_addr         (p_addr                         ),
        .p_sel          (p_sel                          ),
        .p_enable       (p_enable                       ),
        .p_write        (p_write                        ),
        .p_wdata        (p_wdata                        ),
        .p_ready        (p_ready                        ),
        .p_rdata        (p_rdata                        ),
        .p_slverr       (p_slverr                       ),

        .v_interrupt    (v_interrupt                    ),
        .v_merge_interrupt(v_merge_interrupt            ),

        .addr           (mem_addr                       ),
        .din            (mem_din                        ),
        .dout           (mem_dout                       ),
        .en             (mem_en                         ),
        .wren           (mem_wren                       ),

        .partial_rst    (niu_partical_rst               ),
        .idle           (niu_idle                       )
    );


    generate
        if(INTERRUPT_NUM==4096)begin
            display_ss_tniu_spram_4096x20 u_sp_4096_20 (
                .clk        (clk            ),
                .en         (mem_en         ),
                .addr       (mem_addr       ),
                .rd_data    (mem_dout       ),
                .wr_data    (mem_din        ),
                .wr_bit_en  (1'b1           ),
                .wr_en      (mem_wren       )
            );
        end
        else if(INTERRUPT_NUM==2048)begin
            display_ss_tniu_spram_2048x20 u_sp_2048_20 (
                .clk        (clk            ),
                .en         (mem_en         ),
                .addr       (mem_addr       ),
                .rd_data    (mem_dout       ),
                .wr_data    (mem_din        ),
                .wr_bit_en  (1'b1           ),
                .wr_en      (mem_wren       )
            );
        end
        else if(INTERRUPT_NUM==1024)begin
            display_ss_tniu_spram_1024x20 u_sp_1024_20 (
                .clk        (clk            ),
                .en         (mem_en         ),
                .addr       (mem_addr       ),
                .rd_data    (mem_dout       ),
                .wr_data    (mem_din        ),
                .wr_bit_en  (1'b1           ),
                .wr_en      (mem_wren       )
            );
        end
        else if(INTERRUPT_NUM==512)begin
            display_ss_tniu_spram_512x20 u_sp_512_20 (
                .clk        (clk            ),
                .en         (mem_en         ),
                .addr       (mem_addr       ),
                .rd_data    (mem_dout       ),
                .wr_data    (mem_din        ),
                .wr_bit_en  (1'b1           ),
                .wr_en      (mem_wren       )
            );
        end
        else if(INTERRUPT_NUM==256)begin
            display_ss_tniu_spram_256x20 u_sp_256_20 (
                .clk        (clk            ),
                .en         (mem_en         ),
                .addr       (mem_addr       ),
                .rd_data    (mem_dout       ),
                .wr_data    (mem_din        ),
                .wr_bit_en  (1'b1           ),
                .wr_en      (mem_wren       )
            );
        end
        else if(INTERRUPT_NUM==128)begin
            display_ss_tniu_spram_128x20 u_sp_128_20 (
                .clk        (clk            ),
                .en         (mem_en         ),
                .addr       (mem_addr       ),
                .rd_data    (mem_dout       ),
                .wr_data    (mem_din        ),
                .wr_bit_en  (1'b1           ),
                .wr_en      (mem_wren       )
            );
        end
    endgenerate





endmodule

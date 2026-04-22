module debug_ss_iniu_interrupt_iniu_lut
    import debug_ss_iniu_interrupt_iniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                                        clk,
    input  logic                                        rst_n,

    // input  logic [NIU_ID_WIDTH-1                :0]     iniu_src_id,

    input  logic                                        event_req_vld,
    output logic                                        event_req_rdy,
    input  recorder_pkg                                 event_req_pld,

    input  logic                                        apb_w_req_vld,
    output logic                                        apb_w_req_rdy,
    input  logic [INTERRUPT_NUM_WIDTH-1         :0]     apb_w_req_addr,
    input  logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1  :0]     apb_w_req_data,

    input  logic                                        apb_r_req_vld,
    output logic                                        apb_r_req_rdy,
    input  logic [INTERRUPT_NUM_WIDTH-1         :0]     apb_r_req_addr,

    output logic                                        apb_resp_vld,
    input  logic                                        apb_resp_rdy,
    output logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1  :0]     apb_resp_data,

    output logic                                        event_resp_vld,
    input  logic                                        event_resp_rdy,
    output lut_pkg                                      event_resp_pld,


    //mem port
    output logic [INTERRUPT_NUM_WIDTH-1         :0]     addr,
    output logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1  :0]     din,
    input  logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1  :0]     dout,
    output logic                                        en,
    output logic                                        wren

    // //lowpower
    // input  logic                                        stall,
    // input  logic                                        clear,
    // output logic                                        idle

);

//===========================================================================
// logic declarations
    logic                                   read_req_vld;
//===========================================================================

    logic                                   memory_req_vld;
    logic                                   memory_req_rdy;
    logic                                   read_req_rdy;
    logic                                   read_resp_rdy;
    logic                                   read_resp_vld;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] read_resp_data;
    logic [INTERRUPT_NUM_WIDTH-1        :0] read_req_addr;
    logic [$bits(event_apb_arb_pkg)-1   :0] read_req_sideband_vec;
    logic [$bits(event_apb_arb_pkg)-1   :0] read_resp_sideband_vec;

    event_apb_arb_pkg                       read_resp_sideband;
    event_apb_arb_pkg                       event_arb_pld;
    event_apb_arb_pkg                       apb_arb_pld;
    event_apb_arb_pkg                       memory_req_pld;

//===========================================================================
// fix arbiter
//===========================================================================
    assign event_arb_pld.srcid = 1'(EVENT_REQ);
    assign event_arb_pld.toggle_flag = event_req_pld.toggle_flag;
    assign event_arb_pld.overflow = event_req_pld.overflow;
    assign event_arb_pld.addr = event_req_pld.intr_addr;

    assign apb_arb_pld.srcid = 1'(APB_REQ);
    assign apb_arb_pld.toggle_flag = 1'b0;
    assign apb_arb_pld.overflow = 1'b0;
    assign apb_arb_pld.addr = apb_r_req_addr;

    fcip_fix_arb #(
        .PLD_TYPE       (event_apb_arb_pkg      )
    )u_fcip_fix_arb(
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        .s_vld_priority (event_req_vld          ),
        .s_rdy_priority (event_req_rdy          ),
        .s_pld_priority (event_arb_pld          ),

        .s_vld          (apb_r_req_vld          ),
        .s_rdy          (apb_r_req_rdy          ),
        .s_pld          (apb_arb_pld            ),

        .m_vld          (memory_req_vld         ),
        .m_rdy          (memory_req_rdy         ),
        .m_pld          (memory_req_pld         )
    );


//===========================================================================
// fake 2p memory
//===========================================================================
    assign read_req_vld = memory_req_vld;
    assign memory_req_rdy = read_req_rdy;
    assign read_req_addr = INTERRUPT_NUM_WIDTH'(memory_req_pld.addr);
    assign read_req_sideband_vec = memory_req_pld;
    fcip_mem_fake_2p_mem #(
        .SRAM_REQ_PIPE_STAGE(0                          ),
        .SRAM_RSP_PIPE_STAGE(0                          ),
        .DATA_WIDTH         (NIU_ID_WIDTH+INTR_ID_WIDTH ),
        .ADDR_WIDTH         (INTERRUPT_NUM_WIDTH        ),
        .WRITE_BUFFER_SIZE  (0                          ),
        .READ_BUFFER_SIZE   (8                          ),
        .SIDEBAND_WIDTH     ($bits(event_apb_arb_pkg)   ),
        .READ_FORWARD_EN    (0                          )
    ) u_mem_fake_2p_mem (
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        .write_req_vld  (apb_w_req_vld          ),
        .write_req_data (apb_w_req_data         ),
        .write_req_addr (apb_w_req_addr         ),
        .write_req_rdy  (apb_w_req_rdy          ),
        .write_req_bit_en({(NIU_ID_WIDTH+INTR_ID_WIDTH){1'b1}}),

        .read_req_vld   (read_req_vld           ),
        .read_req_addr  (read_req_addr          ),
        .read_req_rdy   (read_req_rdy           ),
        .read_req_sideband(read_req_sideband_vec),

        .read_resp_vld  (read_resp_vld          ),
        .read_resp_data (read_resp_data         ),
        .read_resp_rdy  (read_resp_rdy          ),
        .read_resp_sideband(read_resp_sideband_vec),

        .spram_addr     (addr                   ),
        .spram_din      (din                    ),
        .spram_dout     (dout                   ),
        .spram_en       (en                     ),
        .spram_wren     (wren                   ),
        .spram_bit_en   (                       ),

        .stall          (1'b0                   ),
        .clear          (1'b0                   ),
        .idle           (                       )
    );

    assign read_resp_sideband = event_apb_arb_pkg'(read_resp_sideband_vec);
    assign read_resp_rdy = ((read_resp_sideband.srcid == APB_REQ)&&apb_resp_rdy) || ((read_resp_sideband.srcid == EVENT_REQ)&&event_resp_rdy);
//===========================================================================
// apb response
//===========================================================================

    assign apb_resp_vld = (read_resp_sideband.srcid == APB_REQ) && read_resp_vld;
    assign apb_resp_data = read_resp_data;

//===========================================================================
// event output
//===========================================================================
    assign event_resp_vld = (read_resp_sideband.srcid == EVENT_REQ) && read_resp_vld;
    // assign event_resp_pld.src_id = iniu_src_id;
    assign event_resp_pld.src_intr_id = INTR_ID_WIDTH'(read_resp_sideband.addr);
    assign event_resp_pld.tgt_id = read_resp_sideband.overflow ? OVERFLOW_TGT_ID : read_resp_data[19:12];
    assign event_resp_pld.tgt_intr_id = read_resp_sideband.overflow ? OVERFLOW_TGT_INTR_ID : read_resp_data[11:0];
    assign event_resp_pld.toggle_flag = read_resp_sideband.toggle_flag;
    assign event_resp_pld.internal_init = read_resp_sideband.overflow;


endmodule

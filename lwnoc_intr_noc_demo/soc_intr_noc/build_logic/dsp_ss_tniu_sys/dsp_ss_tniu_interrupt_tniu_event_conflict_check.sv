module dsp_ss_tniu_interrupt_tniu_event_conflict_check
    import dsp_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                                        clk,
    input  logic                                        rst_n,

    input  logic                                        event_req_vld,
    output logic                                        event_req_rdy,
    input  event_pkg                                    event_req_pld,

    input  logic                                        apb_r_req_vld,
    output logic                                        apb_r_req_rdy,
    input  logic [INTERRUPT_NUM_WIDTH-1         :0]     apb_r_req_addr,

    output logic                                        apb_resp_vld,
    input  logic                                        apb_resp_rdy,
    output logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1  :0]     apb_resp_data,

    output logic                                        conflict_check_en,
    output event_pkg                                    conflict_check_pld,

    output logic                                        conflict_flag_en,
    output logic [31                            :0]     conflict_message,


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
//===========================================================================

    logic                                   event_resp_vld;
    logic                                   event_resp_rdy;
    logic                                   event_resp_en;
    logic                                   event_write_vld;
    logic                                   event_write_rdy;
    logic                                   event_write_en;
    logic                                   event_read_vld;
    logic                                   event_read_rdy;
    logic                                   event_read_en;
    logic                                   read_resp_vld;
    logic                                   read_resp_rdy;
    logic                                   event_rs_vld;
    logic                                   event_rs_rdy;

    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] event_write_data;
    logic [INTERRUPT_NUM_WIDTH-1        :0] event_write_addr;
    logic [$bits(event_apb_arb_pkg)-1   :0] read_req_sideband_vec;
    logic [$bits(event_apb_arb_pkg)-1   :0] read_resp_sideband_vec;
    logic [INTERRUPT_NUM-1              :0] event_sram_en;
    logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1 :0] read_resp_data;
    logic [INTERRUPT_NUM_WIDTH-1        :0] read_req_addr;

    event_apb_arb_pkg                       event_arb_pld;
    event_apb_arb_pkg                       event_rs_pld;
    event_apb_arb_pkg                       apb_arb_pld;
    event_apb_arb_pkg                       read_req_pld;
    event_apb_arb_pkg                       read_resp_sideband;
    event_pkg                               read_req_event_pld;

//===========================================================================
// event wr rd internal logic
//===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            event_sram_en <= {INTERRUPT_NUM{1'b0}};
        end
        else if(event_write_vld && event_write_rdy)begin
            event_sram_en[INTERRUPT_NUM_WIDTH'(event_req_pld.tgt_intr_id)] <= 1'b1;
        end

    end

    assign event_write_vld = event_req_vld && ~event_sram_en[INTERRUPT_NUM_WIDTH'(event_req_pld.tgt_intr_id)] ;

    assign event_read_vld = event_req_vld && event_sram_en[INTERRUPT_NUM_WIDTH'(event_req_pld.tgt_intr_id)];


    assign event_write_en = event_write_vld && event_write_rdy;
    assign event_read_en = event_read_vld && event_read_rdy;

    assign event_req_rdy = event_write_en || event_read_en;

//===========================================================================
// fix arbiter
//===========================================================================
    assign event_arb_pld.srcid = 1'(EVENT_REQ);
    // assign event_arb_pld.tgt_id = event_req_pld.tgt_id;
    assign event_arb_pld.tgt_intr_id = event_req_pld.tgt_intr_id;
    assign event_arb_pld.src_id = event_req_pld.src_id;
    assign event_arb_pld.src_intr_id = event_req_pld.src_intr_id;
    assign event_arb_pld.toggle_flag = event_req_pld.toggle_flag;
    assign event_arb_pld.context_id = event_req_pld.context_id;

    assign apb_arb_pld.srcid = 1'(APB_REQ);
    // assign apb_arb_pld.tgt_id = 0;
    assign apb_arb_pld.tgt_intr_id = apb_r_req_addr;
    assign apb_arb_pld.src_id = 0;
    assign apb_arb_pld.src_intr_id = 0;
    assign apb_arb_pld.toggle_flag = event_sram_en[INTERRUPT_NUM_WIDTH'(apb_r_req_addr)];
    assign apb_arb_pld.context_id = 0;

    fcip_reg_slice #(
        .PLD_TYPE       (event_apb_arb_pkg      )
    ) u_event_rs (
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        .s_vld          (event_read_vld         ),
        .s_rdy          (event_read_rdy         ),
        .s_pld          (event_arb_pld          ),

        .m_vld          (event_rs_vld           ),
        .m_rdy          (event_rs_rdy           ),
        .m_pld          (event_rs_pld           )
    );


    fcip_fix_arb #(
        .PLD_TYPE       (event_apb_arb_pkg      )
    )u_fcip_fix_arb(
        .clk            (clk                    ),
        .rst_n          (rst_n                  ),

        .s_vld_priority (event_rs_vld           ),
        .s_rdy_priority (event_rs_rdy           ),
        .s_pld_priority (event_rs_pld           ),

        .s_vld          (apb_r_req_vld          ),
        .s_rdy          (apb_r_req_rdy          ),
        .s_pld          (apb_arb_pld            ),

        .m_vld          (read_req_vld           ),
        .m_rdy          (read_req_rdy           ),
        .m_pld          (read_req_pld           )
    );

//===========================================================================
// fake 2p memory
//===========================================================================

    assign read_req_addr = INTERRUPT_NUM_WIDTH'(read_req_pld.tgt_intr_id);
    assign read_req_sideband_vec = read_req_pld;
    assign event_write_data = {event_req_pld.src_id, event_req_pld.src_intr_id};
    assign event_write_addr = INTERRUPT_NUM_WIDTH'(event_req_pld.tgt_intr_id);
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

        .write_req_vld  (event_write_vld          ),
        .write_req_data (event_write_data         ),
        .write_req_addr (event_write_addr         ),
        .write_req_rdy  (event_write_rdy          ),
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
    assign read_resp_rdy = ((read_resp_sideband.srcid == EVENT_REQ) && event_resp_rdy) || ((read_resp_sideband.srcid == APB_REQ) && apb_resp_rdy);
//===========================================================================
// apb response
//===========================================================================

    assign apb_resp_vld = (read_resp_sideband.srcid == APB_REQ) && read_resp_vld;

    assign apb_resp_data = (apb_resp_vld && read_resp_sideband.toggle_flag) ? read_resp_data : '0;

//===========================================================================
// event response
//===========================================================================

    assign event_resp_vld = (read_resp_sideband.srcid == EVENT_REQ) && read_resp_vld;
    assign event_resp_rdy = ~event_write_en;
    assign event_resp_en = event_resp_vld && event_resp_rdy;

    assign conflict_flag_en = |({read_resp_sideband.src_id,read_resp_sideband.src_intr_id} ^ read_resp_data) && event_resp_en;
    assign conflict_message = {8'b0,read_resp_sideband.src_id,4'b0,read_resp_sideband.src_intr_id};

    // assign read_req_event_pld.tgt_id = read_resp_sideband.tgt_id;
    assign read_req_event_pld.tgt_intr_id = read_resp_sideband.tgt_intr_id;
    assign read_req_event_pld.src_id = read_resp_sideband.src_id;
    assign read_req_event_pld.src_intr_id = read_resp_sideband.src_intr_id;
    assign read_req_event_pld.toggle_flag = read_resp_sideband.toggle_flag;
    assign read_req_event_pld.context_id = read_resp_sideband.context_id;

    assign conflict_check_en = event_write_en || event_resp_en;
    assign conflict_check_pld = event_write_en ? event_req_pld : read_req_event_pld;

endmodule

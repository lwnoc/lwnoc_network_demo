module mcu_ss_tniu_interrupt_tniu_xbar_internal
    import mcu_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                                        clk,
    input  logic                                        rst_n,

    input  logic                                        ecc_vld,
    output logic                                        ecc_rdy,
    input  ecc_pkg                                      ecc_pld,

    input  logic                                        context_pre_alloc_vld,
    output logic                                        context_pre_alloc_rdy,
    input  [CONTEXT_NUM_WIDTH-1:0]                      context_pre_alloc_id,

    output logic                                        internal_interrupt_tgt_id_vld,
    input  logic                                        internal_interrupt_tgt_id_rdy,
    output [31:0]                                       internal_interrupt_tgt_id_wdat,

    output logic                                        internal_interrupt_overflow_vld,
    input  logic                                        internal_interrupt_overflow_rdy,
    output [31:0]                                       internal_interrupt_overflow_wdat,

    output logic                                        inernal_interrupt_tgt_intr_id_vld,
    input  logic                                        inernal_interrupt_tgt_intr_id_rdy,
    output [31:0]                                       inernal_interrupt_tgt_intr_id_wdat,

    output logic                                        event_interrupt_vld,
    input  logic                                        event_interrupt_rdy,
    output event_pkg                                    event_interrupt_pld
);



    assign ecc_rdy = (internal_interrupt_tgt_id_vld && internal_interrupt_tgt_id_rdy) ||
                     (internal_interrupt_overflow_vld && internal_interrupt_overflow_rdy) ||
                     (inernal_interrupt_tgt_intr_id_vld && inernal_interrupt_tgt_intr_id_rdy) ||
                     (event_interrupt_vld && event_interrupt_rdy);

    assign internal_interrupt_tgt_id_vld = ecc_vld && (ecc_pld.tgt_intr_id == INTERNAL_TGT_ID_ERROR_ID);
    assign internal_interrupt_tgt_id_wdat = {8'b0,ecc_pld.src_id,4'b0,ecc_pld.src_intr_id};
    assign internal_interrupt_overflow_vld = ecc_vld && (ecc_pld.tgt_intr_id == INTERNAL_OVERFLOW_ERROR_ID);
    assign internal_interrupt_overflow_wdat = {8'b0,ecc_pld.src_id,4'b0,ecc_pld.src_intr_id};

    assign inernal_interrupt_tgt_intr_id_vld = ecc_vld && ( ((ecc_pld.tgt_intr_id < INTERNAL_INTR_NUM) && ~ecc_pld.internal_init) ||
                                                          (ecc_pld.tgt_intr_id >= INTERRUPT_NUM) );
    assign inernal_interrupt_tgt_intr_id_wdat = {8'b0,ecc_pld.src_id,4'b0,ecc_pld.src_intr_id};

    assign event_interrupt_vld = context_pre_alloc_vld && ecc_vld && ~internal_interrupt_tgt_id_vld && ~internal_interrupt_overflow_vld && ~inernal_interrupt_tgt_intr_id_vld;
    assign context_pre_alloc_rdy = event_interrupt_vld && event_interrupt_rdy;

    // assign event_interrupt_pld.tgt_id = ecc_pld.tgt_id;
    assign event_interrupt_pld.tgt_intr_id = ecc_pld.tgt_intr_id;
    assign event_interrupt_pld.src_id = ecc_pld.src_id;
    assign event_interrupt_pld.src_intr_id = ecc_pld.src_intr_id;
    assign event_interrupt_pld.toggle_flag = ecc_pld.toggle_flag;
    assign event_interrupt_pld.context_id = context_pre_alloc_id;



endmodule

module npu_ss_tniu_interrupt_tniu_generate_reg_bank
    import npu_ss_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
	input  logic                            clk                             ,
	input  logic                            rst_n                           ,
	input  logic [31                    :0] p_addr                          ,
	input  logic                            p_sel                           ,
	input  logic                            p_enable                        ,
	input  logic                            p_write                         ,
	input  logic [31                    :0] p_wdata                         ,
	output logic                            p_ready                         ,
	output logic [31                    :0] p_rdata                         ,
	output logic                            p_slverr                        ,

    input  logic [INTERRUPT_NUM-1       :0] intr_raw_status                 ,
    output logic [INTERRUPT_NUM-1       :0] intr_merge_mask                 ,
    output logic [INTERRUPT_NUM-1       :0] intr_pulse_mode                 ,
    output logic [INTERRUPT_NUM-1       :0] intr_set                        ,
    output logic [INTERRUPT_NUM-1       :0] intr_clr                        ,

    // Parity error: set on read-back parity mismatch
    output logic                            parity_err

);

    //===========================================================================
    // logic declarations
    //===========================================================================

    logic                           wreq_vld;
    logic [31               :0]     wreq_data;
    logic [31               :0]     wreq_addr;
    logic [31               :0]     rack_data;
    logic [31               :0]     rreq_addr;

    //===========================================================================
    // read request handling
    //===========================================================================
    assign p_ready = 1'b1; // always ready to accept requests
    assign p_rdata = rack_data;
    assign p_slverr = 1'b0; // no slave error
    assign rreq_addr = p_addr;

    always_comb begin
        rack_data = 32'hfffffffe;
        for (int i = 0; i < INTERRUPT_NUM/32; i=i+1) begin
        // raw intr
            if (rreq_addr == (INTR_RAW_BASE_ADDR + i * 4))begin
                rack_data = intr_raw_status[i*32 +: 32];
            end
        // merge mask info
            else if (rreq_addr == (INTR_MERGE_MASK_BASE_ADDR + i * 4))begin
                rack_data = intr_merge_mask[i*32 +: 32];
            end
        // pulse mode info
            else if (rreq_addr == (INTR_PULSE_MODE_BASE_ADDR + i * 4))begin
                rack_data = intr_pulse_mode[i*32 +: 32];
            end
        end
    end


    //===========================================================================
    // write request handling
    //===========================================================================
    assign wreq_vld = p_write && p_sel && p_enable;
    assign wreq_data = p_wdata;
    assign wreq_addr = p_addr;

    generate
        for(genvar i = 0; i < INTERRUPT_NUM/32; i=i+1) begin : gen_intr_mask
            logic        parity_bit;
            logic        parity_err_i;
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    intr_merge_mask[i*32 +: 32] <= 32'h0;
                    parity_bit                  <= 1'b0;
                    parity_err_i                <= 1'b0;
                end
                else if (p_write && p_sel && p_enable &&
                         (p_addr == (INTR_MERGE_MASK_BASE_ADDR + i * 4))) begin
                    intr_merge_mask[i*32 +: 32] <= p_wdata;
                    parity_bit                  <= ^p_wdata;
                end
                else if (~p_write && p_sel && p_enable &&
                         (p_addr == (INTR_MERGE_MASK_BASE_ADDR + i * 4))) begin
                    if (^intr_merge_mask[i*32 +: 32] != parity_bit) begin
                        parity_err_i <= 1'b1;
                    end
                end
            end
        end

        for(genvar i = 0; i < INTERRUPT_NUM/32; i=i+1) begin : gen_intr_set
            assign intr_set[i*32 +: 32] = (wreq_vld && (wreq_addr == (INTR_SET_BASE_ADDR + i * 4))) ? wreq_data : 32'h0;
            assign intr_clr[i*32 +: 32] = (wreq_vld && (wreq_addr == (INTR_CLR_BASE_ADDR + i * 4))) ? wreq_data : 32'h0;
        end

        for(genvar i = 0; i < INTERRUPT_NUM/32; i=i+1) begin : gen_intr_pulse_mode
            logic        parity_bit;
            logic        parity_err_i;
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    intr_pulse_mode[i*32 +: 32] <= 32'h0;
                    parity_bit                  <= 1'b0;
                    parity_err_i                <= 1'b0;
                end
                else if (p_write && p_sel && p_enable &&
                         (p_addr == (INTR_PULSE_MODE_BASE_ADDR + i * 4))) begin
                    intr_pulse_mode[i*32 +: 32] <= p_wdata;
                    parity_bit                  <= ^p_wdata;
                end
                else if (~p_write && p_sel && p_enable &&
                         (p_addr == (INTR_PULSE_MODE_BASE_ADDR + i * 4))) begin
                    if (^intr_pulse_mode[i*32 +: 32] != parity_bit) begin
                        parity_err_i <= 1'b1;
                    end
                end
            end
        end

        // OR tree: collect all per-instance parity_err_i bits
        logic [2*INTERRUPT_NUM/32-1:0] parity_err_all;
        for (genvar i = 0; i < INTERRUPT_NUM/32; i++) begin : gen_parity_or
            assign parity_err_all[i]                    = gen_intr_mask[i].parity_err_i;
            assign parity_err_all[INTERRUPT_NUM/32 + i] = gen_intr_pulse_mode[i].parity_err_i;
        end
    endgenerate

    assign parity_err = |parity_err_all;

endmodule

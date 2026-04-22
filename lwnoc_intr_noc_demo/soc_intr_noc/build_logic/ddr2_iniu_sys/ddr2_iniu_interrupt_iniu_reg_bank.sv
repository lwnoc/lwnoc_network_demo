module ddr2_iniu_interrupt_iniu_reg_bank
    import ddr2_iniu_interrupt_iniu_pkg::*;
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

    output logic [INTERRUPT_NUM-1       :0] intr_lut_sram_enable            ,
    output logic [INTERRUPT_NUM-1       :0] intr_pulse_mode                 ,

    input  logic                            apb_w_req_rdy                   ,
    output logic                            apb_w_req_vld                   ,
    output logic [INTERRUPT_NUM_WIDTH-1 :0] apb_w_req_addr                  ,
    output logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1:0] apb_w_req_data            ,

    input  logic                            apb_r_req_rdy                   ,
    output logic                            apb_r_req_vld                   ,
    output logic [INTERRUPT_NUM_WIDTH-1 :0] apb_r_req_addr                  ,

    input  logic                            apb_r_ack_vld                   ,
    output logic                            apb_r_ack_rdy                   ,
    input  logic [NIU_ID_WIDTH+INTR_ID_WIDTH-1:0] apb_r_ack_data
);

    //===========================================================================
    // logic declarations
    //===========================================================================
    logic           wreq_vld;
    logic           wreq_rdy;
    logic           paddr_lut_en;
    logic           rreq_vld;
    logic           rreq_rdy;
    logic           default_ready;

    //===========================================================================
    // APB interface signals
    //===========================================================================

    assign p_ready = ~paddr_lut_en ? default_ready  :
                      p_write     ? wreq_rdy       : rreq_rdy;
    always_comb begin
        automatic logic [31:0] rdata_pulse;
        rdata_pulse = 32'hfffffffe;
        for (int unsigned i = 0; i < INTERRUPT_NUM/32; i++) begin
            if (p_addr == (INTR_PULSE_MODE_BASE_ADDR + 32'(i*4)))
                rdata_pulse = intr_pulse_mode[i*32 +: 32];
        end
        if (paddr_lut_en)
            p_rdata = {8'b0,apb_r_ack_data[19:12],4'b0,apb_r_ack_data[11:0]};
        else
            p_rdata = rdata_pulse;
    end
	assign p_slverr = 1'b0;

    assign default_ready = p_sel && p_enable && ~paddr_lut_en;
    //===========================================================================
    // wreq
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            wreq_vld <= 1'b0;
        end
        else if (p_sel && ~p_enable && p_write && paddr_lut_en) begin
            wreq_vld <= 1'b1;
        end
        else if (apb_w_req_vld && apb_w_req_rdy) begin
            wreq_vld <= 1'b0;
        end
    end
    assign wreq_rdy = apb_w_req_rdy;


    //===========================================================================
    // rreq
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rreq_vld <= 1'b0;
        end
        else if (p_sel && ~p_enable && ~p_write && paddr_lut_en) begin //early read vld
            rreq_vld <= 1'b1;
        end
        else if(apb_r_req_vld && apb_r_req_rdy)begin
            rreq_vld <= 1'b0;
        end
    end
    assign rreq_rdy = apb_r_ack_vld && apb_r_ack_rdy;

    //===========================================================================
    // memory interface signals
    //===========================================================================

    assign apb_w_req_vld = wreq_vld;
    assign apb_w_req_data = {p_wdata[23:16],p_wdata[11:0]};
    assign apb_w_req_addr = INTERRUPT_NUM_WIDTH'((p_addr - INTR_LUT_BASE_ADDR) >> 2);


    assign apb_r_req_vld = rreq_vld;
    assign apb_r_req_addr = INTERRUPT_NUM_WIDTH'((p_addr - INTR_LUT_BASE_ADDR) >> 2);
    assign apb_r_ack_rdy = 1'b1;
    //===========================================================================
    // paddr protection
    //===========================================================================

    assign paddr_lut_en = (p_addr >= INTR_LUT_BASE_ADDR) &&
                         (p_addr <  INTR_LUT_BASE_ADDR + 4*INTERRUPT_NUM);

    //===========================================================================
    // address sram enable
    //===========================================================================

`ifndef VERILATOR
    generate
        for(genvar i = 0; i < INTERRUPT_NUM; i=i+1) begin : gen_intr_lut_sram_enable
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    intr_lut_sram_enable[i] <= 1'b0;
                end
                else if((p_addr == INTR_LUT_BASE_ADDR + 4*i) && (wreq_vld && wreq_rdy)) begin
                    intr_lut_sram_enable[i] <= 1'b1;
                end
            end
        end
    endgenerate
`endif

    // pulse mode CSR: 1=pulse, 0=level (default)
    generate
        for(genvar i = 0; i < INTERRUPT_NUM/32; i=i+1) begin : gen_intr_pulse_mode
            always_ff @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    intr_pulse_mode[i*32 +: 32] <= 32'h0;
                end
                else if (p_write && p_sel && p_enable &&
                         (p_addr == (INTR_PULSE_MODE_BASE_ADDR + 32'(i*4)))) begin
                    intr_pulse_mode[i*32 +: 32] <= p_wdata;
                end
            end
        end
    endgenerate




endmodule

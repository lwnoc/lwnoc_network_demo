module intr_tniu_top_interrupt_tniu_mem_reg_bank
    import intr_tniu_top_interrupt_tniu_pkg::*;
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
    logic           paddr_en;
    logic           rreq_vld;
    logic           rreq_rdy;
    logic           default_ready;

    //===========================================================================
    // APB interface signals
    //===========================================================================

    assign p_ready = paddr_en ? rreq_rdy : default_ready;
    assign p_rdata = paddr_en ? {8'b0,apb_r_ack_data[19:12],4'b0,apb_r_ack_data[11:0]} : 32'hfffffffe;
	assign p_slverr = 1'b0;

    assign default_ready = p_sel && p_enable && ~paddr_en;
    //===========================================================================
    // rreq
    //===========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rreq_vld <= 1'b0;
        end
        else if (p_sel && ~p_enable && ~p_write && paddr_en) begin //early read vld
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

    assign apb_r_req_vld = rreq_vld;
    assign apb_r_req_addr = INTERRUPT_NUM_WIDTH'((p_addr - INTR_CONFLICT_BASE_ADDR) >> 2);
    assign apb_r_ack_rdy = 1'b1;
    //===========================================================================
    // paddr protection
    //===========================================================================

    always_comb begin
        if((p_addr >= INTR_CONFLICT_BASE_ADDR) && (p_addr < INTR_CONFLICT_BASE_ADDR + 4*INTERRUPT_NUM)) begin
            paddr_en = 1'b1;
        end
        else begin
            paddr_en = 1'b0;
        end
    end

endmodule

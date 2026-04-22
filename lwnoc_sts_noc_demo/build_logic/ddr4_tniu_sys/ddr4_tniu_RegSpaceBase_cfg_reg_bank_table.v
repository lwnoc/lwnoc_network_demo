//[UHDL]Content Start [md5:b9fdf66badafe795cefc04a1c9f598d2]
module ddr4_tniu_RegSpaceBase_cfg_reg_bank_table (
	input         clk                                 ,
	input         rst_n                               ,
	input  [15:0] p_addr                              ,
	input         p_sel                               ,
	input         p_enable                            ,
	input         p_write                             ,
	input  [31:0] p_wdata                             ,
	input  [3:0]  p_strb                              ,
	output        p_ready                             ,
	output [31:0] p_rdata                             ,
	output        p_slverr                            ,
	output [31:0] debug_en_debug_en_rdat              ,
	output [31:0] timing_bus1_timing_bus1_rdat        ,
	output [31:0] timing_bus2_timing_bus2_rdat        ,
	output [31:0] timing_bus3_timing_bus3_rdat        ,
	output [31:0] debug_data_gate_debug_data_gate_rdat);

	//Wire define for this module.
	wire [15:0] rreq_addr                      ;
	wire [0:0]  rreq_vld                       ;
	wire [0:0]  rreq_rdy                       ;
	reg  [31:0] rack_data                      ;
	reg  [0:0]  rack_vld                       ;
	wire [0:0]  rack_rdy                       ;
	wire [15:0] wreq_addr                      ;
	wire [31:0] wreq_data                      ;
	wire [0:0]  wreq_vld                       ;
	reg  [0:0]  wreq_rdy                       ;
	wire [31:0] debug_en_rdat                  ;
	wire [0:0]  debug_en_rrdy                  ;
	wire [0:0]  debug_en_rvld                  ;
	wire [31:0] debug_en_wdat                  ;
	wire [0:0]  debug_en_wrdy                  ;
	wire [0:0]  debug_en_wvld                  ;
	reg  [31:0] debug_en_debug_en              ;
	wire [31:0] timing_bus1_rdat               ;
	wire [0:0]  timing_bus1_rrdy               ;
	wire [0:0]  timing_bus1_rvld               ;
	wire [31:0] timing_bus1_wdat               ;
	wire [0:0]  timing_bus1_wrdy               ;
	wire [0:0]  timing_bus1_wvld               ;
	reg  [31:0] timing_bus1_timing_bus1        ;
	wire [31:0] timing_bus2_rdat               ;
	wire [0:0]  timing_bus2_rrdy               ;
	wire [0:0]  timing_bus2_rvld               ;
	wire [31:0] timing_bus2_wdat               ;
	wire [0:0]  timing_bus2_wrdy               ;
	wire [0:0]  timing_bus2_wvld               ;
	reg  [31:0] timing_bus2_timing_bus2        ;
	wire [31:0] timing_bus3_rdat               ;
	wire [0:0]  timing_bus3_rrdy               ;
	wire [0:0]  timing_bus3_rvld               ;
	wire [31:0] timing_bus3_wdat               ;
	wire [0:0]  timing_bus3_wrdy               ;
	wire [0:0]  timing_bus3_wvld               ;
	reg  [31:0] timing_bus3_timing_bus3        ;
	wire [31:0] debug_data_gate_rdat           ;
	wire [0:0]  debug_data_gate_rrdy           ;
	wire [0:0]  debug_data_gate_rvld           ;
	wire [31:0] debug_data_gate_wdat           ;
	wire [0:0]  debug_data_gate_wrdy           ;
	wire [0:0]  debug_data_gate_wvld           ;
	reg  [31:0] debug_data_gate_debug_data_gate;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign rreq_addr = p_addr;

	assign rreq_vld = ((!p_write) && p_sel);

	assign rreq_rdy = (rack_rdy && rack_vld);

	always @(*) begin
	    if((rreq_addr == 16'h0)) rack_data = debug_en_rdat;
	    else if((rreq_addr == 16'h4)) rack_data = timing_bus1_rdat;
	    else if((rreq_addr == 16'h8)) rack_data = timing_bus2_rdat;
	    else if((rreq_addr == 16'hc)) rack_data = timing_bus3_rdat;
	    else if((rreq_addr == 16'h10)) rack_data = debug_data_gate_rdat;
	    else rack_data = 32'hfffffffe;
	end

	always @(*) begin
	    if((rreq_addr == 16'h0)) rack_vld = debug_en_rrdy;
	    else if((rreq_addr == 16'h4)) rack_vld = timing_bus1_rrdy;
	    else if((rreq_addr == 16'h8)) rack_vld = timing_bus2_rrdy;
	    else if((rreq_addr == 16'hc)) rack_vld = timing_bus3_rrdy;
	    else if((rreq_addr == 16'h10)) rack_vld = debug_data_gate_rrdy;
	    else rack_vld = 1'b0;
	end

	assign rack_rdy = ((!p_write) && p_sel && p_enable);

	assign wreq_addr = p_addr;

	assign wreq_data = {(p_wdata[31:24] & ({8{p_strb[3:3]}})), (p_wdata[23:16] & ({8{p_strb[2:2]}})), (p_wdata[15:8] & ({8{p_strb[1:1]}})), (p_wdata[7:0] & ({8{p_strb[0:0]}}))};

	assign wreq_vld = (p_write && p_sel && (!p_enable));

	always @(*) begin
	    if((wreq_addr == 16'h0)) wreq_rdy = debug_en_wrdy;
	    else if((wreq_addr == 16'h4)) wreq_rdy = timing_bus1_wrdy;
	    else if((wreq_addr == 16'h8)) wreq_rdy = timing_bus2_wrdy;
	    else if((wreq_addr == 16'hc)) wreq_rdy = timing_bus3_wrdy;
	    else if((wreq_addr == 16'h10)) wreq_rdy = debug_data_gate_wrdy;
	    else wreq_rdy = 1'b0;
	end

	assign p_ready = 1'b1;

	assign p_rdata = rack_data;

	assign p_slverr = 1'b0;

	assign debug_en_rdat = {debug_en_debug_en};

	assign debug_en_rrdy = 1'b1;

	assign debug_en_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 16'h0));

	assign debug_en_wdat = wreq_data[31:0];

	assign debug_en_wrdy = 1'b1;

	assign debug_en_wvld = (wreq_vld && (wreq_addr == 16'h0));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) debug_en_debug_en <= 32'b0;
	    else begin
	        if((debug_en_wvld)) debug_en_debug_en <= debug_en_wdat[31:0];
	    end
	end

	assign debug_en_debug_en_rdat = debug_en_debug_en;

	assign timing_bus1_rdat = {timing_bus1_timing_bus1};

	assign timing_bus1_rrdy = 1'b1;

	assign timing_bus1_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 16'h4));

	assign timing_bus1_wdat = wreq_data[31:0];

	assign timing_bus1_wrdy = 1'b1;

	assign timing_bus1_wvld = (wreq_vld && (wreq_addr == 16'h4));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus1_timing_bus1 <= 32'b0;
	    else begin
	        if((timing_bus1_wvld)) timing_bus1_timing_bus1 <= timing_bus1_wdat[31:0];
	    end
	end

	assign timing_bus1_timing_bus1_rdat = timing_bus1_timing_bus1;

	assign timing_bus2_rdat = {timing_bus2_timing_bus2};

	assign timing_bus2_rrdy = 1'b1;

	assign timing_bus2_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 16'h8));

	assign timing_bus2_wdat = wreq_data[31:0];

	assign timing_bus2_wrdy = 1'b1;

	assign timing_bus2_wvld = (wreq_vld && (wreq_addr == 16'h8));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus2_timing_bus2 <= 32'b0;
	    else begin
	        if((timing_bus2_wvld)) timing_bus2_timing_bus2 <= timing_bus2_wdat[31:0];
	    end
	end

	assign timing_bus2_timing_bus2_rdat = timing_bus2_timing_bus2;

	assign timing_bus3_rdat = {timing_bus3_timing_bus3};

	assign timing_bus3_rrdy = 1'b1;

	assign timing_bus3_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 16'hc));

	assign timing_bus3_wdat = wreq_data[31:0];

	assign timing_bus3_wrdy = 1'b1;

	assign timing_bus3_wvld = (wreq_vld && (wreq_addr == 16'hc));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus3_timing_bus3 <= 32'b0;
	    else begin
	        if((timing_bus3_wvld)) timing_bus3_timing_bus3 <= timing_bus3_wdat[31:0];
	    end
	end

	assign timing_bus3_timing_bus3_rdat = timing_bus3_timing_bus3;

	assign debug_data_gate_rdat = {debug_data_gate_debug_data_gate};

	assign debug_data_gate_rrdy = 1'b1;

	assign debug_data_gate_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 16'h10));

	assign debug_data_gate_wdat = wreq_data[31:0];

	assign debug_data_gate_wrdy = 1'b1;

	assign debug_data_gate_wvld = (wreq_vld && (wreq_addr == 16'h10));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) debug_data_gate_debug_data_gate <= 32'b0;
	    else begin
	        if((debug_data_gate_wvld)) debug_data_gate_debug_data_gate <= debug_data_gate_wdat[31:0];
	    end
	end

	assign debug_data_gate_debug_data_gate_rdat = debug_data_gate_debug_data_gate;


	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:b9fdf66badafe795cefc04a1c9f598d2]

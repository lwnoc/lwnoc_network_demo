//[UHDL]Content Start [md5:e79b5adbd2a42fafd8d54f3bec104e8f]
module cpu_ss_tniu_Regbank_regbank_tniu_internal_intr (
	input         clk                                                ,
	input         rst_n                                              ,
	input  [31:0] paddr                                              ,
	input         psel                                               ,
	input         penable                                            ,
	input         pwrite                                             ,
	input  [31:0] pwdata                                             ,
	output        pready                                             ,
	output [31:0] prdata                                             ,
	output        pslverr                                            ,
	input  [31:0] internal_intr_message_0_internal_intr_message_wdat ,
	input         internal_intr_message_0_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_1_internal_intr_message_wdat ,
	input         internal_intr_message_1_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_2_internal_intr_message_wdat ,
	input         internal_intr_message_2_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_3_internal_intr_message_wdat ,
	input         internal_intr_message_3_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_4_internal_intr_message_wdat ,
	input         internal_intr_message_4_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_5_internal_intr_message_wdat ,
	input         internal_intr_message_5_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_6_internal_intr_message_wdat ,
	input         internal_intr_message_6_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_7_internal_intr_message_wdat ,
	input         internal_intr_message_7_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_8_internal_intr_message_wdat ,
	input         internal_intr_message_8_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_9_internal_intr_message_wdat ,
	input         internal_intr_message_9_internal_intr_message_wena ,
	input  [31:0] internal_intr_message_10_internal_intr_message_wdat,
	input         internal_intr_message_10_internal_intr_message_wena,
	input  [31:0] internal_intr_message_11_internal_intr_message_wdat,
	input         internal_intr_message_11_internal_intr_message_wena,
	input  [31:0] internal_intr_message_12_internal_intr_message_wdat,
	input         internal_intr_message_12_internal_intr_message_wena,
	input  [31:0] internal_intr_message_13_internal_intr_message_wdat,
	input         internal_intr_message_13_internal_intr_message_wena,
	input  [31:0] internal_intr_message_14_internal_intr_message_wdat,
	input         internal_intr_message_14_internal_intr_message_wena,
	input  [31:0] internal_intr_message_15_internal_intr_message_wdat,
	input         internal_intr_message_15_internal_intr_message_wena,
	input  [31:0] internal_intr_message_16_internal_intr_message_wdat,
	input         internal_intr_message_16_internal_intr_message_wena,
	input  [31:0] internal_intr_message_17_internal_intr_message_wdat,
	input         internal_intr_message_17_internal_intr_message_wena,
	input  [31:0] internal_intr_message_18_internal_intr_message_wdat,
	input         internal_intr_message_18_internal_intr_message_wena,
	input  [31:0] internal_intr_message_19_internal_intr_message_wdat,
	input         internal_intr_message_19_internal_intr_message_wena,
	input  [31:0] internal_intr_message_20_internal_intr_message_wdat,
	input         internal_intr_message_20_internal_intr_message_wena,
	input  [31:0] internal_intr_message_21_internal_intr_message_wdat,
	input         internal_intr_message_21_internal_intr_message_wena,
	input  [31:0] internal_intr_message_22_internal_intr_message_wdat,
	input         internal_intr_message_22_internal_intr_message_wena,
	input  [31:0] internal_intr_message_23_internal_intr_message_wdat,
	input         internal_intr_message_23_internal_intr_message_wena,
	input  [31:0] internal_intr_message_24_internal_intr_message_wdat,
	input         internal_intr_message_24_internal_intr_message_wena,
	input  [31:0] internal_intr_message_25_internal_intr_message_wdat,
	input         internal_intr_message_25_internal_intr_message_wena,
	input  [31:0] internal_intr_message_26_internal_intr_message_wdat,
	input         internal_intr_message_26_internal_intr_message_wena,
	input  [31:0] internal_intr_message_27_internal_intr_message_wdat,
	input         internal_intr_message_27_internal_intr_message_wena,
	input  [31:0] internal_intr_message_28_internal_intr_message_wdat,
	input         internal_intr_message_28_internal_intr_message_wena,
	input  [31:0] internal_intr_message_29_internal_intr_message_wdat,
	input         internal_intr_message_29_internal_intr_message_wena,
	input  [31:0] internal_intr_message_30_internal_intr_message_wdat,
	input         internal_intr_message_30_internal_intr_message_wena,
	input  [31:0] internal_intr_message_31_internal_intr_message_wdat,
	input         internal_intr_message_31_internal_intr_message_wena);

	//Wire define for this module.
	wire [31:0] rreq_addr                                     ;
	wire [0:0]  rreq_vld                                      ;
	wire [0:0]  rreq_rdy                                      ;
	reg  [31:0] rack_data                                     ;
	reg  [0:0]  rack_vld                                      ;
	wire [0:0]  rack_rdy                                      ;
	wire [31:0] wreq_addr                                     ;
	wire [31:0] wreq_data                                     ;
	wire [0:0]  wreq_vld                                      ;
	wire [0:0]  wreq_rdy                                      ;
	wire [31:0] internal_intr_message_0_rdat                  ;
	wire [0:0]  internal_intr_message_0_rrdy                  ;
	wire [0:0]  internal_intr_message_0_rvld                  ;
	reg  [31:0] internal_intr_message_0_internal_intr_message ;
	wire [31:0] internal_intr_message_1_rdat                  ;
	wire [0:0]  internal_intr_message_1_rrdy                  ;
	wire [0:0]  internal_intr_message_1_rvld                  ;
	reg  [31:0] internal_intr_message_1_internal_intr_message ;
	wire [31:0] internal_intr_message_2_rdat                  ;
	wire [0:0]  internal_intr_message_2_rrdy                  ;
	wire [0:0]  internal_intr_message_2_rvld                  ;
	reg  [31:0] internal_intr_message_2_internal_intr_message ;
	wire [31:0] internal_intr_message_3_rdat                  ;
	wire [0:0]  internal_intr_message_3_rrdy                  ;
	wire [0:0]  internal_intr_message_3_rvld                  ;
	reg  [31:0] internal_intr_message_3_internal_intr_message ;
	wire [31:0] internal_intr_message_4_rdat                  ;
	wire [0:0]  internal_intr_message_4_rrdy                  ;
	wire [0:0]  internal_intr_message_4_rvld                  ;
	reg  [31:0] internal_intr_message_4_internal_intr_message ;
	wire [31:0] internal_intr_message_5_rdat                  ;
	wire [0:0]  internal_intr_message_5_rrdy                  ;
	wire [0:0]  internal_intr_message_5_rvld                  ;
	reg  [31:0] internal_intr_message_5_internal_intr_message ;
	wire [31:0] internal_intr_message_6_rdat                  ;
	wire [0:0]  internal_intr_message_6_rrdy                  ;
	wire [0:0]  internal_intr_message_6_rvld                  ;
	reg  [31:0] internal_intr_message_6_internal_intr_message ;
	wire [31:0] internal_intr_message_7_rdat                  ;
	wire [0:0]  internal_intr_message_7_rrdy                  ;
	wire [0:0]  internal_intr_message_7_rvld                  ;
	reg  [31:0] internal_intr_message_7_internal_intr_message ;
	wire [31:0] internal_intr_message_8_rdat                  ;
	wire [0:0]  internal_intr_message_8_rrdy                  ;
	wire [0:0]  internal_intr_message_8_rvld                  ;
	reg  [31:0] internal_intr_message_8_internal_intr_message ;
	wire [31:0] internal_intr_message_9_rdat                  ;
	wire [0:0]  internal_intr_message_9_rrdy                  ;
	wire [0:0]  internal_intr_message_9_rvld                  ;
	reg  [31:0] internal_intr_message_9_internal_intr_message ;
	wire [31:0] internal_intr_message_10_rdat                 ;
	wire [0:0]  internal_intr_message_10_rrdy                 ;
	wire [0:0]  internal_intr_message_10_rvld                 ;
	reg  [31:0] internal_intr_message_10_internal_intr_message;
	wire [31:0] internal_intr_message_11_rdat                 ;
	wire [0:0]  internal_intr_message_11_rrdy                 ;
	wire [0:0]  internal_intr_message_11_rvld                 ;
	reg  [31:0] internal_intr_message_11_internal_intr_message;
	wire [31:0] internal_intr_message_12_rdat                 ;
	wire [0:0]  internal_intr_message_12_rrdy                 ;
	wire [0:0]  internal_intr_message_12_rvld                 ;
	reg  [31:0] internal_intr_message_12_internal_intr_message;
	wire [31:0] internal_intr_message_13_rdat                 ;
	wire [0:0]  internal_intr_message_13_rrdy                 ;
	wire [0:0]  internal_intr_message_13_rvld                 ;
	reg  [31:0] internal_intr_message_13_internal_intr_message;
	wire [31:0] internal_intr_message_14_rdat                 ;
	wire [0:0]  internal_intr_message_14_rrdy                 ;
	wire [0:0]  internal_intr_message_14_rvld                 ;
	reg  [31:0] internal_intr_message_14_internal_intr_message;
	wire [31:0] internal_intr_message_15_rdat                 ;
	wire [0:0]  internal_intr_message_15_rrdy                 ;
	wire [0:0]  internal_intr_message_15_rvld                 ;
	reg  [31:0] internal_intr_message_15_internal_intr_message;
	wire [31:0] internal_intr_message_16_rdat                 ;
	wire [0:0]  internal_intr_message_16_rrdy                 ;
	wire [0:0]  internal_intr_message_16_rvld                 ;
	reg  [31:0] internal_intr_message_16_internal_intr_message;
	wire [31:0] internal_intr_message_17_rdat                 ;
	wire [0:0]  internal_intr_message_17_rrdy                 ;
	wire [0:0]  internal_intr_message_17_rvld                 ;
	reg  [31:0] internal_intr_message_17_internal_intr_message;
	wire [31:0] internal_intr_message_18_rdat                 ;
	wire [0:0]  internal_intr_message_18_rrdy                 ;
	wire [0:0]  internal_intr_message_18_rvld                 ;
	reg  [31:0] internal_intr_message_18_internal_intr_message;
	wire [31:0] internal_intr_message_19_rdat                 ;
	wire [0:0]  internal_intr_message_19_rrdy                 ;
	wire [0:0]  internal_intr_message_19_rvld                 ;
	reg  [31:0] internal_intr_message_19_internal_intr_message;
	wire [31:0] internal_intr_message_20_rdat                 ;
	wire [0:0]  internal_intr_message_20_rrdy                 ;
	wire [0:0]  internal_intr_message_20_rvld                 ;
	reg  [31:0] internal_intr_message_20_internal_intr_message;
	wire [31:0] internal_intr_message_21_rdat                 ;
	wire [0:0]  internal_intr_message_21_rrdy                 ;
	wire [0:0]  internal_intr_message_21_rvld                 ;
	reg  [31:0] internal_intr_message_21_internal_intr_message;
	wire [31:0] internal_intr_message_22_rdat                 ;
	wire [0:0]  internal_intr_message_22_rrdy                 ;
	wire [0:0]  internal_intr_message_22_rvld                 ;
	reg  [31:0] internal_intr_message_22_internal_intr_message;
	wire [31:0] internal_intr_message_23_rdat                 ;
	wire [0:0]  internal_intr_message_23_rrdy                 ;
	wire [0:0]  internal_intr_message_23_rvld                 ;
	reg  [31:0] internal_intr_message_23_internal_intr_message;
	wire [31:0] internal_intr_message_24_rdat                 ;
	wire [0:0]  internal_intr_message_24_rrdy                 ;
	wire [0:0]  internal_intr_message_24_rvld                 ;
	reg  [31:0] internal_intr_message_24_internal_intr_message;
	wire [31:0] internal_intr_message_25_rdat                 ;
	wire [0:0]  internal_intr_message_25_rrdy                 ;
	wire [0:0]  internal_intr_message_25_rvld                 ;
	reg  [31:0] internal_intr_message_25_internal_intr_message;
	wire [31:0] internal_intr_message_26_rdat                 ;
	wire [0:0]  internal_intr_message_26_rrdy                 ;
	wire [0:0]  internal_intr_message_26_rvld                 ;
	reg  [31:0] internal_intr_message_26_internal_intr_message;
	wire [31:0] internal_intr_message_27_rdat                 ;
	wire [0:0]  internal_intr_message_27_rrdy                 ;
	wire [0:0]  internal_intr_message_27_rvld                 ;
	reg  [31:0] internal_intr_message_27_internal_intr_message;
	wire [31:0] internal_intr_message_28_rdat                 ;
	wire [0:0]  internal_intr_message_28_rrdy                 ;
	wire [0:0]  internal_intr_message_28_rvld                 ;
	reg  [31:0] internal_intr_message_28_internal_intr_message;
	wire [31:0] internal_intr_message_29_rdat                 ;
	wire [0:0]  internal_intr_message_29_rrdy                 ;
	wire [0:0]  internal_intr_message_29_rvld                 ;
	reg  [31:0] internal_intr_message_29_internal_intr_message;
	wire [31:0] internal_intr_message_30_rdat                 ;
	wire [0:0]  internal_intr_message_30_rrdy                 ;
	wire [0:0]  internal_intr_message_30_rvld                 ;
	reg  [31:0] internal_intr_message_30_internal_intr_message;
	wire [31:0] internal_intr_message_31_rdat                 ;
	wire [0:0]  internal_intr_message_31_rrdy                 ;
	wire [0:0]  internal_intr_message_31_rvld                 ;
	reg  [31:0] internal_intr_message_31_internal_intr_message;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign rreq_addr = paddr;

	assign rreq_vld = ((!pwrite) && psel);

	assign rreq_rdy = (rack_rdy && rack_vld);

	always @(*) begin
	    if((rreq_addr == 32'h1400)) rack_data = internal_intr_message_0_rdat;
	    else if((rreq_addr == 32'h1404)) rack_data = internal_intr_message_1_rdat;
	    else if((rreq_addr == 32'h1408)) rack_data = internal_intr_message_2_rdat;
	    else if((rreq_addr == 32'h140c)) rack_data = internal_intr_message_3_rdat;
	    else if((rreq_addr == 32'h1410)) rack_data = internal_intr_message_4_rdat;
	    else if((rreq_addr == 32'h1414)) rack_data = internal_intr_message_5_rdat;
	    else if((rreq_addr == 32'h1418)) rack_data = internal_intr_message_6_rdat;
	    else if((rreq_addr == 32'h141c)) rack_data = internal_intr_message_7_rdat;
	    else if((rreq_addr == 32'h1420)) rack_data = internal_intr_message_8_rdat;
	    else if((rreq_addr == 32'h1424)) rack_data = internal_intr_message_9_rdat;
	    else if((rreq_addr == 32'h1428)) rack_data = internal_intr_message_10_rdat;
	    else if((rreq_addr == 32'h142c)) rack_data = internal_intr_message_11_rdat;
	    else if((rreq_addr == 32'h1430)) rack_data = internal_intr_message_12_rdat;
	    else if((rreq_addr == 32'h1434)) rack_data = internal_intr_message_13_rdat;
	    else if((rreq_addr == 32'h1438)) rack_data = internal_intr_message_14_rdat;
	    else if((rreq_addr == 32'h143c)) rack_data = internal_intr_message_15_rdat;
	    else if((rreq_addr == 32'h1440)) rack_data = internal_intr_message_16_rdat;
	    else if((rreq_addr == 32'h1444)) rack_data = internal_intr_message_17_rdat;
	    else if((rreq_addr == 32'h1448)) rack_data = internal_intr_message_18_rdat;
	    else if((rreq_addr == 32'h144c)) rack_data = internal_intr_message_19_rdat;
	    else if((rreq_addr == 32'h1450)) rack_data = internal_intr_message_20_rdat;
	    else if((rreq_addr == 32'h1454)) rack_data = internal_intr_message_21_rdat;
	    else if((rreq_addr == 32'h1458)) rack_data = internal_intr_message_22_rdat;
	    else if((rreq_addr == 32'h145c)) rack_data = internal_intr_message_23_rdat;
	    else if((rreq_addr == 32'h1460)) rack_data = internal_intr_message_24_rdat;
	    else if((rreq_addr == 32'h1464)) rack_data = internal_intr_message_25_rdat;
	    else if((rreq_addr == 32'h1468)) rack_data = internal_intr_message_26_rdat;
	    else if((rreq_addr == 32'h146c)) rack_data = internal_intr_message_27_rdat;
	    else if((rreq_addr == 32'h1470)) rack_data = internal_intr_message_28_rdat;
	    else if((rreq_addr == 32'h1474)) rack_data = internal_intr_message_29_rdat;
	    else if((rreq_addr == 32'h1478)) rack_data = internal_intr_message_30_rdat;
	    else if((rreq_addr == 32'h147c)) rack_data = internal_intr_message_31_rdat;
	    else rack_data = 32'hfffffffe;
	end

	always @(*) begin
	    if((rreq_addr == 32'h1400)) rack_vld = internal_intr_message_0_rrdy;
	    else if((rreq_addr == 32'h1404)) rack_vld = internal_intr_message_1_rrdy;
	    else if((rreq_addr == 32'h1408)) rack_vld = internal_intr_message_2_rrdy;
	    else if((rreq_addr == 32'h140c)) rack_vld = internal_intr_message_3_rrdy;
	    else if((rreq_addr == 32'h1410)) rack_vld = internal_intr_message_4_rrdy;
	    else if((rreq_addr == 32'h1414)) rack_vld = internal_intr_message_5_rrdy;
	    else if((rreq_addr == 32'h1418)) rack_vld = internal_intr_message_6_rrdy;
	    else if((rreq_addr == 32'h141c)) rack_vld = internal_intr_message_7_rrdy;
	    else if((rreq_addr == 32'h1420)) rack_vld = internal_intr_message_8_rrdy;
	    else if((rreq_addr == 32'h1424)) rack_vld = internal_intr_message_9_rrdy;
	    else if((rreq_addr == 32'h1428)) rack_vld = internal_intr_message_10_rrdy;
	    else if((rreq_addr == 32'h142c)) rack_vld = internal_intr_message_11_rrdy;
	    else if((rreq_addr == 32'h1430)) rack_vld = internal_intr_message_12_rrdy;
	    else if((rreq_addr == 32'h1434)) rack_vld = internal_intr_message_13_rrdy;
	    else if((rreq_addr == 32'h1438)) rack_vld = internal_intr_message_14_rrdy;
	    else if((rreq_addr == 32'h143c)) rack_vld = internal_intr_message_15_rrdy;
	    else if((rreq_addr == 32'h1440)) rack_vld = internal_intr_message_16_rrdy;
	    else if((rreq_addr == 32'h1444)) rack_vld = internal_intr_message_17_rrdy;
	    else if((rreq_addr == 32'h1448)) rack_vld = internal_intr_message_18_rrdy;
	    else if((rreq_addr == 32'h144c)) rack_vld = internal_intr_message_19_rrdy;
	    else if((rreq_addr == 32'h1450)) rack_vld = internal_intr_message_20_rrdy;
	    else if((rreq_addr == 32'h1454)) rack_vld = internal_intr_message_21_rrdy;
	    else if((rreq_addr == 32'h1458)) rack_vld = internal_intr_message_22_rrdy;
	    else if((rreq_addr == 32'h145c)) rack_vld = internal_intr_message_23_rrdy;
	    else if((rreq_addr == 32'h1460)) rack_vld = internal_intr_message_24_rrdy;
	    else if((rreq_addr == 32'h1464)) rack_vld = internal_intr_message_25_rrdy;
	    else if((rreq_addr == 32'h1468)) rack_vld = internal_intr_message_26_rrdy;
	    else if((rreq_addr == 32'h146c)) rack_vld = internal_intr_message_27_rrdy;
	    else if((rreq_addr == 32'h1470)) rack_vld = internal_intr_message_28_rrdy;
	    else if((rreq_addr == 32'h1474)) rack_vld = internal_intr_message_29_rrdy;
	    else if((rreq_addr == 32'h1478)) rack_vld = internal_intr_message_30_rrdy;
	    else if((rreq_addr == 32'h147c)) rack_vld = internal_intr_message_31_rrdy;
	    else rack_vld = 1'b0;
	end

	assign rack_rdy = ((!pwrite) && psel && penable);

	assign wreq_addr = paddr;

	assign wreq_data = pwdata[31:24];

	assign wreq_vld = (pwrite && psel && (!penable));

	assign wreq_rdy = 1'b0;

	assign pready = 1'b1;

	assign prdata = rack_data;

	assign pslverr = 1'b0;

	assign internal_intr_message_0_rdat = {internal_intr_message_0_internal_intr_message};

	assign internal_intr_message_0_rrdy = 1'b1;

	assign internal_intr_message_0_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1400));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_0_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_0_internal_intr_message_wena) internal_intr_message_0_internal_intr_message <= internal_intr_message_0_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_1_rdat = {internal_intr_message_1_internal_intr_message};

	assign internal_intr_message_1_rrdy = 1'b1;

	assign internal_intr_message_1_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1404));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_1_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_1_internal_intr_message_wena) internal_intr_message_1_internal_intr_message <= internal_intr_message_1_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_2_rdat = {internal_intr_message_2_internal_intr_message};

	assign internal_intr_message_2_rrdy = 1'b1;

	assign internal_intr_message_2_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1408));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_2_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_2_internal_intr_message_wena) internal_intr_message_2_internal_intr_message <= internal_intr_message_2_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_3_rdat = {internal_intr_message_3_internal_intr_message};

	assign internal_intr_message_3_rrdy = 1'b1;

	assign internal_intr_message_3_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h140c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_3_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_3_internal_intr_message_wena) internal_intr_message_3_internal_intr_message <= internal_intr_message_3_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_4_rdat = {internal_intr_message_4_internal_intr_message};

	assign internal_intr_message_4_rrdy = 1'b1;

	assign internal_intr_message_4_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1410));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_4_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_4_internal_intr_message_wena) internal_intr_message_4_internal_intr_message <= internal_intr_message_4_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_5_rdat = {internal_intr_message_5_internal_intr_message};

	assign internal_intr_message_5_rrdy = 1'b1;

	assign internal_intr_message_5_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1414));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_5_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_5_internal_intr_message_wena) internal_intr_message_5_internal_intr_message <= internal_intr_message_5_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_6_rdat = {internal_intr_message_6_internal_intr_message};

	assign internal_intr_message_6_rrdy = 1'b1;

	assign internal_intr_message_6_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1418));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_6_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_6_internal_intr_message_wena) internal_intr_message_6_internal_intr_message <= internal_intr_message_6_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_7_rdat = {internal_intr_message_7_internal_intr_message};

	assign internal_intr_message_7_rrdy = 1'b1;

	assign internal_intr_message_7_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h141c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_7_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_7_internal_intr_message_wena) internal_intr_message_7_internal_intr_message <= internal_intr_message_7_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_8_rdat = {internal_intr_message_8_internal_intr_message};

	assign internal_intr_message_8_rrdy = 1'b1;

	assign internal_intr_message_8_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1420));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_8_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_8_internal_intr_message_wena) internal_intr_message_8_internal_intr_message <= internal_intr_message_8_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_9_rdat = {internal_intr_message_9_internal_intr_message};

	assign internal_intr_message_9_rrdy = 1'b1;

	assign internal_intr_message_9_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1424));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_9_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_9_internal_intr_message_wena) internal_intr_message_9_internal_intr_message <= internal_intr_message_9_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_10_rdat = {internal_intr_message_10_internal_intr_message};

	assign internal_intr_message_10_rrdy = 1'b1;

	assign internal_intr_message_10_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1428));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_10_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_10_internal_intr_message_wena) internal_intr_message_10_internal_intr_message <= internal_intr_message_10_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_11_rdat = {internal_intr_message_11_internal_intr_message};

	assign internal_intr_message_11_rrdy = 1'b1;

	assign internal_intr_message_11_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h142c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_11_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_11_internal_intr_message_wena) internal_intr_message_11_internal_intr_message <= internal_intr_message_11_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_12_rdat = {internal_intr_message_12_internal_intr_message};

	assign internal_intr_message_12_rrdy = 1'b1;

	assign internal_intr_message_12_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1430));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_12_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_12_internal_intr_message_wena) internal_intr_message_12_internal_intr_message <= internal_intr_message_12_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_13_rdat = {internal_intr_message_13_internal_intr_message};

	assign internal_intr_message_13_rrdy = 1'b1;

	assign internal_intr_message_13_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1434));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_13_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_13_internal_intr_message_wena) internal_intr_message_13_internal_intr_message <= internal_intr_message_13_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_14_rdat = {internal_intr_message_14_internal_intr_message};

	assign internal_intr_message_14_rrdy = 1'b1;

	assign internal_intr_message_14_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1438));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_14_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_14_internal_intr_message_wena) internal_intr_message_14_internal_intr_message <= internal_intr_message_14_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_15_rdat = {internal_intr_message_15_internal_intr_message};

	assign internal_intr_message_15_rrdy = 1'b1;

	assign internal_intr_message_15_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h143c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_15_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_15_internal_intr_message_wena) internal_intr_message_15_internal_intr_message <= internal_intr_message_15_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_16_rdat = {internal_intr_message_16_internal_intr_message};

	assign internal_intr_message_16_rrdy = 1'b1;

	assign internal_intr_message_16_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1440));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_16_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_16_internal_intr_message_wena) internal_intr_message_16_internal_intr_message <= internal_intr_message_16_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_17_rdat = {internal_intr_message_17_internal_intr_message};

	assign internal_intr_message_17_rrdy = 1'b1;

	assign internal_intr_message_17_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1444));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_17_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_17_internal_intr_message_wena) internal_intr_message_17_internal_intr_message <= internal_intr_message_17_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_18_rdat = {internal_intr_message_18_internal_intr_message};

	assign internal_intr_message_18_rrdy = 1'b1;

	assign internal_intr_message_18_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1448));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_18_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_18_internal_intr_message_wena) internal_intr_message_18_internal_intr_message <= internal_intr_message_18_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_19_rdat = {internal_intr_message_19_internal_intr_message};

	assign internal_intr_message_19_rrdy = 1'b1;

	assign internal_intr_message_19_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h144c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_19_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_19_internal_intr_message_wena) internal_intr_message_19_internal_intr_message <= internal_intr_message_19_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_20_rdat = {internal_intr_message_20_internal_intr_message};

	assign internal_intr_message_20_rrdy = 1'b1;

	assign internal_intr_message_20_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1450));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_20_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_20_internal_intr_message_wena) internal_intr_message_20_internal_intr_message <= internal_intr_message_20_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_21_rdat = {internal_intr_message_21_internal_intr_message};

	assign internal_intr_message_21_rrdy = 1'b1;

	assign internal_intr_message_21_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1454));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_21_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_21_internal_intr_message_wena) internal_intr_message_21_internal_intr_message <= internal_intr_message_21_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_22_rdat = {internal_intr_message_22_internal_intr_message};

	assign internal_intr_message_22_rrdy = 1'b1;

	assign internal_intr_message_22_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1458));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_22_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_22_internal_intr_message_wena) internal_intr_message_22_internal_intr_message <= internal_intr_message_22_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_23_rdat = {internal_intr_message_23_internal_intr_message};

	assign internal_intr_message_23_rrdy = 1'b1;

	assign internal_intr_message_23_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h145c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_23_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_23_internal_intr_message_wena) internal_intr_message_23_internal_intr_message <= internal_intr_message_23_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_24_rdat = {internal_intr_message_24_internal_intr_message};

	assign internal_intr_message_24_rrdy = 1'b1;

	assign internal_intr_message_24_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1460));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_24_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_24_internal_intr_message_wena) internal_intr_message_24_internal_intr_message <= internal_intr_message_24_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_25_rdat = {internal_intr_message_25_internal_intr_message};

	assign internal_intr_message_25_rrdy = 1'b1;

	assign internal_intr_message_25_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1464));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_25_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_25_internal_intr_message_wena) internal_intr_message_25_internal_intr_message <= internal_intr_message_25_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_26_rdat = {internal_intr_message_26_internal_intr_message};

	assign internal_intr_message_26_rrdy = 1'b1;

	assign internal_intr_message_26_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1468));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_26_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_26_internal_intr_message_wena) internal_intr_message_26_internal_intr_message <= internal_intr_message_26_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_27_rdat = {internal_intr_message_27_internal_intr_message};

	assign internal_intr_message_27_rrdy = 1'b1;

	assign internal_intr_message_27_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h146c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_27_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_27_internal_intr_message_wena) internal_intr_message_27_internal_intr_message <= internal_intr_message_27_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_28_rdat = {internal_intr_message_28_internal_intr_message};

	assign internal_intr_message_28_rrdy = 1'b1;

	assign internal_intr_message_28_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1470));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_28_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_28_internal_intr_message_wena) internal_intr_message_28_internal_intr_message <= internal_intr_message_28_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_29_rdat = {internal_intr_message_29_internal_intr_message};

	assign internal_intr_message_29_rrdy = 1'b1;

	assign internal_intr_message_29_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1474));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_29_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_29_internal_intr_message_wena) internal_intr_message_29_internal_intr_message <= internal_intr_message_29_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_30_rdat = {internal_intr_message_30_internal_intr_message};

	assign internal_intr_message_30_rrdy = 1'b1;

	assign internal_intr_message_30_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h1478));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_30_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_30_internal_intr_message_wena) internal_intr_message_30_internal_intr_message <= internal_intr_message_30_internal_intr_message_wdat;
	    end
	end

	assign internal_intr_message_31_rdat = {internal_intr_message_31_internal_intr_message};

	assign internal_intr_message_31_rrdy = 1'b1;

	assign internal_intr_message_31_rvld = ((rack_rdy && rack_vld) && (rreq_addr == 32'h147c));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) internal_intr_message_31_internal_intr_message <= 32'b0;
	    else begin
	        if(internal_intr_message_31_internal_intr_message_wena) internal_intr_message_31_internal_intr_message <= internal_intr_message_31_internal_intr_message_wdat;
	    end
	end


	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:e79b5adbd2a42fafd8d54f3bec104e8f]

//[UHDL]Content Start [md5:5796fb5bef4b791477bec807c2cc55ff]
module sts_noc_camera_ss_tniu_RegSpaceBase_cfg_reg_bank_table (
	input             clk                                 ,
	input             rst_n                               ,
	input      [15:0] p_addr                              ,
	input             p_sel                               ,
	input             p_enable                            ,
	input             p_write                             ,
	input      [31:0] p_wdata                             ,
	output            p_ready                             ,
	output     [31:0] p_rdata                             ,
	output            p_slverr                            ,
	output reg        parity_sw_check_err                 ,
	output     [31:0] debug_en_debug_en_rdat              ,
	output            debug_en_parity_hw_check_err        ,
	output     [31:0] timing_bus1_timing_bus1_rdat              ,
	output            timing_bus1_parity_hw_check_err        ,
	output     [31:0] timing_bus2_timing_bus2_rdat              ,
	output            timing_bus2_parity_hw_check_err        ,
	output     [31:0] timing_bus3_timing_bus3_rdat              ,
	output            timing_bus3_parity_hw_check_err        ,
	output     [31:0] debug_data_gate_debug_data_gate_rdat              ,
	output            debug_data_gate_parity_hw_check_err        ,
	output     [31:0] hw_dbg_sel_hw_dbg_sel_rdat              ,
	output            hw_dbg_sel_parity_hw_check_err );

	//Wire define for this module.
	wire [15:0] rreq_addr                                 ;
	reg  [31:0] rack_data                                 ;
	wire [15:0] wreq_addr                                 ;
	wire [31:0] wreq_data                                 ;
	wire [0:0]  wreq_vld                                  ;
	wire [31:0] debug_en_rdat                          ;
	wire [31:0] debug_en_wdat                          ;
	wire [0:0]  debug_en_wvld                          ;
	reg  [31:0] debug_en_debug_en                   ;
	wire [0:0]  debug_en_debug_en_sw_wren           ;
	wire [31:0] debug_en_debug_en_field_wdat        ;
	reg  [31:0] debug_en_debug_en_parity            ;
	wire [0:0]  debug_en_parity_ena                    ;
	wire [31:0] debug_en_parity_wdata                  ;
	wire [3:0]  debug_en_parity_update                 ;
	reg  [3:0]  debug_en_parity_bit                    ;
	wire [3:0]  debug_en_parity_check_bit              ;
	wire [31:0] debug_en_parity_check_wdata            ;
	wire [0:0]  debug_en_parity_check_err              ;
	wire [31:0] timing_bus1_rdat                          ;
	wire [31:0] timing_bus1_wdat                          ;
	wire [0:0]  timing_bus1_wvld                          ;
	reg  [31:0] timing_bus1_timing_bus1                   ;
	wire [0:0]  timing_bus1_timing_bus1_sw_wren           ;
	wire [31:0] timing_bus1_timing_bus1_field_wdat        ;
	reg  [31:0] timing_bus1_timing_bus1_parity            ;
	wire [0:0]  timing_bus1_parity_ena                    ;
	wire [31:0] timing_bus1_parity_wdata                  ;
	wire [3:0]  timing_bus1_parity_update                 ;
	reg  [3:0]  timing_bus1_parity_bit                    ;
	wire [3:0]  timing_bus1_parity_check_bit              ;
	wire [31:0] timing_bus1_parity_check_wdata            ;
	wire [0:0]  timing_bus1_parity_check_err              ;
	wire [31:0] timing_bus2_rdat                          ;
	wire [31:0] timing_bus2_wdat                          ;
	wire [0:0]  timing_bus2_wvld                          ;
	reg  [31:0] timing_bus2_timing_bus2                   ;
	wire [0:0]  timing_bus2_timing_bus2_sw_wren           ;
	wire [31:0] timing_bus2_timing_bus2_field_wdat        ;
	reg  [31:0] timing_bus2_timing_bus2_parity            ;
	wire [0:0]  timing_bus2_parity_ena                    ;
	wire [31:0] timing_bus2_parity_wdata                  ;
	wire [3:0]  timing_bus2_parity_update                 ;
	reg  [3:0]  timing_bus2_parity_bit                    ;
	wire [3:0]  timing_bus2_parity_check_bit              ;
	wire [31:0] timing_bus2_parity_check_wdata            ;
	wire [0:0]  timing_bus2_parity_check_err              ;
	wire [31:0] timing_bus3_rdat                          ;
	wire [31:0] timing_bus3_wdat                          ;
	wire [0:0]  timing_bus3_wvld                          ;
	reg  [31:0] timing_bus3_timing_bus3                   ;
	wire [0:0]  timing_bus3_timing_bus3_sw_wren           ;
	wire [31:0] timing_bus3_timing_bus3_field_wdat        ;
	reg  [31:0] timing_bus3_timing_bus3_parity            ;
	wire [0:0]  timing_bus3_parity_ena                    ;
	wire [31:0] timing_bus3_parity_wdata                  ;
	wire [3:0]  timing_bus3_parity_update                 ;
	reg  [3:0]  timing_bus3_parity_bit                    ;
	wire [3:0]  timing_bus3_parity_check_bit              ;
	wire [31:0] timing_bus3_parity_check_wdata            ;
	wire [0:0]  timing_bus3_parity_check_err              ;
	wire [31:0] debug_data_gate_rdat                          ;
	wire [31:0] debug_data_gate_wdat                          ;
	wire [0:0]  debug_data_gate_wvld                          ;
	reg  [31:0] debug_data_gate_debug_data_gate                   ;
	wire [0:0]  debug_data_gate_debug_data_gate_sw_wren           ;
	wire [31:0] debug_data_gate_debug_data_gate_field_wdat        ;
	reg  [31:0] debug_data_gate_debug_data_gate_parity            ;
	wire [0:0]  debug_data_gate_parity_ena                    ;
	wire [31:0] debug_data_gate_parity_wdata                  ;
	wire [3:0]  debug_data_gate_parity_update                 ;
	reg  [3:0]  debug_data_gate_parity_bit                    ;
	wire [3:0]  debug_data_gate_parity_check_bit              ;
	wire [31:0] debug_data_gate_parity_check_wdata            ;
	wire [0:0]  debug_data_gate_parity_check_err              ;
	wire [31:0] hw_dbg_sel_rdat                          ;
	wire [31:0] hw_dbg_sel_wdat                          ;
	wire [0:0]  hw_dbg_sel_wvld                          ;
	reg  [31:0] hw_dbg_sel_hw_dbg_sel                   ;
	wire [0:0]  hw_dbg_sel_hw_dbg_sel_sw_wren           ;
	wire [31:0] hw_dbg_sel_hw_dbg_sel_field_wdat        ;
	reg  [31:0] hw_dbg_sel_hw_dbg_sel_parity            ;
	wire [0:0]  hw_dbg_sel_parity_ena                    ;
	wire [31:0] hw_dbg_sel_parity_wdata                  ;
	wire [3:0]  hw_dbg_sel_parity_update                 ;
	reg  [3:0]  hw_dbg_sel_parity_bit                    ;
	wire [3:0]  hw_dbg_sel_parity_check_bit              ;
	wire [31:0] hw_dbg_sel_parity_check_wdata            ;
	wire [0:0]  hw_dbg_sel_parity_check_err              ;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign p_ready = 1'b1;

	assign p_rdata = rack_data;

	assign p_slverr = 1'b0;

	assign rreq_addr = p_addr;

	always @(*) begin
	    if((rreq_addr == 16'h0)) rack_data = debug_en_rdat;
	    else if((rreq_addr == 16'h4)) rack_data = timing_bus1_rdat;
	    else if((rreq_addr == 16'h8)) rack_data = timing_bus2_rdat;
	    else if((rreq_addr == 16'hc)) rack_data = timing_bus3_rdat;
	    else if((rreq_addr == 16'h10)) rack_data = debug_data_gate_rdat;
	    else if((rreq_addr == 16'h14)) rack_data = hw_dbg_sel_rdat;
	    else rack_data = 32'hfffffffe;
	end

	assign wreq_addr = p_addr;

	assign wreq_data = p_wdata;

	assign wreq_vld = (p_write & p_sel & p_enable);

	always @(*) begin
	    if((rreq_addr == 16'h0)) parity_sw_check_err = debug_en_parity_check_err;
	    else if((rreq_addr == 16'h4)) parity_sw_check_err = timing_bus1_parity_check_err;
	    else if((rreq_addr == 16'h8)) parity_sw_check_err = timing_bus2_parity_check_err;
	    else if((rreq_addr == 16'hc)) parity_sw_check_err = timing_bus3_parity_check_err;
	    else if((rreq_addr == 16'h10)) parity_sw_check_err = debug_data_gate_parity_check_err;
	    else if((rreq_addr == 16'h14)) parity_sw_check_err = hw_dbg_sel_parity_check_err;
	    else parity_sw_check_err = 1'b0;
	end

	assign debug_en_rdat = {debug_en_debug_en};

	assign debug_en_wdat = wreq_data;

	assign debug_en_wvld = (wreq_vld & (wreq_addr == 16'h0));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) debug_en_debug_en <= 32'b0;
	    else begin
	        if(debug_en_debug_en_sw_wren) debug_en_debug_en <= debug_en_debug_en_field_wdat;
	    end
	end

	assign debug_en_debug_en_rdat = debug_en_debug_en;

	assign debug_en_debug_en_sw_wren = (debug_en_wvld);

	assign debug_en_debug_en_field_wdat = debug_en_wdat[31:0];

	always @(*) begin
	    if(debug_en_debug_en_sw_wren) debug_en_debug_en_parity = debug_en_debug_en_field_wdat;
	    else debug_en_debug_en_parity = debug_en_debug_en;
	end

	assign debug_en_parity_ena = (debug_en_debug_en_sw_wren);

	assign debug_en_parity_wdata = {debug_en_debug_en_parity[31], debug_en_debug_en_parity[30], debug_en_debug_en_parity[29], debug_en_debug_en_parity[28], debug_en_debug_en_parity[27], debug_en_debug_en_parity[26], debug_en_debug_en_parity[25], debug_en_debug_en_parity[24], debug_en_debug_en_parity[23], debug_en_debug_en_parity[22], debug_en_debug_en_parity[21], debug_en_debug_en_parity[20], debug_en_debug_en_parity[19], debug_en_debug_en_parity[18], debug_en_debug_en_parity[17], debug_en_debug_en_parity[16], debug_en_debug_en_parity[15], debug_en_debug_en_parity[14], debug_en_debug_en_parity[13], debug_en_debug_en_parity[12], debug_en_debug_en_parity[11], debug_en_debug_en_parity[10], debug_en_debug_en_parity[9], debug_en_debug_en_parity[8], debug_en_debug_en_parity[7], debug_en_debug_en_parity[6], debug_en_debug_en_parity[5], debug_en_debug_en_parity[4], debug_en_debug_en_parity[3], debug_en_debug_en_parity[2], debug_en_debug_en_parity[1], debug_en_debug_en_parity[0]};

	assign debug_en_parity_update = {(^debug_en_parity_wdata[31:24]), (^debug_en_parity_wdata[23:16]), (^debug_en_parity_wdata[15:8]), (^debug_en_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) debug_en_parity_bit <= 4'b0;
	    else begin
	        if(debug_en_parity_ena) debug_en_parity_bit <= debug_en_parity_update;
	    end
	end

	assign debug_en_parity_check_bit = {(^debug_en_parity_check_wdata[31:24]), (^debug_en_parity_check_wdata[23:16]), (^debug_en_parity_check_wdata[15:8]), (^debug_en_parity_check_wdata[7:0])};

	assign debug_en_parity_check_wdata = {debug_en_debug_en[31], debug_en_debug_en[30], debug_en_debug_en[29], debug_en_debug_en[28], debug_en_debug_en[27], debug_en_debug_en[26], debug_en_debug_en[25], debug_en_debug_en[24], debug_en_debug_en[23], debug_en_debug_en[22], debug_en_debug_en[21], debug_en_debug_en[20], debug_en_debug_en[19], debug_en_debug_en[18], debug_en_debug_en[17], debug_en_debug_en[16], debug_en_debug_en[15], debug_en_debug_en[14], debug_en_debug_en[13], debug_en_debug_en[12], debug_en_debug_en[11], debug_en_debug_en[10], debug_en_debug_en[9], debug_en_debug_en[8], debug_en_debug_en[7], debug_en_debug_en[6], debug_en_debug_en[5], debug_en_debug_en[4], debug_en_debug_en[3], debug_en_debug_en[2], debug_en_debug_en[1], debug_en_debug_en[0]};

	assign debug_en_parity_check_err = (debug_en_parity_check_bit != debug_en_parity_bit);

	assign debug_en_parity_hw_check_err = debug_en_parity_check_err;

	assign timing_bus1_rdat = {timing_bus1_timing_bus1};

	assign timing_bus1_wdat = wreq_data;

	assign timing_bus1_wvld = (wreq_vld & (wreq_addr == 16'h4));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus1_timing_bus1 <= 32'b0;
	    else begin
	        if(timing_bus1_timing_bus1_sw_wren) timing_bus1_timing_bus1 <= timing_bus1_timing_bus1_field_wdat;
	    end
	end

	assign timing_bus1_timing_bus1_rdat = timing_bus1_timing_bus1;

	assign timing_bus1_timing_bus1_sw_wren = (timing_bus1_wvld);

	assign timing_bus1_timing_bus1_field_wdat = timing_bus1_wdat[31:0];

	always @(*) begin
	    if(timing_bus1_timing_bus1_sw_wren) timing_bus1_timing_bus1_parity = timing_bus1_timing_bus1_field_wdat;
	    else timing_bus1_timing_bus1_parity = timing_bus1_timing_bus1;
	end

	assign timing_bus1_parity_ena = (timing_bus1_timing_bus1_sw_wren);

	assign timing_bus1_parity_wdata = {timing_bus1_timing_bus1_parity[31], timing_bus1_timing_bus1_parity[30], timing_bus1_timing_bus1_parity[29], timing_bus1_timing_bus1_parity[28], timing_bus1_timing_bus1_parity[27], timing_bus1_timing_bus1_parity[26], timing_bus1_timing_bus1_parity[25], timing_bus1_timing_bus1_parity[24], timing_bus1_timing_bus1_parity[23], timing_bus1_timing_bus1_parity[22], timing_bus1_timing_bus1_parity[21], timing_bus1_timing_bus1_parity[20], timing_bus1_timing_bus1_parity[19], timing_bus1_timing_bus1_parity[18], timing_bus1_timing_bus1_parity[17], timing_bus1_timing_bus1_parity[16], timing_bus1_timing_bus1_parity[15], timing_bus1_timing_bus1_parity[14], timing_bus1_timing_bus1_parity[13], timing_bus1_timing_bus1_parity[12], timing_bus1_timing_bus1_parity[11], timing_bus1_timing_bus1_parity[10], timing_bus1_timing_bus1_parity[9], timing_bus1_timing_bus1_parity[8], timing_bus1_timing_bus1_parity[7], timing_bus1_timing_bus1_parity[6], timing_bus1_timing_bus1_parity[5], timing_bus1_timing_bus1_parity[4], timing_bus1_timing_bus1_parity[3], timing_bus1_timing_bus1_parity[2], timing_bus1_timing_bus1_parity[1], timing_bus1_timing_bus1_parity[0]};

	assign timing_bus1_parity_update = {(^timing_bus1_parity_wdata[31:24]), (^timing_bus1_parity_wdata[23:16]), (^timing_bus1_parity_wdata[15:8]), (^timing_bus1_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus1_parity_bit <= 4'b0;
	    else begin
	        if(timing_bus1_parity_ena) timing_bus1_parity_bit <= timing_bus1_parity_update;
	    end
	end

	assign timing_bus1_parity_check_bit = {(^timing_bus1_parity_check_wdata[31:24]), (^timing_bus1_parity_check_wdata[23:16]), (^timing_bus1_parity_check_wdata[15:8]), (^timing_bus1_parity_check_wdata[7:0])};

	assign timing_bus1_parity_check_wdata = {timing_bus1_timing_bus1[31], timing_bus1_timing_bus1[30], timing_bus1_timing_bus1[29], timing_bus1_timing_bus1[28], timing_bus1_timing_bus1[27], timing_bus1_timing_bus1[26], timing_bus1_timing_bus1[25], timing_bus1_timing_bus1[24], timing_bus1_timing_bus1[23], timing_bus1_timing_bus1[22], timing_bus1_timing_bus1[21], timing_bus1_timing_bus1[20], timing_bus1_timing_bus1[19], timing_bus1_timing_bus1[18], timing_bus1_timing_bus1[17], timing_bus1_timing_bus1[16], timing_bus1_timing_bus1[15], timing_bus1_timing_bus1[14], timing_bus1_timing_bus1[13], timing_bus1_timing_bus1[12], timing_bus1_timing_bus1[11], timing_bus1_timing_bus1[10], timing_bus1_timing_bus1[9], timing_bus1_timing_bus1[8], timing_bus1_timing_bus1[7], timing_bus1_timing_bus1[6], timing_bus1_timing_bus1[5], timing_bus1_timing_bus1[4], timing_bus1_timing_bus1[3], timing_bus1_timing_bus1[2], timing_bus1_timing_bus1[1], timing_bus1_timing_bus1[0]};

	assign timing_bus1_parity_check_err = (timing_bus1_parity_check_bit != timing_bus1_parity_bit);

	assign timing_bus1_parity_hw_check_err = timing_bus1_parity_check_err;

	assign timing_bus2_rdat = {timing_bus2_timing_bus2};

	assign timing_bus2_wdat = wreq_data;

	assign timing_bus2_wvld = (wreq_vld & (wreq_addr == 16'h8));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus2_timing_bus2 <= 32'b0;
	    else begin
	        if(timing_bus2_timing_bus2_sw_wren) timing_bus2_timing_bus2 <= timing_bus2_timing_bus2_field_wdat;
	    end
	end

	assign timing_bus2_timing_bus2_rdat = timing_bus2_timing_bus2;

	assign timing_bus2_timing_bus2_sw_wren = (timing_bus2_wvld);

	assign timing_bus2_timing_bus2_field_wdat = timing_bus2_wdat[31:0];

	always @(*) begin
	    if(timing_bus2_timing_bus2_sw_wren) timing_bus2_timing_bus2_parity = timing_bus2_timing_bus2_field_wdat;
	    else timing_bus2_timing_bus2_parity = timing_bus2_timing_bus2;
	end

	assign timing_bus2_parity_ena = (timing_bus2_timing_bus2_sw_wren);

	assign timing_bus2_parity_wdata = {timing_bus2_timing_bus2_parity[31], timing_bus2_timing_bus2_parity[30], timing_bus2_timing_bus2_parity[29], timing_bus2_timing_bus2_parity[28], timing_bus2_timing_bus2_parity[27], timing_bus2_timing_bus2_parity[26], timing_bus2_timing_bus2_parity[25], timing_bus2_timing_bus2_parity[24], timing_bus2_timing_bus2_parity[23], timing_bus2_timing_bus2_parity[22], timing_bus2_timing_bus2_parity[21], timing_bus2_timing_bus2_parity[20], timing_bus2_timing_bus2_parity[19], timing_bus2_timing_bus2_parity[18], timing_bus2_timing_bus2_parity[17], timing_bus2_timing_bus2_parity[16], timing_bus2_timing_bus2_parity[15], timing_bus2_timing_bus2_parity[14], timing_bus2_timing_bus2_parity[13], timing_bus2_timing_bus2_parity[12], timing_bus2_timing_bus2_parity[11], timing_bus2_timing_bus2_parity[10], timing_bus2_timing_bus2_parity[9], timing_bus2_timing_bus2_parity[8], timing_bus2_timing_bus2_parity[7], timing_bus2_timing_bus2_parity[6], timing_bus2_timing_bus2_parity[5], timing_bus2_timing_bus2_parity[4], timing_bus2_timing_bus2_parity[3], timing_bus2_timing_bus2_parity[2], timing_bus2_timing_bus2_parity[1], timing_bus2_timing_bus2_parity[0]};

	assign timing_bus2_parity_update = {(^timing_bus2_parity_wdata[31:24]), (^timing_bus2_parity_wdata[23:16]), (^timing_bus2_parity_wdata[15:8]), (^timing_bus2_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus2_parity_bit <= 4'b0;
	    else begin
	        if(timing_bus2_parity_ena) timing_bus2_parity_bit <= timing_bus2_parity_update;
	    end
	end

	assign timing_bus2_parity_check_bit = {(^timing_bus2_parity_check_wdata[31:24]), (^timing_bus2_parity_check_wdata[23:16]), (^timing_bus2_parity_check_wdata[15:8]), (^timing_bus2_parity_check_wdata[7:0])};

	assign timing_bus2_parity_check_wdata = {timing_bus2_timing_bus2[31], timing_bus2_timing_bus2[30], timing_bus2_timing_bus2[29], timing_bus2_timing_bus2[28], timing_bus2_timing_bus2[27], timing_bus2_timing_bus2[26], timing_bus2_timing_bus2[25], timing_bus2_timing_bus2[24], timing_bus2_timing_bus2[23], timing_bus2_timing_bus2[22], timing_bus2_timing_bus2[21], timing_bus2_timing_bus2[20], timing_bus2_timing_bus2[19], timing_bus2_timing_bus2[18], timing_bus2_timing_bus2[17], timing_bus2_timing_bus2[16], timing_bus2_timing_bus2[15], timing_bus2_timing_bus2[14], timing_bus2_timing_bus2[13], timing_bus2_timing_bus2[12], timing_bus2_timing_bus2[11], timing_bus2_timing_bus2[10], timing_bus2_timing_bus2[9], timing_bus2_timing_bus2[8], timing_bus2_timing_bus2[7], timing_bus2_timing_bus2[6], timing_bus2_timing_bus2[5], timing_bus2_timing_bus2[4], timing_bus2_timing_bus2[3], timing_bus2_timing_bus2[2], timing_bus2_timing_bus2[1], timing_bus2_timing_bus2[0]};

	assign timing_bus2_parity_check_err = (timing_bus2_parity_check_bit != timing_bus2_parity_bit);

	assign timing_bus2_parity_hw_check_err = timing_bus2_parity_check_err;

	assign timing_bus3_rdat = {timing_bus3_timing_bus3};

	assign timing_bus3_wdat = wreq_data;

	assign timing_bus3_wvld = (wreq_vld & (wreq_addr == 16'hc));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus3_timing_bus3 <= 32'b0;
	    else begin
	        if(timing_bus3_timing_bus3_sw_wren) timing_bus3_timing_bus3 <= timing_bus3_timing_bus3_field_wdat;
	    end
	end

	assign timing_bus3_timing_bus3_rdat = timing_bus3_timing_bus3;

	assign timing_bus3_timing_bus3_sw_wren = (timing_bus3_wvld);

	assign timing_bus3_timing_bus3_field_wdat = timing_bus3_wdat[31:0];

	always @(*) begin
	    if(timing_bus3_timing_bus3_sw_wren) timing_bus3_timing_bus3_parity = timing_bus3_timing_bus3_field_wdat;
	    else timing_bus3_timing_bus3_parity = timing_bus3_timing_bus3;
	end

	assign timing_bus3_parity_ena = (timing_bus3_timing_bus3_sw_wren);

	assign timing_bus3_parity_wdata = {timing_bus3_timing_bus3_parity[31], timing_bus3_timing_bus3_parity[30], timing_bus3_timing_bus3_parity[29], timing_bus3_timing_bus3_parity[28], timing_bus3_timing_bus3_parity[27], timing_bus3_timing_bus3_parity[26], timing_bus3_timing_bus3_parity[25], timing_bus3_timing_bus3_parity[24], timing_bus3_timing_bus3_parity[23], timing_bus3_timing_bus3_parity[22], timing_bus3_timing_bus3_parity[21], timing_bus3_timing_bus3_parity[20], timing_bus3_timing_bus3_parity[19], timing_bus3_timing_bus3_parity[18], timing_bus3_timing_bus3_parity[17], timing_bus3_timing_bus3_parity[16], timing_bus3_timing_bus3_parity[15], timing_bus3_timing_bus3_parity[14], timing_bus3_timing_bus3_parity[13], timing_bus3_timing_bus3_parity[12], timing_bus3_timing_bus3_parity[11], timing_bus3_timing_bus3_parity[10], timing_bus3_timing_bus3_parity[9], timing_bus3_timing_bus3_parity[8], timing_bus3_timing_bus3_parity[7], timing_bus3_timing_bus3_parity[6], timing_bus3_timing_bus3_parity[5], timing_bus3_timing_bus3_parity[4], timing_bus3_timing_bus3_parity[3], timing_bus3_timing_bus3_parity[2], timing_bus3_timing_bus3_parity[1], timing_bus3_timing_bus3_parity[0]};

	assign timing_bus3_parity_update = {(^timing_bus3_parity_wdata[31:24]), (^timing_bus3_parity_wdata[23:16]), (^timing_bus3_parity_wdata[15:8]), (^timing_bus3_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) timing_bus3_parity_bit <= 4'b0;
	    else begin
	        if(timing_bus3_parity_ena) timing_bus3_parity_bit <= timing_bus3_parity_update;
	    end
	end

	assign timing_bus3_parity_check_bit = {(^timing_bus3_parity_check_wdata[31:24]), (^timing_bus3_parity_check_wdata[23:16]), (^timing_bus3_parity_check_wdata[15:8]), (^timing_bus3_parity_check_wdata[7:0])};

	assign timing_bus3_parity_check_wdata = {timing_bus3_timing_bus3[31], timing_bus3_timing_bus3[30], timing_bus3_timing_bus3[29], timing_bus3_timing_bus3[28], timing_bus3_timing_bus3[27], timing_bus3_timing_bus3[26], timing_bus3_timing_bus3[25], timing_bus3_timing_bus3[24], timing_bus3_timing_bus3[23], timing_bus3_timing_bus3[22], timing_bus3_timing_bus3[21], timing_bus3_timing_bus3[20], timing_bus3_timing_bus3[19], timing_bus3_timing_bus3[18], timing_bus3_timing_bus3[17], timing_bus3_timing_bus3[16], timing_bus3_timing_bus3[15], timing_bus3_timing_bus3[14], timing_bus3_timing_bus3[13], timing_bus3_timing_bus3[12], timing_bus3_timing_bus3[11], timing_bus3_timing_bus3[10], timing_bus3_timing_bus3[9], timing_bus3_timing_bus3[8], timing_bus3_timing_bus3[7], timing_bus3_timing_bus3[6], timing_bus3_timing_bus3[5], timing_bus3_timing_bus3[4], timing_bus3_timing_bus3[3], timing_bus3_timing_bus3[2], timing_bus3_timing_bus3[1], timing_bus3_timing_bus3[0]};

	assign timing_bus3_parity_check_err = (timing_bus3_parity_check_bit != timing_bus3_parity_bit);

	assign timing_bus3_parity_hw_check_err = timing_bus3_parity_check_err;

	assign debug_data_gate_rdat = {debug_data_gate_debug_data_gate};

	assign debug_data_gate_wdat = wreq_data;

	assign debug_data_gate_wvld = (wreq_vld & (wreq_addr == 16'h10));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) debug_data_gate_debug_data_gate <= 32'b0;
	    else begin
	        if(debug_data_gate_debug_data_gate_sw_wren) debug_data_gate_debug_data_gate <= debug_data_gate_debug_data_gate_field_wdat;
	    end
	end

	assign debug_data_gate_debug_data_gate_rdat = debug_data_gate_debug_data_gate;

	assign debug_data_gate_debug_data_gate_sw_wren = (debug_data_gate_wvld);

	assign debug_data_gate_debug_data_gate_field_wdat = debug_data_gate_wdat[31:0];

	always @(*) begin
	    if(debug_data_gate_debug_data_gate_sw_wren) debug_data_gate_debug_data_gate_parity = debug_data_gate_debug_data_gate_field_wdat;
	    else debug_data_gate_debug_data_gate_parity = debug_data_gate_debug_data_gate;
	end

	assign debug_data_gate_parity_ena = (debug_data_gate_debug_data_gate_sw_wren);

	assign debug_data_gate_parity_wdata = {debug_data_gate_debug_data_gate_parity[31], debug_data_gate_debug_data_gate_parity[30], debug_data_gate_debug_data_gate_parity[29], debug_data_gate_debug_data_gate_parity[28], debug_data_gate_debug_data_gate_parity[27], debug_data_gate_debug_data_gate_parity[26], debug_data_gate_debug_data_gate_parity[25], debug_data_gate_debug_data_gate_parity[24], debug_data_gate_debug_data_gate_parity[23], debug_data_gate_debug_data_gate_parity[22], debug_data_gate_debug_data_gate_parity[21], debug_data_gate_debug_data_gate_parity[20], debug_data_gate_debug_data_gate_parity[19], debug_data_gate_debug_data_gate_parity[18], debug_data_gate_debug_data_gate_parity[17], debug_data_gate_debug_data_gate_parity[16], debug_data_gate_debug_data_gate_parity[15], debug_data_gate_debug_data_gate_parity[14], debug_data_gate_debug_data_gate_parity[13], debug_data_gate_debug_data_gate_parity[12], debug_data_gate_debug_data_gate_parity[11], debug_data_gate_debug_data_gate_parity[10], debug_data_gate_debug_data_gate_parity[9], debug_data_gate_debug_data_gate_parity[8], debug_data_gate_debug_data_gate_parity[7], debug_data_gate_debug_data_gate_parity[6], debug_data_gate_debug_data_gate_parity[5], debug_data_gate_debug_data_gate_parity[4], debug_data_gate_debug_data_gate_parity[3], debug_data_gate_debug_data_gate_parity[2], debug_data_gate_debug_data_gate_parity[1], debug_data_gate_debug_data_gate_parity[0]};

	assign debug_data_gate_parity_update = {(^debug_data_gate_parity_wdata[31:24]), (^debug_data_gate_parity_wdata[23:16]), (^debug_data_gate_parity_wdata[15:8]), (^debug_data_gate_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) debug_data_gate_parity_bit <= 4'b0;
	    else begin
	        if(debug_data_gate_parity_ena) debug_data_gate_parity_bit <= debug_data_gate_parity_update;
	    end
	end

	assign debug_data_gate_parity_check_bit = {(^debug_data_gate_parity_check_wdata[31:24]), (^debug_data_gate_parity_check_wdata[23:16]), (^debug_data_gate_parity_check_wdata[15:8]), (^debug_data_gate_parity_check_wdata[7:0])};

	assign debug_data_gate_parity_check_wdata = {debug_data_gate_debug_data_gate[31], debug_data_gate_debug_data_gate[30], debug_data_gate_debug_data_gate[29], debug_data_gate_debug_data_gate[28], debug_data_gate_debug_data_gate[27], debug_data_gate_debug_data_gate[26], debug_data_gate_debug_data_gate[25], debug_data_gate_debug_data_gate[24], debug_data_gate_debug_data_gate[23], debug_data_gate_debug_data_gate[22], debug_data_gate_debug_data_gate[21], debug_data_gate_debug_data_gate[20], debug_data_gate_debug_data_gate[19], debug_data_gate_debug_data_gate[18], debug_data_gate_debug_data_gate[17], debug_data_gate_debug_data_gate[16], debug_data_gate_debug_data_gate[15], debug_data_gate_debug_data_gate[14], debug_data_gate_debug_data_gate[13], debug_data_gate_debug_data_gate[12], debug_data_gate_debug_data_gate[11], debug_data_gate_debug_data_gate[10], debug_data_gate_debug_data_gate[9], debug_data_gate_debug_data_gate[8], debug_data_gate_debug_data_gate[7], debug_data_gate_debug_data_gate[6], debug_data_gate_debug_data_gate[5], debug_data_gate_debug_data_gate[4], debug_data_gate_debug_data_gate[3], debug_data_gate_debug_data_gate[2], debug_data_gate_debug_data_gate[1], debug_data_gate_debug_data_gate[0]};

	assign debug_data_gate_parity_check_err = (debug_data_gate_parity_check_bit != debug_data_gate_parity_bit);

	assign debug_data_gate_parity_hw_check_err = debug_data_gate_parity_check_err;

	assign hw_dbg_sel_rdat = {hw_dbg_sel_hw_dbg_sel};

	assign hw_dbg_sel_wdat = wreq_data;

	assign hw_dbg_sel_wvld = (wreq_vld & (wreq_addr == 16'h14));

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) hw_dbg_sel_hw_dbg_sel <= 32'b0;
	    else begin
	        if(hw_dbg_sel_hw_dbg_sel_sw_wren) hw_dbg_sel_hw_dbg_sel <= hw_dbg_sel_hw_dbg_sel_field_wdat;
	    end
	end

	assign hw_dbg_sel_hw_dbg_sel_rdat = hw_dbg_sel_hw_dbg_sel;

	assign hw_dbg_sel_hw_dbg_sel_sw_wren = (hw_dbg_sel_wvld);

	assign hw_dbg_sel_hw_dbg_sel_field_wdat = hw_dbg_sel_wdat[31:0];

	always @(*) begin
	    if(hw_dbg_sel_hw_dbg_sel_sw_wren) hw_dbg_sel_hw_dbg_sel_parity = hw_dbg_sel_hw_dbg_sel_field_wdat;
	    else hw_dbg_sel_hw_dbg_sel_parity = hw_dbg_sel_hw_dbg_sel;
	end

	assign hw_dbg_sel_parity_ena = (hw_dbg_sel_hw_dbg_sel_sw_wren);

	assign hw_dbg_sel_parity_wdata = {hw_dbg_sel_hw_dbg_sel_parity[31], hw_dbg_sel_hw_dbg_sel_parity[30], hw_dbg_sel_hw_dbg_sel_parity[29], hw_dbg_sel_hw_dbg_sel_parity[28], hw_dbg_sel_hw_dbg_sel_parity[27], hw_dbg_sel_hw_dbg_sel_parity[26], hw_dbg_sel_hw_dbg_sel_parity[25], hw_dbg_sel_hw_dbg_sel_parity[24], hw_dbg_sel_hw_dbg_sel_parity[23], hw_dbg_sel_hw_dbg_sel_parity[22], hw_dbg_sel_hw_dbg_sel_parity[21], hw_dbg_sel_hw_dbg_sel_parity[20], hw_dbg_sel_hw_dbg_sel_parity[19], hw_dbg_sel_hw_dbg_sel_parity[18], hw_dbg_sel_hw_dbg_sel_parity[17], hw_dbg_sel_hw_dbg_sel_parity[16], hw_dbg_sel_hw_dbg_sel_parity[15], hw_dbg_sel_hw_dbg_sel_parity[14], hw_dbg_sel_hw_dbg_sel_parity[13], hw_dbg_sel_hw_dbg_sel_parity[12], hw_dbg_sel_hw_dbg_sel_parity[11], hw_dbg_sel_hw_dbg_sel_parity[10], hw_dbg_sel_hw_dbg_sel_parity[9], hw_dbg_sel_hw_dbg_sel_parity[8], hw_dbg_sel_hw_dbg_sel_parity[7], hw_dbg_sel_hw_dbg_sel_parity[6], hw_dbg_sel_hw_dbg_sel_parity[5], hw_dbg_sel_hw_dbg_sel_parity[4], hw_dbg_sel_hw_dbg_sel_parity[3], hw_dbg_sel_hw_dbg_sel_parity[2], hw_dbg_sel_hw_dbg_sel_parity[1], hw_dbg_sel_hw_dbg_sel_parity[0]};

	assign hw_dbg_sel_parity_update = {(^hw_dbg_sel_parity_wdata[31:24]), (^hw_dbg_sel_parity_wdata[23:16]), (^hw_dbg_sel_parity_wdata[15:8]), (^hw_dbg_sel_parity_wdata[7:0])};

	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) hw_dbg_sel_parity_bit <= 4'b0;
	    else begin
	        if(hw_dbg_sel_parity_ena) hw_dbg_sel_parity_bit <= hw_dbg_sel_parity_update;
	    end
	end

	assign hw_dbg_sel_parity_check_bit = {(^hw_dbg_sel_parity_check_wdata[31:24]), (^hw_dbg_sel_parity_check_wdata[23:16]), (^hw_dbg_sel_parity_check_wdata[15:8]), (^hw_dbg_sel_parity_check_wdata[7:0])};

	assign hw_dbg_sel_parity_check_wdata = {hw_dbg_sel_hw_dbg_sel[31], hw_dbg_sel_hw_dbg_sel[30], hw_dbg_sel_hw_dbg_sel[29], hw_dbg_sel_hw_dbg_sel[28], hw_dbg_sel_hw_dbg_sel[27], hw_dbg_sel_hw_dbg_sel[26], hw_dbg_sel_hw_dbg_sel[25], hw_dbg_sel_hw_dbg_sel[24], hw_dbg_sel_hw_dbg_sel[23], hw_dbg_sel_hw_dbg_sel[22], hw_dbg_sel_hw_dbg_sel[21], hw_dbg_sel_hw_dbg_sel[20], hw_dbg_sel_hw_dbg_sel[19], hw_dbg_sel_hw_dbg_sel[18], hw_dbg_sel_hw_dbg_sel[17], hw_dbg_sel_hw_dbg_sel[16], hw_dbg_sel_hw_dbg_sel[15], hw_dbg_sel_hw_dbg_sel[14], hw_dbg_sel_hw_dbg_sel[13], hw_dbg_sel_hw_dbg_sel[12], hw_dbg_sel_hw_dbg_sel[11], hw_dbg_sel_hw_dbg_sel[10], hw_dbg_sel_hw_dbg_sel[9], hw_dbg_sel_hw_dbg_sel[8], hw_dbg_sel_hw_dbg_sel[7], hw_dbg_sel_hw_dbg_sel[6], hw_dbg_sel_hw_dbg_sel[5], hw_dbg_sel_hw_dbg_sel[4], hw_dbg_sel_hw_dbg_sel[3], hw_dbg_sel_hw_dbg_sel[2], hw_dbg_sel_hw_dbg_sel[1], hw_dbg_sel_hw_dbg_sel[0]};

	assign hw_dbg_sel_parity_check_err = (hw_dbg_sel_parity_check_bit != hw_dbg_sel_parity_bit);

	assign hw_dbg_sel_parity_hw_check_err = hw_dbg_sel_parity_check_err;


	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:5796fb5bef4b791477bec807c2cc55ff]

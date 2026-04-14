module intr_iniu_sys_spram_model_stub #(
	parameter integer unsigned ADDR_WIDTH = 12,
	parameter integer unsigned DATA_WIDTH = 20
) (
	input  logic                   clk,
	input  logic                   en,
	input  logic [ADDR_WIDTH-1:0]  addr,
	output logic [DATA_WIDTH-1:0]  rd_data,
	input  logic [DATA_WIDTH-1:0]  wr_data,
	input  logic                   wr_bit_en,
	input  logic                   wr_en
);

	fcip_spram_model #(
		.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_WIDTH(DATA_WIDTH)
	) u_fcip_spram_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en({DATA_WIDTH{wr_bit_en}}),
		.wr_en    (wr_en)
	);

endmodule

module intr_iniu_sys_spram_4096x20 (
	input  logic        clk,
	input  logic        en,
	input  logic [11:0] addr,
	output logic [19:0] rd_data,
	input  logic [19:0] wr_data,
	input  logic        wr_bit_en,
	input  logic        wr_en
);

	intr_iniu_sys_spram_model_stub #(
		.ADDR_WIDTH(12),
		.DATA_WIDTH(20)
	) u_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en(wr_bit_en),
		.wr_en    (wr_en)
	);

endmodule

module intr_iniu_sys_spram_2048x20 (
	input  logic        clk,
	input  logic        en,
	input  logic [10:0] addr,
	output logic [19:0] rd_data,
	input  logic [19:0] wr_data,
	input  logic        wr_bit_en,
	input  logic        wr_en
);

	intr_iniu_sys_spram_model_stub #(
		.ADDR_WIDTH(11),
		.DATA_WIDTH(20)
	) u_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en(wr_bit_en),
		.wr_en    (wr_en)
	);

endmodule

module intr_iniu_sys_spram_1024x20 (
	input  logic       clk,
	input  logic       en,
	input  logic [9:0] addr,
	output logic [19:0] rd_data,
	input  logic [19:0] wr_data,
	input  logic       wr_bit_en,
	input  logic       wr_en
);

	intr_iniu_sys_spram_model_stub #(
		.ADDR_WIDTH(10),
		.DATA_WIDTH(20)
	) u_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en(wr_bit_en),
		.wr_en    (wr_en)
	);

endmodule

module intr_iniu_sys_spram_512x20 (
	input  logic       clk,
	input  logic       en,
	input  logic [8:0] addr,
	output logic [19:0] rd_data,
	input  logic [19:0] wr_data,
	input  logic       wr_bit_en,
	input  logic       wr_en
);

	intr_iniu_sys_spram_model_stub #(
		.ADDR_WIDTH(9),
		.DATA_WIDTH(20)
	) u_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en(wr_bit_en),
		.wr_en    (wr_en)
	);

endmodule

module intr_iniu_sys_spram_256x20 (
	input  logic       clk,
	input  logic       en,
	input  logic [7:0] addr,
	output logic [19:0] rd_data,
	input  logic [19:0] wr_data,
	input  logic       wr_bit_en,
	input  logic       wr_en
);

	intr_iniu_sys_spram_model_stub #(
		.ADDR_WIDTH(8),
		.DATA_WIDTH(20)
	) u_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en(wr_bit_en),
		.wr_en    (wr_en)
	);

endmodule

module intr_iniu_sys_spram_128x20 (
	input  logic       clk,
	input  logic       en,
	input  logic [6:0] addr,
	output logic [19:0] rd_data,
	input  logic [19:0] wr_data,
	input  logic       wr_bit_en,
	input  logic       wr_en
);

	intr_iniu_sys_spram_model_stub #(
		.ADDR_WIDTH(7),
		.DATA_WIDTH(20)
	) u_model (
		.clk      (clk),
		.en       (en),
		.addr     (addr),
		.rd_data  (rd_data),
		.wr_data  (wr_data),
		.wr_bit_en(wr_bit_en),
		.wr_en    (wr_en)
	);

endmodule
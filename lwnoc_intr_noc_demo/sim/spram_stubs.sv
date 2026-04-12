// spram stubs for intr_ring_noc_4i2t testbench
// Provides behavioral SPRAM models for intr_iniu_sys_ and intr_tniu_sys_ prefixed wrappers
// All variants have the same interface; only address width differs.

`timescale 1ns/1ps

// ------ INIU variants ------

module intr_iniu_sys_spram_4096x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [11:0] addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:4095];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
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
    logic [19:0] mem [0:2047];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_iniu_sys_spram_1024x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [9:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:1023];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_iniu_sys_spram_512x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [8:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:511];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_iniu_sys_spram_256x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [7:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:255];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_iniu_sys_spram_128x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [6:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:127];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

// ------ TNIU variants ------

module intr_tniu_sys_spram_4096x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [11:0] addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:4095];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_tniu_sys_spram_2048x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [10:0] addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:2047];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_tniu_sys_spram_1024x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [9:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:1023];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_tniu_sys_spram_512x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [8:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:511];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_tniu_sys_spram_256x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [7:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:255];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

module intr_tniu_sys_spram_128x20 (
    input  logic        clk,
    input  logic        en,
    input  logic [6:0]  addr,
    output logic [19:0] rd_data,
    input  logic [19:0] wr_data,
    input  logic        wr_bit_en,
    input  logic        wr_en
);
    logic [19:0] mem [0:127];
    always_ff @(posedge clk) begin
        if (en) begin
            if (wr_en) mem[addr] <= wr_data;
            rd_data <= mem[addr];
        end
    end
endmodule

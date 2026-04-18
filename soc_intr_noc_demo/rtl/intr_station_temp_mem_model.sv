module `_PREFIX_(intr_station_temp_mem_model)
#(
    parameter integer unsigned ADDR_WIDTH = 6,
    parameter integer unsigned DATA_WIDTH = 64
)(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  en,
    input  logic                  wen,
    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [DATA_WIDTH-1:0] wdata,
    output logic [DATA_WIDTH-1:0] rdata
);

    localparam integer unsigned DEPTH = 1 << ADDR_WIDTH;

    logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= '0;
        end else if (en) begin
            if (wen) begin
                mem[addr] <= wdata;
            end
            rdata <= mem[addr];
        end
    end

endmodule
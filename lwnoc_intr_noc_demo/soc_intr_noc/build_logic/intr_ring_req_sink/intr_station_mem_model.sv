module intr_station_mem_model
#(
    parameter integer unsigned ADDR_WIDTH = `INTR_NETWORK_MEM_ADDR_WIDTH,
    parameter integer unsigned DATA_WIDTH = `INTR_NETWORK_MEM_DATA_WIDTH
)(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  en,
    input  logic                  wen,
    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [DATA_WIDTH-1:0] wdata,
    output logic [DATA_WIDTH-1:0] rdata
);

    logic [DATA_WIDTH-1:0] spram_rd_data;

    `ifdef INTR_STATION_SPRAM
        `INTR_STATION_SPRAM u_spram (
            .clk       (clk),
            .en        (en),
            .addr      (addr),
            .rd_data   (spram_rd_data),
            .wr_data   (wdata),
            .wr_bit_en ({DATA_WIDTH{wen}}),
            .wr_en     (wen)
        );
    `else
        fcip_spram_model #(
            .ADDR_WIDTH(ADDR_WIDTH),
            .DATA_WIDTH(DATA_WIDTH)
        ) u_fcip_spram_model (
            .clk       (clk),
            .en        (en),
            .addr      (addr),
            .rd_data   (spram_rd_data),
            .wr_data   (wdata),
            .wr_bit_en ({DATA_WIDTH{wen}}),
            .wr_en     (wen)
        );
    `endif

    // The backing SRAM has no reset; reset only the visible output register.
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= '0;
        end else begin
            rdata <= spram_rd_data;
        end
    end

endmodule

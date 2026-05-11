module pcie_eth_ss_iniu_spram_256x26 (
    input  logic                   clk         ,
    input  logic                   en          ,
    input  logic [7:0]    addr        ,
    output logic [25:0]    rd_data     ,
    input  logic [25:0]    wr_data     ,
    input  logic                   wr_bit_en   ,
    input  logic                   wr_en
);

    localparam integer unsigned ADDR_WIDTH = 8   ;
    localparam integer unsigned DATA_WIDTH = 26   ;

    `ifdef pcie_eth_ss_iniu_SPRAM_256X26
        pcie_eth_ss_iniu_`SPRAM_256X26
    `else
        `ifdef pcie_eth_ss_iniu_USE_CUST_MEM
            //TODO
        `else
            fcip_spram_model #(
                .ADDR_WIDTH(ADDR_WIDTH),
                .DATA_WIDTH(DATA_WIDTH)
            ) u_fcip_spram_model (
                .clk(clk),
                .en(en),
                .addr(addr),
                .rd_data(rd_data),
                .wr_data(wr_data),
                .wr_bit_en({DATA_WIDTH{wr_bit_en}}),
                .wr_en(wr_en)
            );

        `endif
    `endif

endmodule

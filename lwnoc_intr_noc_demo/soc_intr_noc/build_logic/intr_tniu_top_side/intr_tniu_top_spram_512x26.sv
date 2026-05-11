module intr_tniu_top_spram_512x26 (
    input  logic                   clk         ,
    input  logic                   en          ,
    input  logic [8:0]    addr        ,
    output logic [25:0]    rd_data     ,
    input  logic [25:0]    wr_data     ,
    input  logic                   wr_bit_en   ,
    input  logic                   wr_en
);

    localparam integer unsigned ADDR_WIDTH = 9   ;
    localparam integer unsigned DATA_WIDTH = 26   ;

    `ifdef intr_tniu_top_SPRAM_512X26
        intr_tniu_top_`SPRAM_512X26
    `else
        `ifdef intr_tniu_top_USE_CUST_MEM
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

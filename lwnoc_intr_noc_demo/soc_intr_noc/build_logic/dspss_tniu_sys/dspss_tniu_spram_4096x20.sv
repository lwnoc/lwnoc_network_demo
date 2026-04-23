module dspss_tniu_spram_4096x20 (
    input  logic                   clk         ,
    input  logic                   en          ,
    input  logic [11:0]    addr        ,
    output logic [19:0]    rd_data     ,
    input  logic [19:0]    wr_data     ,
    input  logic                   wr_bit_en   ,
    input  logic                   wr_en
);

    localparam integer unsigned ADDR_WIDTH = 12   ;
    localparam integer unsigned DATA_WIDTH = 20   ;

    `ifdef dspss_tniu_SPRAM_4096X20
        dspss_tniu_`SPRAM_4096X20
    `else
        `ifdef dspss_tniu_USE_CUST_MEM
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

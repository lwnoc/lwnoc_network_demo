module aon_ss_tniu_spram_1024x26 (
    input  logic                   clk         ,
    input  logic                   en          ,
    input  logic [9:0]    addr        ,
    output logic [25:0]    rd_data     ,
    input  logic [25:0]    wr_data     ,
    input  logic                   wr_bit_en   ,
    input  logic                   wr_en
);

    localparam integer unsigned ADDR_WIDTH = 10   ;
    localparam integer unsigned DATA_WIDTH = 26   ;

    `ifdef aon_ss_tniu_SPRAM_1024X26
        aon_ss_tniu_`SPRAM_1024X26
    `else
        `ifdef aon_ss_tniu_USE_CUST_MEM
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

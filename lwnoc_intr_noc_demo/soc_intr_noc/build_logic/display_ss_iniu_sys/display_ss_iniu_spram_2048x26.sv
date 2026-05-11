module display_ss_iniu_spram_2648x26 (
    input  logic                   clk         ,
    input  logic                   en          ,
    input  logic [10:0]    addr        ,
    output logic [25:0]    rd_data     ,
    input  logic [25:0]    wr_data     ,
    input  logic                   wr_bit_en   ,
    input  logic                   wr_en
);

    localparam integer unsigned ADDR_WIDTH = 11   ;
    localparam integer unsigned DATA_WIDTH = 26   ;

    `ifdef display_ss_iniu_SPRAM_2648X26
        display_ss_iniu_`SPRAM_2648X26
    `else
        `ifdef display_ss_iniu_USE_CUST_MEM
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

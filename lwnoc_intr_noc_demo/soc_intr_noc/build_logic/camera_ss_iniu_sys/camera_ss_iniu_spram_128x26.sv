module camera_ss_iniu_spram_128x26 (
    input  logic                   clk         ,
    input  logic                   en          ,
    input  logic [6:0]    addr        ,
    output logic [25:0]    rd_data     ,
    input  logic [25:0]    wr_data     ,
    input  logic                   wr_bit_en   ,
    input  logic                   wr_en
);

    localparam integer unsigned ADDR_WIDTH = 7   ;
    localparam integer unsigned DATA_WIDTH = 26   ;

    `ifdef camera_ss_iniu_SPRAM_128X26
        camera_ss_iniu_`SPRAM_128X26
    `else
        `ifdef camera_ss_iniu_USE_CUST_MEM
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

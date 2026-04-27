`ifndef mipi_ATB_DATA_WIDTH
    `define mipi_ATB_DATA_WIDTH 128
`endif

`ifndef mipi_ATB_ID_WIDTH
    `define mipi_ATB_ID_WIDTH 7
`endif

`ifndef mipi_ATB_BYTES_WIDTH
    `define mipi_ATB_BYTES_WIDTH $clog2(`mipi_ATB_DATA_WIDTH/8)
`endif

`ifndef mipi_ATB_PLD_WIDTH
    `define mipi_ATB_PLD_WIDTH (`mipi_ATB_DATA_WIDTH+`mipi_ATB_ID_WIDTH+`mipi_ATB_BYTES_WIDTH+1+1+1)
`endif

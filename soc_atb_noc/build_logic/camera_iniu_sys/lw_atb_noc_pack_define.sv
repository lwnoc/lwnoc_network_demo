`ifndef ATB_DATA_WIDTH
    `define ATB_DATA_WIDTH 128
`endif

`ifndef ATB_ID_WIDTH
    `define ATB_ID_WIDTH 7
`endif

`ifndef ATB_BYTES_WIDTH
    `define ATB_BYTES_WIDTH $clog2(`ATB_DATA_WIDTH/8)
`endif

`ifndef ATB_PLD_WIDTH
    `define ATB_PLD_WIDTH (`ATB_DATA_WIDTH+`ATB_ID_WIDTH+`ATB_BYTES_WIDTH+1+1+1)
`endif

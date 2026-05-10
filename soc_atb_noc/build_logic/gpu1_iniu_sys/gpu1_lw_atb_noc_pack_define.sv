`ifndef gpu1_ATB_DATA_WIDTH
    `define gpu1_ATB_DATA_WIDTH 128
`endif

`ifndef gpu1_ATB_ID_WIDTH
    `define gpu1_ATB_ID_WIDTH 7
`endif

`ifndef gpu1_ATB_BYTES_WIDTH
    `define gpu1_ATB_BYTES_WIDTH $clog2(`gpu1_ATB_DATA_WIDTH/8)
`endif

`ifndef gpu1_ATB_PLD_WIDTH
    `define gpu1_ATB_PLD_WIDTH (`gpu1_ATB_DATA_WIDTH+`gpu1_ATB_ID_WIDTH+`gpu1_ATB_BYTES_WIDTH+1+1+1)
`endif

`ifndef peri_ATB_DATA_WIDTH
    `define peri_ATB_DATA_WIDTH 128
`endif

`ifndef peri_ATB_ID_WIDTH
    `define peri_ATB_ID_WIDTH 7
`endif

`ifndef peri_ATB_BYTES_WIDTH
    `define peri_ATB_BYTES_WIDTH $clog2(`peri_ATB_DATA_WIDTH/8)
`endif

`ifndef peri_ATB_PLD_WIDTH
    `define peri_ATB_PLD_WIDTH (`peri_ATB_DATA_WIDTH+`peri_ATB_ID_WIDTH+`peri_ATB_BYTES_WIDTH+1+1+1)
`endif

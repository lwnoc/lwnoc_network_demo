`ifndef display_ATB_DATA_WIDTH
    `define display_ATB_DATA_WIDTH 128
`endif

`ifndef display_ATB_ID_WIDTH
    `define display_ATB_ID_WIDTH 7
`endif

`ifndef display_ATB_BYTES_WIDTH
    `define display_ATB_BYTES_WIDTH $clog2(`display_ATB_DATA_WIDTH/8)
`endif

`ifndef display_ATB_PLD_WIDTH
    `define display_ATB_PLD_WIDTH (`display_ATB_DATA_WIDTH+`display_ATB_ID_WIDTH+`display_ATB_BYTES_WIDTH+1+1+1)
`endif

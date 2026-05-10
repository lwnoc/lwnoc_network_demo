`ifndef cpu_ATB_DATA_WIDTH
    `define cpu_ATB_DATA_WIDTH 128
`endif

`ifndef cpu_ATB_ID_WIDTH
    `define cpu_ATB_ID_WIDTH 7
`endif

`ifndef cpu_ATB_BYTES_WIDTH
    `define cpu_ATB_BYTES_WIDTH $clog2(`cpu_ATB_DATA_WIDTH/8)
`endif

`ifndef cpu_ATB_PLD_WIDTH
    `define cpu_ATB_PLD_WIDTH (`cpu_ATB_DATA_WIDTH+`cpu_ATB_ID_WIDTH+`cpu_ATB_BYTES_WIDTH+1+1+1)
`endif

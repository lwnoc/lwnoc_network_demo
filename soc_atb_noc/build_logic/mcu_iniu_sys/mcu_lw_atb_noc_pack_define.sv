`ifndef mcu_ATB_DATA_WIDTH
    `define mcu_ATB_DATA_WIDTH 128
`endif

`ifndef mcu_ATB_ID_WIDTH
    `define mcu_ATB_ID_WIDTH 7
`endif

`ifndef mcu_ATB_BYTES_WIDTH
    `define mcu_ATB_BYTES_WIDTH $clog2(`mcu_ATB_DATA_WIDTH/8)
`endif

`ifndef mcu_ATB_PLD_WIDTH
    `define mcu_ATB_PLD_WIDTH (`mcu_ATB_DATA_WIDTH+`mcu_ATB_ID_WIDTH+`mcu_ATB_BYTES_WIDTH+1+1+1)
`endif

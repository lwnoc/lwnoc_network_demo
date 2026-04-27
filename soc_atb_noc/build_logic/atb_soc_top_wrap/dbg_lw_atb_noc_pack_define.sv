`ifndef dbg_ATB_DATA_WIDTH
    `define dbg_ATB_DATA_WIDTH 128
`endif

`ifndef dbg_ATB_ID_WIDTH
    `define dbg_ATB_ID_WIDTH 7
`endif

`ifndef dbg_ATB_BYTES_WIDTH
    `define dbg_ATB_BYTES_WIDTH $clog2(`dbg_ATB_DATA_WIDTH/8)
`endif

`ifndef dbg_ATB_PLD_WIDTH
    `define dbg_ATB_PLD_WIDTH (`dbg_ATB_DATA_WIDTH+`dbg_ATB_ID_WIDTH+`dbg_ATB_BYTES_WIDTH+1+1+1)
`endif

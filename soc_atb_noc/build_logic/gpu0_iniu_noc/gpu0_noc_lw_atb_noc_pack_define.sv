`ifndef gpu0_noc_ATB_DATA_WIDTH
    `define gpu0_noc_ATB_DATA_WIDTH 128
`endif

`ifndef gpu0_noc_ATB_ID_WIDTH
    `define gpu0_noc_ATB_ID_WIDTH 7
`endif

`ifndef gpu0_noc_ATB_BYTES_WIDTH
    `define gpu0_noc_ATB_BYTES_WIDTH $clog2(`gpu0_noc_ATB_DATA_WIDTH/8)
`endif

`ifndef gpu0_noc_ATB_PLD_WIDTH
    `define gpu0_noc_ATB_PLD_WIDTH (`gpu0_noc_ATB_DATA_WIDTH+`gpu0_noc_ATB_ID_WIDTH+`gpu0_noc_ATB_BYTES_WIDTH+1+1+1)
`endif

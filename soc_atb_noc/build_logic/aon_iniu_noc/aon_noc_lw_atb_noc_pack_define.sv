`ifndef aon_noc_ATB_DATA_WIDTH
    `define aon_noc_ATB_DATA_WIDTH 128
`endif

`ifndef aon_noc_ATB_ID_WIDTH
    `define aon_noc_ATB_ID_WIDTH 7
`endif

`ifndef aon_noc_ATB_BYTES_WIDTH
    `define aon_noc_ATB_BYTES_WIDTH $clog2(`aon_noc_ATB_DATA_WIDTH/8)
`endif

`ifndef aon_noc_ATB_PLD_WIDTH
    `define aon_noc_ATB_PLD_WIDTH (`aon_noc_ATB_DATA_WIDTH+`aon_noc_ATB_ID_WIDTH+`aon_noc_ATB_BYTES_WIDTH+1+1+1)
`endif

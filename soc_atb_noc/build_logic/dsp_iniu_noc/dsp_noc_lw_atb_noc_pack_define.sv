`ifndef dsp_noc_ATB_DATA_WIDTH
    `define dsp_noc_ATB_DATA_WIDTH 128
`endif

`ifndef dsp_noc_ATB_ID_WIDTH
    `define dsp_noc_ATB_ID_WIDTH 7
`endif

`ifndef dsp_noc_ATB_BYTES_WIDTH
    `define dsp_noc_ATB_BYTES_WIDTH $clog2(`dsp_noc_ATB_DATA_WIDTH/8)
`endif

`ifndef dsp_noc_ATB_PLD_WIDTH
    `define dsp_noc_ATB_PLD_WIDTH (`dsp_noc_ATB_DATA_WIDTH+`dsp_noc_ATB_ID_WIDTH+`dsp_noc_ATB_BYTES_WIDTH+1+1+1)
`endif

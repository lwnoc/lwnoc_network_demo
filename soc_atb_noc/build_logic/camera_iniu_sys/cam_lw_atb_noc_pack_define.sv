`ifndef cam_ATB_DATA_WIDTH
    `define cam_ATB_DATA_WIDTH 128
`endif

`ifndef cam_ATB_ID_WIDTH
    `define cam_ATB_ID_WIDTH 7
`endif

`ifndef cam_ATB_BYTES_WIDTH
    `define cam_ATB_BYTES_WIDTH $clog2(`cam_ATB_DATA_WIDTH/8)
`endif

`ifndef cam_ATB_PLD_WIDTH
    `define cam_ATB_PLD_WIDTH (`cam_ATB_DATA_WIDTH+`cam_ATB_ID_WIDTH+`cam_ATB_BYTES_WIDTH+1+1+1)
`endif

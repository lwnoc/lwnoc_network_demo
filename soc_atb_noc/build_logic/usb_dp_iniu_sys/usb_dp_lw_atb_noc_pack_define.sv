`ifndef usb_dp_ATB_DATA_WIDTH
    `define usb_dp_ATB_DATA_WIDTH 128
`endif

`ifndef usb_dp_ATB_ID_WIDTH
    `define usb_dp_ATB_ID_WIDTH 7
`endif

`ifndef usb_dp_ATB_BYTES_WIDTH
    `define usb_dp_ATB_BYTES_WIDTH $clog2(`usb_dp_ATB_DATA_WIDTH/8)
`endif

`ifndef usb_dp_ATB_PLD_WIDTH
    `define usb_dp_ATB_PLD_WIDTH (`usb_dp_ATB_DATA_WIDTH+`usb_dp_ATB_ID_WIDTH+`usb_dp_ATB_BYTES_WIDTH+1+1+1)
`endif

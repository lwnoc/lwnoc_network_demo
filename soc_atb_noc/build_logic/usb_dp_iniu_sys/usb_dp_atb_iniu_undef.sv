`ifdef usb_dp_ATB_INIU_FIFO_DEPTH
    `undef ATB_INIU_FIFO_DEPTH
`endif

`ifdef usb_dp_ATB_INIU_AUTO_CLEAR_EN
    `undef ATB_INIU_AUTO_CLEAR_EN
`endif

`ifdef usb_dp_ATB_INIU_SYNC_STAGE
    `undef ATB_INIU_SYNC_STAGE
`endif

`ifdef usb_dp_ATB_INIU_SYNC_BUF_DEPTH
    `undef ATB_INIU_SYNC_BUF_DEPTH
`endif

`ifdef usb_dp_ATB_INIU_ERR_INT_CNT_WIDTH
    `undef ATB_INIU_ERR_INT_CNT_WIDTH
`endif

`ifdef usb_dp__PREFIX_
    `undef _PREFIX_
`endif

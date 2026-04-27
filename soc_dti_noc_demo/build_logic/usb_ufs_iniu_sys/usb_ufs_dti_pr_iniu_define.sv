`ifndef usb_ufs__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef usb_ufs_TBU_NUM
    `define usb_ufs_TBU_NUM 4
`endif

`ifndef usb_ufs_TRANSACTION_MAX_NUM
    `define usb_ufs_TRANSACTION_MAX_NUM 8
`endif

`ifndef usb_ufs_INIU_TBU_NUM_WIDTH
    `define usb_ufs_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef usb_ufs_INIU_AXIS_MAX_DATA_WIDTH
    `define usb_ufs_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef usb_ufs_INIU_AXIS_DATA_WIDTH
    `define usb_ufs_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef usb_ufs_INIU_AXIS_KEEP_WIDTH
    `define usb_ufs_INIU_AXIS_KEEP_WIDTH (`usb_ufs_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef usb_ufs_INIU_CUSTOM_DATA_WIDTH
    `define usb_ufs_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef usb_ufs_INIU_CUSTOM_KEEP_WIDTH
    `define usb_ufs_INIU_CUSTOM_KEEP_WIDTH (`usb_ufs_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef dp__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef dp_TBU_NUM
    `define dp_TBU_NUM 4
`endif

`ifndef dp_TRANSACTION_MAX_NUM
    `define dp_TRANSACTION_MAX_NUM 8
`endif

`ifndef dp_INIU_TBU_NUM_WIDTH
    `define dp_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef dp_INIU_AXIS_MAX_DATA_WIDTH
    `define dp_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef dp_INIU_AXIS_DATA_WIDTH
    `define dp_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef dp_INIU_AXIS_KEEP_WIDTH
    `define dp_INIU_AXIS_KEEP_WIDTH (`dp_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef dp_INIU_CUSTOM_DATA_WIDTH
    `define dp_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef dp_INIU_CUSTOM_KEEP_WIDTH
    `define dp_INIU_CUSTOM_KEEP_WIDTH (`dp_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

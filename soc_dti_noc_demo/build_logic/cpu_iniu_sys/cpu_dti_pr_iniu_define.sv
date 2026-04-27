`ifndef cpu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef cpu_TBU_NUM
    `define cpu_TBU_NUM 4
`endif

`ifndef cpu_TRANSACTION_MAX_NUM
    `define cpu_TRANSACTION_MAX_NUM 8
`endif

`ifndef cpu_INIU_TBU_NUM_WIDTH
    `define cpu_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef cpu_INIU_AXIS_MAX_DATA_WIDTH
    `define cpu_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef cpu_INIU_AXIS_DATA_WIDTH
    `define cpu_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef cpu_INIU_AXIS_KEEP_WIDTH
    `define cpu_INIU_AXIS_KEEP_WIDTH (`cpu_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef cpu_INIU_CUSTOM_DATA_WIDTH
    `define cpu_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef cpu_INIU_CUSTOM_KEEP_WIDTH
    `define cpu_INIU_CUSTOM_KEEP_WIDTH (`cpu_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef gpu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef gpu_TBU_NUM
    `define gpu_TBU_NUM 4
`endif

`ifndef gpu_TRANSACTION_MAX_NUM
    `define gpu_TRANSACTION_MAX_NUM 8
`endif

`ifndef gpu_INIU_TBU_NUM_WIDTH
    `define gpu_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef gpu_INIU_AXIS_MAX_DATA_WIDTH
    `define gpu_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef gpu_INIU_AXIS_DATA_WIDTH
    `define gpu_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef gpu_INIU_AXIS_KEEP_WIDTH
    `define gpu_INIU_AXIS_KEEP_WIDTH (`gpu_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef gpu_INIU_CUSTOM_DATA_WIDTH
    `define gpu_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef gpu_INIU_CUSTOM_KEEP_WIDTH
    `define gpu_INIU_CUSTOM_KEEP_WIDTH (`gpu_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef display__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef display_TBU_NUM
    `define display_TBU_NUM 4
`endif

`ifndef display_TRANSACTION_MAX_NUM
    `define display_TRANSACTION_MAX_NUM 8
`endif

`ifndef display_INIU_TBU_NUM_WIDTH
    `define display_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef display_INIU_AXIS_MAX_DATA_WIDTH
    `define display_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef display_INIU_AXIS_DATA_WIDTH
    `define display_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef display_INIU_AXIS_KEEP_WIDTH
    `define display_INIU_AXIS_KEEP_WIDTH (`display_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef display_INIU_CUSTOM_DATA_WIDTH
    `define display_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef display_INIU_CUSTOM_KEEP_WIDTH
    `define display_INIU_CUSTOM_KEEP_WIDTH (`display_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

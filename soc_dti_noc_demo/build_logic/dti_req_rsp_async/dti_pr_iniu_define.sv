`ifndef _PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef TBU_NUM
    `define TBU_NUM 4
`endif

`ifndef TRANSACTION_MAX_NUM
    `define TRANSACTION_MAX_NUM 8
`endif

`ifndef INIU_TBU_NUM_WIDTH
    `define INIU_TBU_NUM_WIDTH 6
`endif

`ifndef INIU_AXIS_MAX_DATA_WIDTH
    `define INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef INIU_AXIS_DATA_WIDTH
    `define INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef INIU_AXIS_KEEP_WIDTH
    `define INIU_AXIS_KEEP_WIDTH (`INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef INIU_CUSTOM_DATA_WIDTH
    `define INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef INIU_CUSTOM_KEEP_WIDTH
    `define INIU_CUSTOM_KEEP_WIDTH (`INIU_CUSTOM_DATA_WIDTH / 8)
`endif

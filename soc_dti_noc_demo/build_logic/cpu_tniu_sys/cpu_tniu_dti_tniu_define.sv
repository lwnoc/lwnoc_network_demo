`ifndef cpu_tniu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef cpu_tniu_TBU_NUM
    `define cpu_tniu_TBU_NUM 4
`endif

`ifndef cpu_tniu_TRANSACTION_MAX_NUM
    `define cpu_tniu_TRANSACTION_MAX_NUM 8
`endif

`ifndef cpu_tniu_TNIU_TBU_NUM_WIDTH
    `define cpu_tniu_TNIU_TBU_NUM_WIDTH 6
`endif

`ifndef cpu_tniu_TNIU_AXIS_DATA_WIDTH
    `define cpu_tniu_TNIU_AXIS_DATA_WIDTH 80
`endif

`ifndef cpu_tniu_TNIU_AXIS_KEEP_WIDTH
    `define cpu_tniu_TNIU_AXIS_KEEP_WIDTH (`cpu_tniu_TNIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef cpu_tniu_TNIU_CUSTOM_DATA_WIDTH
    `define cpu_tniu_TNIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef cpu_tniu_TNIU_CUSTOM_KEEP_WIDTH
    `define cpu_tniu_TNIU_CUSTOM_KEEP_WIDTH (`cpu_tniu_TNIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef cpu_tniu_TNIU_ASYNC_FIFO_DEPTH
    `define cpu_tniu_TNIU_ASYNC_FIFO_DEPTH 10
`endif

`ifndef cpu_tniu_TNIU_ERR_INT_CNT_WIDTH
    `define cpu_tniu_TNIU_ERR_INT_CNT_WIDTH 16
`endif

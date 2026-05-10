`ifndef camera__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef camera_TBU_NUM
    `define camera_TBU_NUM 4
`endif

`ifndef camera_TRANSACTION_MAX_NUM
    `define camera_TRANSACTION_MAX_NUM 8
`endif

`ifndef camera_INIU_TBU_NUM_WIDTH
    `define camera_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef camera_INIU_AXIS_MAX_DATA_WIDTH
    `define camera_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef camera_INIU_AXIS_DATA_WIDTH
    `define camera_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef camera_INIU_AXIS_KEEP_WIDTH
    `define camera_INIU_AXIS_KEEP_WIDTH (`camera_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef camera_INIU_CUSTOM_DATA_WIDTH
    `define camera_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef camera_INIU_CUSTOM_KEEP_WIDTH
    `define camera_INIU_CUSTOM_KEEP_WIDTH (`camera_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef camera_INIU_ASYNC_FIFO_DEPTH
    `define camera_INIU_ASYNC_FIFO_DEPTH 16
`endif

`ifndef camera_INIU_TIME_OUT_WIDTH
    `define camera_INIU_TIME_OUT_WIDTH 10
`endif

`ifndef camera_INIU_ROUTE_BASE
    `define camera_INIU_ROUTE_BASE 0
`endif

`ifndef camera_INIU_ERR_INT_CNT_WIDTH
    `define camera_INIU_ERR_INT_CNT_WIDTH 16
`endif

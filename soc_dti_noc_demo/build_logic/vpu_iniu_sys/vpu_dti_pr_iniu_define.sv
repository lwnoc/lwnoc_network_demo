`ifndef vpu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef vpu_TBU_NUM
    `define vpu_TBU_NUM 4
`endif

`ifndef vpu_TRANSACTION_MAX_NUM
    `define vpu_TRANSACTION_MAX_NUM 8
`endif

`ifndef vpu_INIU_TBU_NUM_WIDTH
    `define vpu_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef vpu_INIU_AXIS_MAX_DATA_WIDTH
    `define vpu_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef vpu_INIU_AXIS_DATA_WIDTH
    `define vpu_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef vpu_INIU_AXIS_KEEP_WIDTH
    `define vpu_INIU_AXIS_KEEP_WIDTH (`vpu_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef vpu_INIU_CUSTOM_DATA_WIDTH
    `define vpu_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef vpu_INIU_CUSTOM_KEEP_WIDTH
    `define vpu_INIU_CUSTOM_KEEP_WIDTH (`vpu_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef vpu_INIU_ASYNC_FIFO_DEPTH
    `define vpu_INIU_ASYNC_FIFO_DEPTH 16
`endif

`ifndef vpu_INIU_TIME_OUT_WIDTH
    `define vpu_INIU_TIME_OUT_WIDTH 10
`endif

`ifndef vpu_INIU_ROUTE_BASE
    `define vpu_INIU_ROUTE_BASE 0
`endif

`ifndef vpu_INIU_ERR_INT_CNT_WIDTH
    `define vpu_INIU_ERR_INT_CNT_WIDTH 16
`endif

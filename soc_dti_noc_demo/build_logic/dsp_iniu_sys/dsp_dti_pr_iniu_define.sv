`ifndef dsp__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef dsp_TBU_NUM
    `define dsp_TBU_NUM 4
`endif

`ifndef dsp_TRANSACTION_MAX_NUM
    `define dsp_TRANSACTION_MAX_NUM 8
`endif

`ifndef dsp_INIU_TBU_NUM_WIDTH
    `define dsp_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef dsp_INIU_AXIS_MAX_DATA_WIDTH
    `define dsp_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef dsp_INIU_AXIS_DATA_WIDTH
    `define dsp_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef dsp_INIU_AXIS_KEEP_WIDTH
    `define dsp_INIU_AXIS_KEEP_WIDTH (`dsp_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef dsp_INIU_CUSTOM_DATA_WIDTH
    `define dsp_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef dsp_INIU_CUSTOM_KEEP_WIDTH
    `define dsp_INIU_CUSTOM_KEEP_WIDTH (`dsp_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef dsp_INIU_ASYNC_FIFO_DEPTH
    `define dsp_INIU_ASYNC_FIFO_DEPTH 16
`endif

`ifndef dsp_INIU_TIME_OUT_WIDTH
    `define dsp_INIU_TIME_OUT_WIDTH 10
`endif

`ifndef dsp_INIU_ROUTE_BASE
    `define dsp_INIU_ROUTE_BASE 0
`endif

`ifndef dsp_INIU_ERR_INT_CNT_WIDTH
    `define dsp_INIU_ERR_INT_CNT_WIDTH 16
`endif

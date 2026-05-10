`ifndef dti_iniu_top_display_ss__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef dti_iniu_top_display_ss_TBU_NUM
    `define dti_iniu_top_display_ss_TBU_NUM 4
`endif

`ifndef dti_iniu_top_display_ss_TRANSACTION_MAX_NUM
    `define dti_iniu_top_display_ss_TRANSACTION_MAX_NUM 8
`endif

`ifndef dti_iniu_top_display_ss_INIU_TBU_NUM_WIDTH
    `define dti_iniu_top_display_ss_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef dti_iniu_top_display_ss_INIU_AXIS_MAX_DATA_WIDTH
    `define dti_iniu_top_display_ss_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef dti_iniu_top_display_ss_INIU_AXIS_DATA_WIDTH
    `define dti_iniu_top_display_ss_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef dti_iniu_top_display_ss_INIU_AXIS_KEEP_WIDTH
    `define dti_iniu_top_display_ss_INIU_AXIS_KEEP_WIDTH (`dti_iniu_top_display_ss_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef dti_iniu_top_display_ss_INIU_CUSTOM_DATA_WIDTH
    `define dti_iniu_top_display_ss_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef dti_iniu_top_display_ss_INIU_CUSTOM_KEEP_WIDTH
    `define dti_iniu_top_display_ss_INIU_CUSTOM_KEEP_WIDTH (`dti_iniu_top_display_ss_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef dti_iniu_top_display_ss_INIU_ASYNC_FIFO_DEPTH
    `define dti_iniu_top_display_ss_INIU_ASYNC_FIFO_DEPTH 16
`endif

`ifndef dti_iniu_top_display_ss_INIU_TIME_OUT_WIDTH
    `define dti_iniu_top_display_ss_INIU_TIME_OUT_WIDTH 10
`endif

`ifndef dti_iniu_top_display_ss_INIU_ROUTE_BASE
    `define dti_iniu_top_display_ss_INIU_ROUTE_BASE 0
`endif

`ifndef dti_iniu_top_display_ss_INIU_ERR_INT_CNT_WIDTH
    `define dti_iniu_top_display_ss_INIU_ERR_INT_CNT_WIDTH 16
`endif

`ifndef dti_sw1__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef dti_sw1_TBU_NUM
    `define dti_sw1_TBU_NUM 4
`endif

`ifndef dti_sw1_TRANSACTION_MAX_NUM
    `define dti_sw1_TRANSACTION_MAX_NUM 8
`endif

`ifndef dti_sw1_INIU_TBU_NUM_WIDTH
    `define dti_sw1_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef dti_sw1_INIU_AXIS_MAX_DATA_WIDTH
    `define dti_sw1_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef dti_sw1_INIU_AXIS_DATA_WIDTH
    `define dti_sw1_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef dti_sw1_INIU_AXIS_KEEP_WIDTH
    `define dti_sw1_INIU_AXIS_KEEP_WIDTH (`dti_sw1_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef dti_sw1_INIU_CUSTOM_DATA_WIDTH
    `define dti_sw1_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef dti_sw1_INIU_CUSTOM_KEEP_WIDTH
    `define dti_sw1_INIU_CUSTOM_KEEP_WIDTH (`dti_sw1_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef dti_tniu_top__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef dti_tniu_top_TBU_NUM
    `define dti_tniu_top_TBU_NUM 4
`endif

`ifndef dti_tniu_top_TRANSACTION_MAX_NUM
    `define dti_tniu_top_TRANSACTION_MAX_NUM 8
`endif

`ifndef dti_tniu_top_TNIU_TBU_NUM_WIDTH
    `define dti_tniu_top_TNIU_TBU_NUM_WIDTH 6
`endif

`ifndef dti_tniu_top_TNIU_AXIS_DATA_WIDTH
    `define dti_tniu_top_TNIU_AXIS_DATA_WIDTH 80
`endif

`ifndef dti_tniu_top_TNIU_AXIS_KEEP_WIDTH
    `define dti_tniu_top_TNIU_AXIS_KEEP_WIDTH (`dti_tniu_top_TNIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef dti_tniu_top_TNIU_CUSTOM_DATA_WIDTH
    `define dti_tniu_top_TNIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef dti_tniu_top_TNIU_CUSTOM_KEEP_WIDTH
    `define dti_tniu_top_TNIU_CUSTOM_KEEP_WIDTH (`dti_tniu_top_TNIU_CUSTOM_DATA_WIDTH / 8)
`endif

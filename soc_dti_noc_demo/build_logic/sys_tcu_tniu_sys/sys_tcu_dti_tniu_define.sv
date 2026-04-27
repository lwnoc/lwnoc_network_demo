`ifndef sys_tcu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef sys_tcu_TBU_NUM
    `define sys_tcu_TBU_NUM 4
`endif

`ifndef sys_tcu_TRANSACTION_MAX_NUM
    `define sys_tcu_TRANSACTION_MAX_NUM 8
`endif

`ifndef sys_tcu_TNIU_TBU_NUM_WIDTH
    `define sys_tcu_TNIU_TBU_NUM_WIDTH 6
`endif

`ifndef sys_tcu_TNIU_AXIS_DATA_WIDTH
    `define sys_tcu_TNIU_AXIS_DATA_WIDTH 80
`endif

`ifndef sys_tcu_TNIU_AXIS_KEEP_WIDTH
    `define sys_tcu_TNIU_AXIS_KEEP_WIDTH (`sys_tcu_TNIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef sys_tcu_TNIU_CUSTOM_DATA_WIDTH
    `define sys_tcu_TNIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef sys_tcu_TNIU_CUSTOM_KEEP_WIDTH
    `define sys_tcu_TNIU_CUSTOM_KEEP_WIDTH (`sys_tcu_TNIU_CUSTOM_DATA_WIDTH / 8)
`endif

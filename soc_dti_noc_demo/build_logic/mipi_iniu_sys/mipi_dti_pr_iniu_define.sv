`ifndef mipi__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef mipi_TBU_NUM
    `define mipi_TBU_NUM 4
`endif

`ifndef mipi_TRANSACTION_MAX_NUM
    `define mipi_TRANSACTION_MAX_NUM 8
`endif

`ifndef mipi_INIU_TBU_NUM_WIDTH
    `define mipi_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef mipi_INIU_AXIS_MAX_DATA_WIDTH
    `define mipi_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef mipi_INIU_AXIS_DATA_WIDTH
    `define mipi_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef mipi_INIU_AXIS_KEEP_WIDTH
    `define mipi_INIU_AXIS_KEEP_WIDTH (`mipi_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef mipi_INIU_CUSTOM_DATA_WIDTH
    `define mipi_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef mipi_INIU_CUSTOM_KEEP_WIDTH
    `define mipi_INIU_CUSTOM_KEEP_WIDTH (`mipi_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef pcie_eth__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef pcie_eth_TBU_NUM
    `define pcie_eth_TBU_NUM 4
`endif

`ifndef pcie_eth_TRANSACTION_MAX_NUM
    `define pcie_eth_TRANSACTION_MAX_NUM 8
`endif

`ifndef pcie_eth_INIU_TBU_NUM_WIDTH
    `define pcie_eth_INIU_TBU_NUM_WIDTH 6
`endif

`ifndef pcie_eth_INIU_AXIS_MAX_DATA_WIDTH
    `define pcie_eth_INIU_AXIS_MAX_DATA_WIDTH 160
`endif

`ifndef pcie_eth_INIU_AXIS_DATA_WIDTH
    `define pcie_eth_INIU_AXIS_DATA_WIDTH 80
`endif

`ifndef pcie_eth_INIU_AXIS_KEEP_WIDTH
    `define pcie_eth_INIU_AXIS_KEEP_WIDTH (`pcie_eth_INIU_AXIS_DATA_WIDTH / 8)
`endif

`ifndef pcie_eth_INIU_CUSTOM_DATA_WIDTH
    `define pcie_eth_INIU_CUSTOM_DATA_WIDTH 80
`endif

`ifndef pcie_eth_INIU_CUSTOM_KEEP_WIDTH
    `define pcie_eth_INIU_CUSTOM_KEEP_WIDTH (`pcie_eth_INIU_CUSTOM_DATA_WIDTH / 8)
`endif

`ifndef pcie_eth_ss_iniu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

// ---------------------------------------------------------------------------
// Interrupt INIU configurable parameters
// Override before including this file to customize the instance.
// ---------------------------------------------------------------------------
`ifndef pcie_eth_ss_iniu_INTR_INIU_OVERFLOW_TGT_ID
    `define pcie_eth_ss_iniu_INTR_INIU_OVERFLOW_TGT_ID          0
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_OVERFLOW_TGT_INTR_ID
    `define pcie_eth_ss_iniu_INTR_INIU_OVERFLOW_TGT_INTR_ID     0
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_INTERRUPT_MAX_NUM
    `define pcie_eth_ss_iniu_INTR_INIU_INTERRUPT_MAX_NUM         4096
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_TIME_OUT_WIDTH
    `define pcie_eth_ss_iniu_INTR_INIU_TIME_OUT_WIDTH            10
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_SYS_ASYNC_FIFO_DEPTH
    `define pcie_eth_ss_iniu_INTR_INIU_SYS_ASYNC_FIFO_DEPTH      16
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_TOP_ASYNC_FIFO_DEPTH
    `define pcie_eth_ss_iniu_INTR_INIU_TOP_ASYNC_FIFO_DEPTH      10
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_FUSA_ECC_EN
    `define pcie_eth_ss_iniu_INTR_INIU_FUSA_ECC_EN               1'b0
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_ERR_INT_CNT_WIDTH
    `define pcie_eth_ss_iniu_INTR_INIU_ERR_INT_CNT_WIDTH         16
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_NIU_ID_WIDTH
    `define pcie_eth_ss_iniu_INTR_INIU_NIU_ID_WIDTH              8
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_INTR_ID_WIDTH
    `define pcie_eth_ss_iniu_INTR_INIU_INTR_ID_WIDTH             12
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_LUT_BASE_ADDR
    `define pcie_eth_ss_iniu_INTR_INIU_LUT_BASE_ADDR             32'h4000
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_PULSE_MODE_BASE_ADDR
    `define pcie_eth_ss_iniu_INTR_INIU_PULSE_MODE_BASE_ADDR      32'h8000
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_EVENT_COUNT_MAX
    `define pcie_eth_ss_iniu_INTR_INIU_EVENT_COUNT_MAX           16
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_ARB_LEVEL_0
    `define pcie_eth_ss_iniu_INTR_INIU_ARB_LEVEL_0               16
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_ARB_LEVEL_1
    `define pcie_eth_ss_iniu_INTR_INIU_ARB_LEVEL_1               512
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_ARB_LEVEL_2
    `define pcie_eth_ss_iniu_INTR_INIU_ARB_LEVEL_2               4096
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_IDLE_DELAY_MAX
    `define pcie_eth_ss_iniu_INTR_INIU_IDLE_DELAY_MAX            8
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_EVENT_REQ
    `define pcie_eth_ss_iniu_INTR_INIU_EVENT_REQ                 0
`endif
`ifndef pcie_eth_ss_iniu_INTR_INIU_APB_REQ
    `define pcie_eth_ss_iniu_INTR_INIU_APB_REQ                   1
`endif

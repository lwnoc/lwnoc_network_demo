`ifndef vpu_ss_iniu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

// ---------------------------------------------------------------------------
// Interrupt INIU configurable parameters
// Override before including this file to customize the instance.
// ---------------------------------------------------------------------------
`ifndef vpu_ss_iniu_INTR_INIU_OVERFLOW_TGT_ID
    `define vpu_ss_iniu_INTR_INIU_OVERFLOW_TGT_ID          0
`endif
`ifndef vpu_ss_iniu_INTR_INIU_OVERFLOW_TGT_INTR_ID
    `define vpu_ss_iniu_INTR_INIU_OVERFLOW_TGT_INTR_ID     0
`endif
`ifndef vpu_ss_iniu_INTR_INIU_INTERRUPT_MAX_NUM
    `define vpu_ss_iniu_INTR_INIU_INTERRUPT_MAX_NUM         4096
`endif
`ifndef vpu_ss_iniu_INTR_INIU_NIU_ID_WIDTH
    `define vpu_ss_iniu_INTR_INIU_NIU_ID_WIDTH              8
`endif
`ifndef vpu_ss_iniu_INTR_INIU_INTR_ID_WIDTH
    `define vpu_ss_iniu_INTR_INIU_INTR_ID_WIDTH             12
`endif
`ifndef vpu_ss_iniu_INTR_INIU_LUT_BASE_ADDR
    `define vpu_ss_iniu_INTR_INIU_LUT_BASE_ADDR             32'h4000
`endif
`ifndef vpu_ss_iniu_INTR_INIU_PULSE_MODE_BASE_ADDR
    `define vpu_ss_iniu_INTR_INIU_PULSE_MODE_BASE_ADDR      32'h8000
`endif
`ifndef vpu_ss_iniu_INTR_INIU_EVENT_COUNT_MAX
    `define vpu_ss_iniu_INTR_INIU_EVENT_COUNT_MAX           16
`endif
`ifndef vpu_ss_iniu_INTR_INIU_ARB_LEVEL_0
    `define vpu_ss_iniu_INTR_INIU_ARB_LEVEL_0               16
`endif
`ifndef vpu_ss_iniu_INTR_INIU_ARB_LEVEL_1
    `define vpu_ss_iniu_INTR_INIU_ARB_LEVEL_1               512
`endif
`ifndef vpu_ss_iniu_INTR_INIU_ARB_LEVEL_2
    `define vpu_ss_iniu_INTR_INIU_ARB_LEVEL_2               4096
`endif
`ifndef vpu_ss_iniu_INTR_INIU_IDLE_DELAY_MAX
    `define vpu_ss_iniu_INTR_INIU_IDLE_DELAY_MAX            8
`endif
`ifndef vpu_ss_iniu_INTR_INIU_EVENT_REQ
    `define vpu_ss_iniu_INTR_INIU_EVENT_REQ                 0
`endif
`ifndef vpu_ss_iniu_INTR_INIU_APB_REQ
    `define vpu_ss_iniu_INTR_INIU_APB_REQ                   1
`endif

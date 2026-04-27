// Interrupt INIU macro cleanup
// Include at the end of iniu_filelist.f to prevent macro leakage into
// downstream compilation units.

`ifdef cpu_ss_iniu_INTR_INIU_OVERFLOW_TGT_ID
    `undef INTR_INIU_OVERFLOW_TGT_ID
`endif
`ifdef cpu_ss_iniu_INTR_INIU_OVERFLOW_TGT_INTR_ID
    `undef INTR_INIU_OVERFLOW_TGT_INTR_ID
`endif
`ifdef cpu_ss_iniu_INTR_INIU_INTERRUPT_MAX_NUM
    `undef INTR_INIU_INTERRUPT_MAX_NUM
`endif
`ifdef cpu_ss_iniu_INTR_INIU_NIU_ID_WIDTH
    `undef INTR_INIU_NIU_ID_WIDTH
`endif
`ifdef cpu_ss_iniu_INTR_INIU_INTR_ID_WIDTH
    `undef INTR_INIU_INTR_ID_WIDTH
`endif
`ifdef cpu_ss_iniu_INTR_INIU_LUT_BASE_ADDR
    `undef INTR_INIU_LUT_BASE_ADDR
`endif
`ifdef cpu_ss_iniu_INTR_INIU_PULSE_MODE_BASE_ADDR
    `undef INTR_INIU_PULSE_MODE_BASE_ADDR
`endif
`ifdef cpu_ss_iniu_INTR_INIU_EVENT_COUNT_MAX
    `undef INTR_INIU_EVENT_COUNT_MAX
`endif
`ifdef cpu_ss_iniu_INTR_INIU_ARB_LEVEL_0
    `undef INTR_INIU_ARB_LEVEL_0
`endif
`ifdef cpu_ss_iniu_INTR_INIU_ARB_LEVEL_1
    `undef INTR_INIU_ARB_LEVEL_1
`endif
`ifdef cpu_ss_iniu_INTR_INIU_ARB_LEVEL_2
    `undef INTR_INIU_ARB_LEVEL_2
`endif
`ifdef cpu_ss_iniu_INTR_INIU_IDLE_DELAY_MAX
    `undef INTR_INIU_IDLE_DELAY_MAX
`endif
`ifdef cpu_ss_iniu_INTR_INIU_EVENT_REQ
    `undef INTR_INIU_EVENT_REQ
`endif
`ifdef cpu_ss_iniu_INTR_INIU_APB_REQ
    `undef INTR_INIU_APB_REQ
`endif

// Clean up _PREFIX_ macro to prevent leakage into other components
`ifdef cpu_ss_iniu__PREFIX_
    `undef _PREFIX_
`endif

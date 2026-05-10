// Interrupt INIU macro cleanup
// Include at the end of iniu_filelist.f to prevent macro leakage into
// downstream compilation units.

`ifdef ufs_ss_iniu_INTR_INIU_OVERFLOW_TGT_ID
    `undef INTR_INIU_OVERFLOW_TGT_ID
`endif
`ifdef ufs_ss_iniu_INTR_INIU_OVERFLOW_TGT_INTR_ID
    `undef INTR_INIU_OVERFLOW_TGT_INTR_ID
`endif
`ifdef ufs_ss_iniu_INTR_INIU_INTERRUPT_MAX_NUM
    `undef INTR_INIU_INTERRUPT_MAX_NUM
`endif
`ifdef ufs_ss_iniu_INTR_INIU_TIME_OUT_WIDTH
    `undef INTR_INIU_TIME_OUT_WIDTH
`endif
`ifdef ufs_ss_iniu_INTR_INIU_SYS_ASYNC_FIFO_DEPTH
    `undef INTR_INIU_SYS_ASYNC_FIFO_DEPTH
`endif
`ifdef ufs_ss_iniu_INTR_INIU_TOP_ASYNC_FIFO_DEPTH
    `undef INTR_INIU_TOP_ASYNC_FIFO_DEPTH
`endif
`ifdef ufs_ss_iniu_INTR_INIU_FUSA_ECC_EN
    `undef INTR_INIU_FUSA_ECC_EN
`endif
`ifdef ufs_ss_iniu_INTR_INIU_ERR_INT_CNT_WIDTH
    `undef INTR_INIU_ERR_INT_CNT_WIDTH
`endif
`ifdef ufs_ss_iniu_INTR_INIU_NIU_ID_WIDTH
    `undef INTR_INIU_NIU_ID_WIDTH
`endif
`ifdef ufs_ss_iniu_INTR_INIU_INTR_ID_WIDTH
    `undef INTR_INIU_INTR_ID_WIDTH
`endif
`ifdef ufs_ss_iniu_INTR_INIU_LUT_BASE_ADDR
    `undef INTR_INIU_LUT_BASE_ADDR
`endif
`ifdef ufs_ss_iniu_INTR_INIU_PULSE_MODE_BASE_ADDR
    `undef INTR_INIU_PULSE_MODE_BASE_ADDR
`endif
`ifdef ufs_ss_iniu_INTR_INIU_EVENT_COUNT_MAX
    `undef INTR_INIU_EVENT_COUNT_MAX
`endif
`ifdef ufs_ss_iniu_INTR_INIU_ARB_LEVEL_0
    `undef INTR_INIU_ARB_LEVEL_0
`endif
`ifdef ufs_ss_iniu_INTR_INIU_ARB_LEVEL_1
    `undef INTR_INIU_ARB_LEVEL_1
`endif
`ifdef ufs_ss_iniu_INTR_INIU_ARB_LEVEL_2
    `undef INTR_INIU_ARB_LEVEL_2
`endif
`ifdef ufs_ss_iniu_INTR_INIU_IDLE_DELAY_MAX
    `undef INTR_INIU_IDLE_DELAY_MAX
`endif
`ifdef ufs_ss_iniu_INTR_INIU_EVENT_REQ
    `undef INTR_INIU_EVENT_REQ
`endif
`ifdef ufs_ss_iniu_INTR_INIU_APB_REQ
    `undef INTR_INIU_APB_REQ
`endif

// Note: _PREFIX_ is intentionally NOT undefed here — it is shared with
//       other files in interrupt_noc_top_wrap.f and must outlive this IP.

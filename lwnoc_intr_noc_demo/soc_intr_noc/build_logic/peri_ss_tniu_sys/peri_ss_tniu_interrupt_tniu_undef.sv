// Interrupt TNIU macro cleanup
// Include at the end of tniu_filelist.f to prevent macro leakage into
// downstream compilation units.
// Note: _PREFIX_ is intentionally NOT undefed here — it is shared with
//       other files in interrupt_noc_top_wrap.f and must outlive this IP.

`ifdef peri_ss_tniu_INTR_TNIU_OVERFLOW_TGT_ID
    `undef INTR_TNIU_OVERFLOW_TGT_ID
`endif
`ifdef peri_ss_tniu_INTR_TNIU_OVERFLOW_TGT_INTR_ID
    `undef INTR_TNIU_OVERFLOW_TGT_INTR_ID
`endif
`ifdef peri_ss_tniu_INTR_TNIU_TIMER_COUNT
    `undef INTR_TNIU_TIMER_COUNT
`endif
`ifdef peri_ss_tniu_INTR_TNIU_NIU_ID_WIDTH
    `undef INTR_TNIU_NIU_ID_WIDTH
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTR_ID_WIDTH
    `undef INTR_TNIU_INTR_ID_WIDTH
`endif
`ifdef peri_ss_tniu_INTR_TNIU_RAW_BASE_ADDR
    `undef INTR_TNIU_RAW_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_MERGE_MASK_BASE_ADDR
    `undef INTR_TNIU_MERGE_MASK_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_PULSE_MODE_BASE_ADDR
    `undef INTR_TNIU_PULSE_MODE_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_SET_BASE_ADDR
    `undef INTR_TNIU_SET_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_CLR_BASE_ADDR
    `undef INTR_TNIU_CLR_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_BASE_ADDR
    `undef INTR_TNIU_INTERNAL_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_CONFLICT_BASE_ADDR
    `undef INTR_TNIU_CONFLICT_BASE_ADDR
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_INTR_NUM
    `undef INTR_TNIU_INTERNAL_INTR_NUM
`endif
`ifdef peri_ss_tniu_INTR_TNIU_EVENT_COUNT_MAX
    `undef INTR_TNIU_EVENT_COUNT_MAX
`endif
`ifdef peri_ss_tniu_INTR_TNIU_CONTEXT_NUM
    `undef INTR_TNIU_CONTEXT_NUM
`endif
`ifdef peri_ss_tniu_INTR_TNIU_EVENT_REQ
    `undef INTR_TNIU_EVENT_REQ
`endif
`ifdef peri_ss_tniu_INTR_TNIU_APB_REQ
    `undef INTR_TNIU_APB_REQ
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_OVERFLOW_ERROR_ID
    `undef INTR_TNIU_INTERNAL_OVERFLOW_ERROR_ID
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_ECC_ERROR_ID
    `undef INTR_TNIU_INTERNAL_ECC_ERROR_ID
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_CONFLICT_ERROR_ID
    `undef INTR_TNIU_INTERNAL_CONFLICT_ERROR_ID
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_TGT_ID_ERROR_ID
    `undef INTR_TNIU_INTERNAL_TGT_ID_ERROR_ID
`endif
`ifdef peri_ss_tniu_INTR_TNIU_INTERNAL_TGT_INTR_ID_ERROR_ID
    `undef INTR_TNIU_INTERNAL_TGT_INTR_ID_ERROR_ID
`endif

// Clean up _PREFIX_ macro to prevent leakage into other components
`ifdef peri_ss_tniu__PREFIX_
    `undef _PREFIX_
`endif

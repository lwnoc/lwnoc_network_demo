`ifndef camera_ss_tniu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

// ---------------------------------------------------------------------------
// Interrupt TNIU configurable parameters
// Override before including this file to customize the instance.
// ---------------------------------------------------------------------------
`ifndef camera_ss_tniu_INTR_TNIU_OVERFLOW_TGT_ID
    `define camera_ss_tniu_INTR_TNIU_OVERFLOW_TGT_ID                  0
`endif
`ifndef camera_ss_tniu_INTR_TNIU_OVERFLOW_TGT_INTR_ID
    `define camera_ss_tniu_INTR_TNIU_OVERFLOW_TGT_INTR_ID             0
`endif
`ifndef camera_ss_tniu_INTR_TNIU_TIMER_COUNT
    `define camera_ss_tniu_INTR_TNIU_TIMER_COUNT                      10
`endif
`ifndef camera_ss_tniu_INTR_TNIU_NIU_ID_WIDTH
    `define camera_ss_tniu_INTR_TNIU_NIU_ID_WIDTH                     8
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTR_ID_WIDTH
    `define camera_ss_tniu_INTR_TNIU_INTR_ID_WIDTH                    12
`endif
`ifndef camera_ss_tniu_INTR_TNIU_RAW_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_RAW_BASE_ADDR                    32'h0
`endif
`ifndef camera_ss_tniu_INTR_TNIU_MERGE_MASK_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_MERGE_MASK_BASE_ADDR             32'h200
`endif
`ifndef camera_ss_tniu_INTR_TNIU_PULSE_MODE_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_PULSE_MODE_BASE_ADDR             32'h600
`endif
`ifndef camera_ss_tniu_INTR_TNIU_SET_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_SET_BASE_ADDR                    32'h1000
`endif
`ifndef camera_ss_tniu_INTR_TNIU_CLR_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_CLR_BASE_ADDR                    32'h1200
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_BASE_ADDR               32'h1400
`endif
`ifndef camera_ss_tniu_INTR_TNIU_CONFLICT_BASE_ADDR
    `define camera_ss_tniu_INTR_TNIU_CONFLICT_BASE_ADDR               32'h4000
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_INTR_NUM
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_INTR_NUM                32
`endif
`ifndef camera_ss_tniu_INTR_TNIU_EVENT_COUNT_MAX
    `define camera_ss_tniu_INTR_TNIU_EVENT_COUNT_MAX                  16
`endif
`ifndef camera_ss_tniu_INTR_TNIU_CONTEXT_NUM
    `define camera_ss_tniu_INTR_TNIU_CONTEXT_NUM                      16
`endif
`ifndef camera_ss_tniu_INTR_TNIU_EVENT_REQ
    `define camera_ss_tniu_INTR_TNIU_EVENT_REQ                        0
`endif
`ifndef camera_ss_tniu_INTR_TNIU_APB_REQ
    `define camera_ss_tniu_INTR_TNIU_APB_REQ                          1
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_OVERFLOW_ERROR_ID
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_OVERFLOW_ERROR_ID       0
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_ECC_ERROR_ID
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_ECC_ERROR_ID            1
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_CONFLICT_ERROR_ID
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_CONFLICT_ERROR_ID       2
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_TGT_ID_ERROR_ID
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_TGT_ID_ERROR_ID         3
`endif
`ifndef camera_ss_tniu_INTR_TNIU_INTERNAL_TGT_INTR_ID_ERROR_ID
    `define camera_ss_tniu_INTR_TNIU_INTERNAL_TGT_INTR_ID_ERROR_ID    4
`endif

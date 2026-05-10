`ifndef dsp__PREFIX_
    `define _PREFIX_(x)  NPU_``x
`endif

`ifndef dsp_ATB_INIU_FIFO_DEPTH
    `define dsp_ATB_INIU_FIFO_DEPTH 16
`endif

`ifndef dsp_ATB_INIU_AUTO_CLEAR_EN
    `define dsp_ATB_INIU_AUTO_CLEAR_EN 0
`endif

`ifndef dsp_ATB_INIU_SYNC_STAGE
    `define dsp_ATB_INIU_SYNC_STAGE 2
`endif

`ifndef dsp_ATB_INIU_SYNC_BUF_DEPTH
    `define dsp_ATB_INIU_SYNC_BUF_DEPTH 2
`endif

`ifndef dsp_ATB_INIU_ERR_INT_CNT_WIDTH
    `define dsp_ATB_INIU_ERR_INT_CNT_WIDTH 16
`endif

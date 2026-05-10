`ifdef gpu1_noc_ATB_INIU_FIFO_DEPTH
    `undef ATB_INIU_FIFO_DEPTH
`endif

`ifdef gpu1_noc_ATB_INIU_AUTO_CLEAR_EN
    `undef ATB_INIU_AUTO_CLEAR_EN
`endif

`ifdef gpu1_noc_ATB_INIU_SYNC_STAGE
    `undef ATB_INIU_SYNC_STAGE
`endif

`ifdef gpu1_noc_ATB_INIU_SYNC_BUF_DEPTH
    `undef ATB_INIU_SYNC_BUF_DEPTH
`endif

`ifdef gpu1_noc_ATB_INIU_ERR_INT_CNT_WIDTH
    `undef ATB_INIU_ERR_INT_CNT_WIDTH
`endif

`ifdef gpu1_noc__PREFIX_
    `undef _PREFIX_
`endif

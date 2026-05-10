`ifdef peri_ATB_TNIU_FIFO_DEPTH
    `undef ATB_TNIU_FIFO_DEPTH
`endif

`ifdef peri_ATB_TNIU_AUTO_CLEAR_EN
    `undef ATB_TNIU_AUTO_CLEAR_EN
`endif

`ifdef peri_ATB_TNIU_SYNC_STAGE
    `undef ATB_TNIU_SYNC_STAGE
`endif

`ifdef peri_ATB_TNIU_ERR_INT_CNT_WIDTH
    `undef ATB_TNIU_ERR_INT_CNT_WIDTH
`endif

`ifdef peri__PREFIX_
    `undef _PREFIX_
`endif

`ifndef _PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef STS_SRC_ID_WIDTH
    `define STS_SRC_ID_WIDTH 8
`endif
`ifndef STS_TGT_ID_WIDTH
    `define STS_TGT_ID_WIDTH 8
`endif
`ifndef STS_TXN_ID_WIDTH
    `define STS_TXN_ID_WIDTH 8
`endif

`ifndef STS_CTI_EVENT_WIDTH
    `define STS_CTI_EVENT_WIDTH 8
`endif
`ifndef STS_CTI_CHANNEL_WIDTH
    `define STS_CTI_CHANNEL_WIDTH 8
`endif

`ifndef STS_INIU_REQ_FIFO_DEPTH
    `define STS_INIU_REQ_FIFO_DEPTH 16
`endif
`ifndef STS_INIU_RSP_FIFO_DEPTH
    `define STS_INIU_RSP_FIFO_DEPTH 16
`endif
`ifndef STS_TNIU_REQ_FIFO_DEPTH
    `define STS_TNIU_REQ_FIFO_DEPTH 16
`endif
`ifndef STS_TNIU_RSP_FIFO_DEPTH
    `define STS_TNIU_RSP_FIFO_DEPTH 16
`endif

`ifndef STS_INIU_SINGLE_OT
    `define STS_INIU_SINGLE_OT 8
`endif
`ifndef STS_INIU_NUM
    `define STS_INIU_NUM 16
`endif
`ifndef STS_INIU_OT_TOTAL
    `define STS_INIU_OT_TOTAL (`STS_INIU_SINGLE_OT*`STS_INIU_NUM)
`endif

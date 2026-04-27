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

`ifndef STS_AXI_AWID_WIDTH
    `define STS_AXI_AWID_WIDTH 8
`endif
`ifndef STS_AXI_BID_WIDTH
    `define STS_AXI_BID_WIDTH `STS_AXI_AWID_WIDTH
`endif
`ifndef STS_AXI_ARID_WIDTH
    `define STS_AXI_ARID_WIDTH 8
`endif
`ifndef STS_AXI_RID_WIDTH
    `define STS_AXI_RID_WIDTH `STS_AXI_ARID_WIDTH
`endif
`ifndef STS_AXI_ADDR_WIDTH
    `define STS_AXI_ADDR_WIDTH 32
`endif
`ifndef STS_AXI_USER_WIDTH
    `define STS_AXI_USER_WIDTH 8
`endif
`ifndef STS_AXI_DATA_WIDTH
    `define STS_AXI_DATA_WIDTH 32
`endif
`ifndef STS_AXI_STRB_WIDTH
    `define STS_AXI_STRB_WIDTH (`STS_AXI_DATA_WIDTH/8)
`endif
`ifndef STS_AXI_SIZE_WIDTH
    `define STS_AXI_SIZE_WIDTH $clog2(`STS_AXI_DATA_WIDTH/8)
`endif
`ifndef STS_AXI_AWLEN_WIDTH
    `define STS_AXI_AWLEN_WIDTH 8
`endif
`ifndef STS_AXI_ARLEN_WIDTH
    `define STS_AXI_ARLEN_WIDTH 8
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

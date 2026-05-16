`ifndef sts_noc_aon_ss_iniu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef sts_noc_aon_ss_iniu_STS_SRC_ID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_SRC_ID_WIDTH 9
`endif
`ifndef sts_noc_aon_ss_iniu_STS_TGT_ID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_TGT_ID_WIDTH 9
`endif
`ifndef sts_noc_aon_ss_iniu_STS_TXN_ID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_TXN_ID_WIDTH 8
`endif

`ifndef sts_noc_aon_ss_iniu_STS_AXI_AWID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_AWID_WIDTH 8
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_BID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_BID_WIDTH `sts_noc_aon_ss_iniu_STS_AXI_AWID_WIDTH
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_ARID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_ARID_WIDTH 8
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_RID_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_RID_WIDTH `sts_noc_aon_ss_iniu_STS_AXI_ARID_WIDTH
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_ADDR_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_ADDR_WIDTH 32
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_USER_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_USER_WIDTH 8
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_DATA_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_DATA_WIDTH 32
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_STRB_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_STRB_WIDTH (`sts_noc_aon_ss_iniu_STS_AXI_DATA_WIDTH/8)
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_SIZE_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_SIZE_WIDTH $clog2(`sts_noc_aon_ss_iniu_STS_AXI_DATA_WIDTH/8)
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_AWLEN_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_AWLEN_WIDTH 8
`endif
`ifndef sts_noc_aon_ss_iniu_STS_AXI_ARLEN_WIDTH
    `define sts_noc_aon_ss_iniu_STS_AXI_ARLEN_WIDTH 8
`endif

`ifndef sts_noc_aon_ss_iniu_STS_CTI_EVENT_WIDTH
    `define sts_noc_aon_ss_iniu_STS_CTI_EVENT_WIDTH 8
`endif
`ifndef sts_noc_aon_ss_iniu_STS_CTI_CHANNEL_WIDTH
    `define sts_noc_aon_ss_iniu_STS_CTI_CHANNEL_WIDTH 8
`endif

`ifndef sts_noc_aon_ss_iniu_STS_CTM_TRIG_WIDTH
    `define sts_noc_aon_ss_iniu_STS_CTM_TRIG_WIDTH 32
`endif

`ifndef sts_noc_aon_ss_iniu_STS_INIU_REQ_FIFO_DEPTH
    `define sts_noc_aon_ss_iniu_STS_INIU_REQ_FIFO_DEPTH 4
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_RSP_FIFO_DEPTH
    `define sts_noc_aon_ss_iniu_STS_INIU_RSP_FIFO_DEPTH 4
`endif
`ifndef sts_noc_aon_ss_iniu_STS_TNIU_REQ_FIFO_DEPTH
    `define sts_noc_aon_ss_iniu_STS_TNIU_REQ_FIFO_DEPTH 16
`endif
`ifndef sts_noc_aon_ss_iniu_STS_TNIU_RSP_FIFO_DEPTH
    `define sts_noc_aon_ss_iniu_STS_TNIU_RSP_FIFO_DEPTH 16
`endif

`ifndef sts_noc_aon_ss_iniu_STS_INIU_SINGLE_OT
    `define sts_noc_aon_ss_iniu_STS_INIU_SINGLE_OT 8
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_NUM
    `define sts_noc_aon_ss_iniu_STS_INIU_NUM 16
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_OT_TOTAL
    `define sts_noc_aon_ss_iniu_STS_INIU_OT_TOTAL (`sts_noc_aon_ss_iniu_STS_INIU_SINGLE_OT*`sts_noc_aon_ss_iniu_STS_INIU_NUM)
`endif

`ifndef sts_noc_aon_ss_iniu_STS_INIU_DBG_TIMESTAMP_WIDTH
    `define sts_noc_aon_ss_iniu_STS_INIU_DBG_TIMESTAMP_WIDTH 64
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_DBG_DATA_WIDTH
    `define sts_noc_aon_ss_iniu_STS_INIU_DBG_DATA_WIDTH 32
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_FIFO_DEPTH
    `define sts_noc_aon_ss_iniu_STS_INIU_FIFO_DEPTH 4
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_SYNC_STAGE
    `define sts_noc_aon_ss_iniu_STS_INIU_SYNC_STAGE 2
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_NODE_NUM
    `define sts_noc_aon_ss_iniu_STS_INIU_NODE_NUM 2
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_SAFETY_TIMEOUT_CYCLES
    `define sts_noc_aon_ss_iniu_STS_INIU_SAFETY_TIMEOUT_CYCLES 1024
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_ENTRY_NUM
    `define sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_ENTRY_NUM 1
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_START_TABLE
    `define sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_START_TABLE '0
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_END_TABLE
    `define sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_END_TABLE '0
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_TGT_ID_TABLE
    `define sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_TGT_ID_TABLE '0
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_DEFAULT_TGT_ID
    `define sts_noc_aon_ss_iniu_STS_INIU_ADDR_MAP_DEFAULT_TGT_ID '0
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ERR_INT_CNT_WIDTH
    `define sts_noc_aon_ss_iniu_STS_INIU_ERR_INT_CNT_WIDTH 16
`endif
`ifndef sts_noc_aon_ss_iniu_STS_INIU_ADDR_MASK_BITS
    `define sts_noc_aon_ss_iniu_STS_INIU_ADDR_MASK_BITS 1
`endif

`ifndef sts_noc_aon_ss_iniu_STS_RESERVE_WIDTH
    `define sts_noc_aon_ss_iniu_STS_RESERVE_WIDTH 8
`endif

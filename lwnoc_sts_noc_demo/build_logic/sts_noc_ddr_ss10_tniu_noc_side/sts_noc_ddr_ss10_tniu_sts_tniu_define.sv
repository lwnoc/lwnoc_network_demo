`ifndef sts_noc_ddr_ss10_tniu__PREFIX_
    `define _PREFIX_(x)  Base_``x
`endif

`ifndef sts_noc_ddr_ss10_tniu_STS_SRC_ID_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_SRC_ID_WIDTH 9
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TGT_ID_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TGT_ID_WIDTH 9
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TXN_ID_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TXN_ID_WIDTH 8
`endif

`ifndef sts_noc_ddr_ss10_tniu_STS_CTI_EVENT_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_CTI_EVENT_WIDTH 8
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_CTI_CHANNEL_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_CTI_CHANNEL_WIDTH 8
`endif

`ifndef sts_noc_ddr_ss10_tniu_STS_CTM_TRIG_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_CTM_TRIG_WIDTH 32
`endif

`ifndef sts_noc_ddr_ss10_tniu_STS_INIU_REQ_FIFO_DEPTH
    `define sts_noc_ddr_ss10_tniu_STS_INIU_REQ_FIFO_DEPTH 16
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_INIU_RSP_FIFO_DEPTH
    `define sts_noc_ddr_ss10_tniu_STS_INIU_RSP_FIFO_DEPTH 16
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_REQ_FIFO_DEPTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_REQ_FIFO_DEPTH 16
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_RSP_FIFO_DEPTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_RSP_FIFO_DEPTH 16
`endif

`ifndef sts_noc_ddr_ss10_tniu_STS_INIU_SINGLE_OT
    `define sts_noc_ddr_ss10_tniu_STS_INIU_SINGLE_OT 8
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_INIU_NUM
    `define sts_noc_ddr_ss10_tniu_STS_INIU_NUM 16
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_INIU_OT_TOTAL
    `define sts_noc_ddr_ss10_tniu_STS_INIU_OT_TOTAL (`sts_noc_ddr_ss10_tniu_STS_INIU_SINGLE_OT*`sts_noc_ddr_ss10_tniu_STS_INIU_NUM)
`endif

`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_DBG_TIMESTAMP_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_DBG_TIMESTAMP_WIDTH 64
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_DBG_DATA_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_DBG_DATA_WIDTH 32
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_APB_ADDR_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_APB_ADDR_WIDTH 32
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_SYNC_STAGE
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_SYNC_STAGE 2
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_ASYNC_FIFO_DEPTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_ASYNC_FIFO_DEPTH 4
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_FIFO_DEPTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_FIFO_DEPTH 16
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_TGT_TYPE_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_TGT_TYPE_WIDTH 2
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_APB_TGT_TYPE
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_APB_TGT_TYPE 2'b01
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_INIU_CTI_TGT_ID
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_INIU_CTI_TGT_ID '0
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_INIU_CTI_TGT_MASK
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_INIU_CTI_TGT_MASK '1
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_REGBANK_TGT_ID
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_REGBANK_TGT_ID 'd1
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_REGBANK_TGT_MASK
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_REGBANK_TGT_MASK '1
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_CTI_TGT_ID
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_CTI_TGT_ID 'd2
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_CTI_TGT_MASK
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_LOCAL_CTI_TGT_MASK '1
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_HAS_INIU_CTI_APB
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_HAS_INIU_CTI_APB 0
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_REG_ROUTE_BASE
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_REG_ROUTE_BASE 9'h040
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_REG_ROUTE_MASK
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_REG_ROUTE_MASK 9'h1C0
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_APB_ROUTE_BASE
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_APB_ROUTE_BASE 9'h000
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_APB_ROUTE_MASK
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_SYS_APB_ROUTE_MASK 9'h1C0
`endif
`ifndef sts_noc_ddr_ss10_tniu_STS_TNIU_ERR_INT_CNT_WIDTH
    `define sts_noc_ddr_ss10_tniu_STS_TNIU_ERR_INT_CNT_WIDTH 16
`endif

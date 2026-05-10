`ifndef _PREFIX_
    `define _PREFIX_(x)  NPU_``x
`endif

`ifndef ATB_NETWORK_FIFO_DEPTH
    `define ATB_NETWORK_FIFO_DEPTH 16
`endif

`ifndef ATB_NETWORK_SYNC_STAGE
    `define ATB_NETWORK_SYNC_STAGE 2
`endif

`ifndef ATB_NETWORK_ERR_INT_CNT_WIDTH
    `define ATB_NETWORK_ERR_INT_CNT_WIDTH 16
`endif

`ifndef ATB_FUNNEL_N_ATB
    `define ATB_FUNNEL_N_ATB 2
`endif

`ifndef ATB_FUNNEL_HOLD_WIDTH
    `define ATB_FUNNEL_HOLD_WIDTH 4
`endif

`ifndef ATB_FUNNEL_DATA0_WIDTH
    `define ATB_FUNNEL_DATA0_WIDTH 9
`endif

`ifndef ATB_FUNNEL_FIXED_CONFIGURATION
    `define ATB_FUNNEL_FIXED_CONFIGURATION 1'b0
`endif

`ifndef ATB_FUNNEL_FIXED_HOLD_TIME
    `define ATB_FUNNEL_FIXED_HOLD_TIME 4'b0011
`endif

`ifndef ATB_AFIFO_WID
    `define ATB_AFIFO_WID 128
`endif

`ifndef ATB_ID_WIDTH
    `define ATB_ID_WIDTH 7
`endif

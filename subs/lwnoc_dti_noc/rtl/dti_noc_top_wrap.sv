// DTI NoC Top Wrapper — 1 iniu_sys / 1 iniu_noc / 1 tniu_sys / 1 tniu_noc
// Clock domains:
//   clk_sys : iniu_sys + tniu_sys (system/TBU/TCU clock)
//   clk_noc : iniu_noc + tniu_noc (NOC fabric clock)
// Data flow:
//   TBU → iniu_sys --(clk_sys)--[REQ AFIFO]--(clk_noc)--> iniu_noc → NOC ring
//   NOC ring → iniu_noc --(clk_noc)--[RSP AFIFO]--(clk_sys)--> iniu_sys → TBU
//   NOC ring → tniu_noc --(clk_noc)--[REQ AFIFO]--(clk_sys)--> tniu_sys → TCU
//   TCU → tniu_sys --(clk_sys)--[RSP AFIFO]--(clk_noc)--> tniu_noc → NOC ring

module `_PREFIX_(dti_noc_top_wrap)
    import lwnoc_lp_define_package::*;
    import lwnoc_lp_struct_package::*;
    import `_PREFIX_(dti_iniu_pack)::*;
#(
    parameter integer unsigned TBU_NUM             = `TBU_NUM,
    parameter integer unsigned TRANSACTION_MAX_NUM = `TRANSACTION_MAX_NUM,
    parameter integer unsigned INIU_FIFO_DEPTH     = 16,
    parameter integer unsigned TNIU_FIFO_DEPTH     = 10,
    parameter integer unsigned TIME_OUT_WIDTH      = 10,
    localparam int             PLD_WIDTH           = 90+6+6+1+1
)(
    // -----------------------------------------------------------------
    // Clocks and resets
    // -----------------------------------------------------------------
    input  logic                                        clk_sys             ,
    input  logic                                        rstn_sys            ,
    input  logic                                        clk_noc             ,
    input  logic                                        rstn_noc            ,

    // -----------------------------------------------------------------
    // INIU system side — TBU interface
    // req: TBU→INIU (AXI-stream slave); rsp: INIU→TBU (AXI-stream master)
    // -----------------------------------------------------------------
    input  logic                                        s_req_tvalid        ,
    input  logic [AXIS_DATA_WIDTH-1:0]                  s_req_tdata         ,
    input  logic [AXIS_KEEP_WIDTH-1:0]                  s_req_tkeep         ,
    input  logic                                        s_req_tlast         ,
    input  logic [TBU_NUM_WIDTH-1:0]                    s_req_ttid          ,
    output logic                                        s_req_tready        ,

    output logic                                        s_rsp_tvalid        ,
    output logic [CUSTOM_DATA_WIDTH-1:0]                s_rsp_tdata         ,
    output logic [CUSTOM_KEEP_WIDTH-1:0]                s_rsp_tkeep         ,
    output logic                                        s_rsp_tlast         ,
    output logic [TBU_NUM_WIDTH-1:0]                    s_rsp_ttid          ,
    input  logic                                        s_rsp_tready        ,

    input  logic                                        s_req_twakeup       ,
    output logic                                        s_rsp_twakeup       ,

    // -----------------------------------------------------------------
    // TNIU system side — TCU interface
    // req: TNIU→TCU (AXI-stream master); rsp: TCU→TNIU (AXI-stream slave)
    // -----------------------------------------------------------------
    output logic                                        m_req_tvalid        ,
    output logic [AXIS_DATA_WIDTH-1:0]                  m_req_tdata         ,
    output logic [AXIS_KEEP_WIDTH-1:0]                  m_req_tkeep         ,
    output logic                                        m_req_tlast         ,
    output logic [TBU_NUM_WIDTH-1:0]                    m_req_ttid          ,
    input  logic                                        m_req_tready        ,

    input  logic                                        m_rsp_tvalid        ,
    input  logic [CUSTOM_DATA_WIDTH-1:0]                m_rsp_tdata         ,
    input  logic [CUSTOM_KEEP_WIDTH-1:0]                m_rsp_tkeep         ,
    output logic                                        m_rsp_tready        ,
    input  logic                                        m_rsp_tlast         ,
    input  logic [TBU_NUM_WIDTH-1:0]                    m_rsp_ttid          ,

    output logic                                        m_req_twakeup       ,
    input  logic                                        m_rsp_twakeup       ,

    // -----------------------------------------------------------------
    // NOC ring side — iniu_noc output (INIU→NOC req, NOC→INIU rsp)
    // -----------------------------------------------------------------
    // REQ path: iniu_noc → NOC ring
    output logic                                        noc_iniu_req_valid  ,
    output logic [CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH-1:0] noc_iniu_req_payload,
    output logic                                        noc_iniu_req_last   ,
    output logic [TBU_NUM_WIDTH-1:0]                    noc_iniu_req_srcid  ,
    output logic [TBU_NUM_WIDTH-1:0]                    noc_iniu_req_tgtid  ,
    output logic                                        noc_iniu_req_qos    ,
    input  logic                                        noc_iniu_req_threshold,
    input  logic                                        noc_iniu_req_ready  ,

    // RSP path: NOC ring → iniu_noc (response back to TBU)
    input  logic                                        noc_iniu_rsp_valid  ,
    input  logic [CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH-1:0] noc_iniu_rsp_payload,
    input  logic                                        noc_iniu_rsp_last   ,
    input  logic [TBU_NUM_WIDTH-1:0]                    noc_iniu_rsp_srcid  ,
    input  logic [TBU_NUM_WIDTH-1:0]                    noc_iniu_rsp_tgtid  ,
    input  logic                                        noc_iniu_rsp_qos    ,
    output logic                                        noc_iniu_rsp_threshold,
    output logic                                        noc_iniu_rsp_ready  ,

    // -----------------------------------------------------------------
    // NOC ring side — tniu_noc (NOC→TNIU req, TNIU→NOC rsp)
    // -----------------------------------------------------------------
    // REQ path: NOC ring → tniu_noc
    input  logic                                        noc_tniu_req_valid  ,
    input  logic [CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH-1:0] noc_tniu_req_payload,
    input  logic                                        noc_tniu_req_last   ,
    input  logic [TBU_NUM_WIDTH-1:0]                    noc_tniu_req_srcid  ,
    input  logic [TBU_NUM_WIDTH-1:0]                    noc_tniu_req_tgtid  ,
    input  logic                                        noc_tniu_req_qos    ,
    output logic                                        noc_tniu_req_threshold,
    output logic                                        noc_tniu_req_ready  ,

    // RSP path: tniu_noc → NOC ring
    output logic                                        noc_tniu_rsp_valid  ,
    output logic [CUSTOM_DATA_WIDTH+CUSTOM_KEEP_WIDTH-1:0] noc_tniu_rsp_payload,
    output logic                                        noc_tniu_rsp_last   ,
    output logic [TBU_NUM_WIDTH-1:0]                    noc_tniu_rsp_srcid  ,
    output logic [TBU_NUM_WIDTH-1:0]                    noc_tniu_rsp_tgtid  ,
    output logic                                        noc_tniu_rsp_qos    ,
    input  logic                                        noc_tniu_rsp_threshold,
    input  logic                                        noc_tniu_rsp_ready  ,

    // -----------------------------------------------------------------
    // Low-power — pchannel (iniu_sys and tniu_sys each have one)
    // -----------------------------------------------------------------
    input  logic                                        iniu_preq           ,
    input  lwnoc_pchannel_state_t                       iniu_pstate         ,
    output lwnoc_pchannel_active_t                      iniu_pactive        ,
    output logic                                        iniu_paccept        ,
    output logic                                        iniu_pdeny          ,

    input  logic                                        tniu_preq           ,
    input  lwnoc_pchannel_state_t                       tniu_pstate         ,
    output lwnoc_pchannel_active_t                      tniu_pactive        ,
    output logic                                        tniu_paccept        ,
    output logic                                        tniu_pdeny          ,

    // LP hub channels (one per async module)
    input  lwnoc_lp_req_signal_t                        lp_iniu_sys_rx_req  ,
    output lwnoc_lp_req_signal_t                        lp_iniu_sys_tx_req  ,
    input  lwnoc_lp_req_signal_t                        lp_iniu_noc_rx_req  ,
    output lwnoc_lp_req_signal_t                        lp_iniu_noc_tx_req  ,
    input  lwnoc_lp_req_signal_t                        lp_tniu_noc_rx_req  ,
    output lwnoc_lp_req_signal_t                        lp_tniu_noc_tx_req  ,
    input  lwnoc_lp_req_signal_t                        lp_tniu_sys_rx_req  ,
    output lwnoc_lp_req_signal_t                        lp_tniu_sys_tx_req  ,

    input  logic [TIME_OUT_WIDTH-1:0]                   timeout_val
);

    // -----------------------------------------------------------------
    // Internal — INIU REQ AFIFO (iniu_sys write → iniu_noc read)
    // -----------------------------------------------------------------
    logic [INIU_FIFO_DEPTH-1:0]  iniu_req_wptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]  iniu_req_rptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]  iniu_req_rptr_sync  ;
    logic [PLD_WIDTH:0]          iniu_req_pld_sync   ;

    // -----------------------------------------------------------------
    // Internal — INIU RSP AFIFO (iniu_noc write → iniu_sys read)
    // -----------------------------------------------------------------
    logic [INIU_FIFO_DEPTH-1:0]  iniu_rsp_wptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]  iniu_rsp_rptr_async ;
    logic [INIU_FIFO_DEPTH-1:0]  iniu_rsp_rptr_sync  ;
    logic [PLD_WIDTH:0]          iniu_rsp_pld_sync   ;

    // -----------------------------------------------------------------
    // Internal — TNIU REQ AFIFO (tniu_noc write → tniu_sys read)
    // -----------------------------------------------------------------
    logic [TNIU_FIFO_DEPTH-1:0]  tniu_req_wptr_async ;
    logic [TNIU_FIFO_DEPTH-1:0]  tniu_req_rptr_async ;
    logic [TNIU_FIFO_DEPTH-1:0]  tniu_req_rptr_sync  ;
    logic [PLD_WIDTH:0]          tniu_req_pld_sync   ;

    // -----------------------------------------------------------------
    // Internal — TNIU RSP AFIFO (tniu_sys write → tniu_noc read)
    // -----------------------------------------------------------------
    logic [TNIU_FIFO_DEPTH-1:0]  tniu_rsp_wptr_async ;
    logic [TNIU_FIFO_DEPTH-1:0]  tniu_rsp_rptr_async ;
    logic [TNIU_FIFO_DEPTH-1:0]  tniu_rsp_rptr_sync  ;
    logic [PLD_WIDTH:0]          tniu_rsp_pld_sync   ;

    // -----------------------------------------------------------------
    // u_iniu_sys : TBU → INIU (REQ AFIFO write, RSP AFIFO read)
    // -----------------------------------------------------------------
    `_PREFIX_(dti_pr_iniu_async_sys_side) #(
        .TBU_NUM            (TBU_NUM            ),
        .TRANSACTION_MAX_NUM(TRANSACTION_MAX_NUM ),
        .ASYNC_FIFO_DEPTH   (INIU_FIFO_DEPTH    ),
        .TIME_OUT_WIDTH     (TIME_OUT_WIDTH      )
    ) u_iniu_sys (
        .clk                (clk_sys            ),
        .rst_n              (rstn_sys           ),
        // TBU req interface
        .req_tvalid         (s_req_tvalid       ),
        .req_tdata          (s_req_tdata        ),
        .req_tkeep          (s_req_tkeep        ),
        .req_tlast          (s_req_tlast        ),
        .req_ttid           (s_req_ttid         ),
        .req_tready         (s_req_tready       ),
        // TBU rsp interface
        .rsp_tvalid         (s_rsp_tvalid       ),
        .rsp_tdata          (s_rsp_tdata        ),
        .rsp_tkeep          (s_rsp_tkeep        ),
        .rsp_tlast          (s_rsp_tlast        ),
        .rsp_ttid           (s_rsp_ttid         ),
        .rsp_tready         (s_rsp_tready       ),
        // Wakeup
        .req_twakeup        (s_req_twakeup      ),
        .rsp_twakeup        (s_rsp_twakeup      ),
        // REQ AFIFO write side (internal)
        .req_wptr_async     (iniu_req_wptr_async),
        .req_rptr_async     (iniu_req_rptr_async),
        .req_rptr_sync      (iniu_req_rptr_sync ),
        .req_pld_sync       (iniu_req_pld_sync  ),
        // RSP AFIFO read side (internal)
        .rsp_wptr_async     (iniu_rsp_wptr_async),
        .rsp_rptr_async     (iniu_rsp_rptr_async),
        .rsp_rptr_sync      (iniu_rsp_rptr_sync ),
        .rsp_pld_sync       (iniu_rsp_pld_sync  ),
        // Power
        .timeout_val        (timeout_val        ),
        .preq               (iniu_preq          ),
        .pstate             (iniu_pstate        ),
        .pactive            (iniu_pactive       ),
        .paccept            (iniu_paccept       ),
        .pdeny              (iniu_pdeny         ),
        .lp_hub_rx_req      (lp_iniu_sys_rx_req ),
        .lp_hub_tx_req      (lp_iniu_sys_tx_req )
    );

    // -----------------------------------------------------------------
    // u_iniu_noc : INIU (REQ AFIFO read, RSP AFIFO write) → NOC ring
    // -----------------------------------------------------------------
    `_PREFIX_(dti_pr_iniu_async_top_side) #(
        .ASYNC_FIFO_DEPTH   (INIU_FIFO_DEPTH    )
    ) u_iniu_noc (
        .clk                (clk_noc            ),
        .rst_n              (rstn_noc           ),
        // NOC ring RSP input (NOC → TBU rsp path)
        .rsp_valid          (noc_iniu_rsp_valid  ),
        .rsp_payload        (noc_iniu_rsp_payload),
        .rsp_last           (noc_iniu_rsp_last   ),
        .rsp_srcid          (noc_iniu_rsp_srcid  ),
        .rsp_tgtid          (noc_iniu_rsp_tgtid  ),
        .rsp_qos            (noc_iniu_rsp_qos    ),
        .rsp_threshold      (noc_iniu_rsp_threshold),
        .rsp_ready          (noc_iniu_rsp_ready  ),
        // NOC ring REQ output (TBU req → NOC)
        .req_valid          (noc_iniu_req_valid  ),
        .req_payload        (noc_iniu_req_payload),
        .req_last           (noc_iniu_req_last   ),
        .req_srcid          (noc_iniu_req_srcid  ),
        .req_tgtid          (noc_iniu_req_tgtid  ),
        .req_qos            (noc_iniu_req_qos    ),
        .req_threshold      (noc_iniu_req_threshold),
        .req_ready          (noc_iniu_req_ready  ),
        // REQ AFIFO read side (internal)
        .req_wptr_async     (iniu_req_wptr_async ),
        .req_rptr_async     (iniu_req_rptr_async ),
        .req_rptr_sync      (iniu_req_rptr_sync  ),
        .req_pld_sync       (iniu_req_pld_sync   ),
        // RSP AFIFO write side (internal)
        .rsp_wptr_async     (iniu_rsp_wptr_async ),
        .rsp_rptr_async     (iniu_rsp_rptr_async ),
        .rsp_rptr_sync      (iniu_rsp_rptr_sync  ),
        .rsp_pld_sync       (iniu_rsp_pld_sync   ),
        // LP hub
        .lp_hub_rx_req      (lp_iniu_noc_rx_req  ),
        .lp_hub_tx_req      (lp_iniu_noc_tx_req  )
    );

    // -----------------------------------------------------------------
    // u_tniu_noc : NOC ring → TNIU (REQ AFIFO write, RSP AFIFO read)
    // -----------------------------------------------------------------
    `_PREFIX_(dti_tniu_async_top_side) #(
        .ASYNC_FIFO_DEPTH   (TNIU_FIFO_DEPTH    )
    ) u_tniu_noc (
        .clk                (clk_noc            ),
        .rst_n              (rstn_noc           ),
        // NOC ring REQ input (NOC → TCU)
        .req_valid          (noc_tniu_req_valid  ),
        .req_payload        (noc_tniu_req_payload),
        .req_last           (noc_tniu_req_last   ),
        .req_srcid          (noc_tniu_req_srcid  ),
        .req_tgtid          (noc_tniu_req_tgtid  ),
        .req_qos            (noc_tniu_req_qos    ),
        .req_threshold      (noc_tniu_req_threshold),
        .req_ready          (noc_tniu_req_ready  ),
        // REQ AFIFO write side (internal)
        .req_wptr_async     (tniu_req_wptr_async ),
        .req_rptr_async     (tniu_req_rptr_async ),
        .req_rptr_sync      (tniu_req_rptr_sync  ),
        .req_pld_sync       (tniu_req_pld_sync   ),
        // NOC ring RSP output (TCU rsp → NOC)
        .rsp_valid          (noc_tniu_rsp_valid  ),
        .rsp_payload        (noc_tniu_rsp_payload),
        .rsp_last           (noc_tniu_rsp_last   ),
        .rsp_srcid          (noc_tniu_rsp_srcid  ),
        .rsp_tgtid          (noc_tniu_rsp_tgtid  ),
        .rsp_qos            (noc_tniu_rsp_qos    ),
        .rsp_threshold      (noc_tniu_rsp_threshold),
        .rsp_ready          (noc_tniu_rsp_ready  ),
        // RSP AFIFO read side (internal)
        .rsp_wptr_async     (tniu_rsp_wptr_async ),
        .rsp_rptr_async     (tniu_rsp_rptr_async ),
        .rsp_rptr_sync      (tniu_rsp_rptr_sync  ),
        .rsp_pld_sync       (tniu_rsp_pld_sync   ),
        // LP hub
        .lp_hub_rx_req      (lp_tniu_noc_rx_req  ),
        .lp_hub_tx_req      (lp_tniu_noc_tx_req  )
    );

    // -----------------------------------------------------------------
    // u_tniu_sys : TNIU (REQ AFIFO read, RSP AFIFO write) → TCU
    // -----------------------------------------------------------------
    `_PREFIX_(dti_tniu_async_sys_side) #(
        .ASYNC_FIFO_DEPTH   (TNIU_FIFO_DEPTH    ),
        .TIME_OUT_WIDTH     (TIME_OUT_WIDTH      )
    ) u_tniu_sys (
        .clk                (clk_sys            ),
        .rst_n              (rstn_sys           ),
        // TCU req interface
        .req_tvalid         (m_req_tvalid       ),
        .req_tdata          (m_req_tdata        ),
        .req_tkeep          (m_req_tkeep        ),
        .req_tlast          (m_req_tlast        ),
        .req_ttid           (m_req_ttid         ),
        .req_tready         (m_req_tready       ),
        // TCU rsp interface
        .rsp_tvalid         (m_rsp_tvalid       ),
        .rsp_tdata          (m_rsp_tdata        ),
        .rsp_tkeep          (m_rsp_tkeep        ),
        .rsp_tlast          (m_rsp_tlast        ),
        .rsp_ttid           (m_rsp_ttid         ),
        .rsp_tready         (m_rsp_tready       ),
        // Wakeup
        .req_twakeup        (m_req_twakeup      ),
        .rsp_twakeup        (m_rsp_twakeup      ),
        // REQ AFIFO read side (internal)
        .req_wptr_async     (tniu_req_wptr_async),
        .req_rptr_async     (tniu_req_rptr_async),
        .req_rptr_sync      (tniu_req_rptr_sync ),
        .req_pld_sync       (tniu_req_pld_sync  ),
        // RSP AFIFO write side (internal)
        .rsp_wptr_async     (tniu_rsp_wptr_async),
        .rsp_rptr_async     (tniu_rsp_rptr_async),
        .rsp_rptr_sync      (tniu_rsp_rptr_sync ),
        .rsp_pld_sync       (tniu_rsp_pld_sync  ),
        // Power
        .preq               (tniu_preq          ),
        .pstate             (tniu_pstate        ),
        .pactive            (tniu_pactive       ),
        .paccept            (tniu_paccept       ),
        .pdeny              (tniu_pdeny         ),
        .lp_hub_rx_req      (lp_tniu_sys_rx_req ),
        .lp_hub_tx_req      (lp_tniu_sys_tx_req )
    );

endmodule

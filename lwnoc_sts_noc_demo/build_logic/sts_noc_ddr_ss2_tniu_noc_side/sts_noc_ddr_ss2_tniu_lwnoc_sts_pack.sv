package sts_noc_ddr_ss2_tniu_lwnoc_sts_pack;

localparam integer unsigned SRC_ID_WIDTH  = `sts_noc_ddr_ss2_tniu_STS_SRC_ID_WIDTH;
localparam integer unsigned TGT_ID_WIDTH  = `sts_noc_ddr_ss2_tniu_STS_TGT_ID_WIDTH;
localparam integer unsigned TXN_ID_WIDTH  = `sts_noc_ddr_ss2_tniu_STS_TXN_ID_WIDTH;

localparam integer unsigned AXI_AWID_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_AWID_WIDTH;
localparam integer unsigned AXI_BID_WIDTH  = `sts_noc_ddr_ss2_tniu_STS_AXI_BID_WIDTH;
localparam integer unsigned AXI_ARID_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_ARID_WIDTH;
localparam integer unsigned AXI_RID_WIDTH  = `sts_noc_ddr_ss2_tniu_STS_AXI_RID_WIDTH;
localparam integer unsigned AXI_ADDR_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_ADDR_WIDTH;
localparam integer unsigned AXI_USER_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_USER_WIDTH;
localparam integer unsigned AXI_DATA_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_DATA_WIDTH;
localparam integer unsigned AXI_STRB_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_STRB_WIDTH;
localparam integer unsigned AXI_SIZE_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_SIZE_WIDTH;
localparam integer unsigned AXI_AWLEN_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_AWLEN_WIDTH;
localparam integer unsigned AXI_ARLEN_WIDTH = `sts_noc_ddr_ss2_tniu_STS_AXI_ARLEN_WIDTH;

localparam integer unsigned CTI_EVENT_WIDTH = `sts_noc_ddr_ss2_tniu_STS_CTI_EVENT_WIDTH;
localparam integer unsigned CTI_CHANNEL_WIDTH = `sts_noc_ddr_ss2_tniu_STS_CTI_CHANNEL_WIDTH;
localparam integer unsigned CTM_TRIG_WIDTH   = `sts_noc_ddr_ss2_tniu_STS_CTM_TRIG_WIDTH;
localparam integer unsigned CHANNEL_TOTAL_WIDTH = CTI_CHANNEL_WIDTH + CTM_TRIG_WIDTH;

localparam integer unsigned RESERVE_WIDTH = `sts_noc_ddr_ss2_tniu_STS_RESERVE_WIDTH;

localparam integer unsigned STS_INIU_REQ_FIFO_DEPTH = `sts_noc_ddr_ss2_tniu_STS_INIU_REQ_FIFO_DEPTH;
localparam integer unsigned STS_INIU_RSP_FIFO_DEPTH = `sts_noc_ddr_ss2_tniu_STS_INIU_RSP_FIFO_DEPTH;
localparam integer unsigned STS_TNIU_REQ_FIFO_DEPTH = `sts_noc_ddr_ss2_tniu_STS_TNIU_REQ_FIFO_DEPTH;
localparam integer unsigned STS_TNIU_RSP_FIFO_DEPTH = `sts_noc_ddr_ss2_tniu_STS_TNIU_RSP_FIFO_DEPTH;

localparam integer unsigned STS_INIU_SINGLE_OT = `sts_noc_ddr_ss2_tniu_STS_INIU_SINGLE_OT;
localparam integer unsigned STS_INIU_NUM = `sts_noc_ddr_ss2_tniu_STS_INIU_NUM;
localparam integer unsigned STS_INIU_OT_TOTAL = `sts_noc_ddr_ss2_tniu_STS_INIU_OT_TOTAL;

typedef enum logic [1:0] {
    cfgOpcode_RdReq = 2'b00,
    cfgOpcode_RdRsp = 2'b01,
    cfgOpcode_WrReq = 2'b10,
    cfgOpcode_WrRsp = 2'b11
} cfgOpcode;

typedef struct packed {
    logic   [SRC_ID_WIDTH-1:0]      src_id;
    logic   [TXN_ID_WIDTH-1:0]      txn_id;
    logic   [TGT_ID_WIDTH-1:0]      tgt_id;
    logic   [1:0]                   opcode;
    logic   [3:0]                   qos;
} sts_cmn_typ;

typedef struct packed {
    logic   [AXI_ADDR_WIDTH-1:0]   addr;
    logic   [1:0]                  burst;
    logic   [2:0]                  size;
    logic   [5:0]                  len;
    logic                          lock;
    logic   [AXI_USER_WIDTH-1:0]   user;
    logic   [AXI_DATA_WIDTH-1:0]   data;
    logic   [AXI_DATA_WIDTH/8-1:0] strb;
    logic                          last;
} sts_req_ext_typ;

typedef struct packed {
    logic   [1:0]                  resp;
    logic   [AXI_DATA_WIDTH-1:0]   data;
    logic                          last;
} sts_rsp_ext_typ;

typedef struct packed {
    logic [AXI_AWID_WIDTH-1:0]      awid;
    logic [AXI_ADDR_WIDTH-1:0]      awaddr;
    logic [AXI_AWLEN_WIDTH-1:0]     awlen;
    logic [AXI_SIZE_WIDTH-1:0]      awsize;
    logic                           awlock;
    logic [1:0]                     awburst;
    logic [3:0]                     awcache;
    logic [2:0]                     awprot;
    logic [3:0]                     awqos;
    logic [AXI_USER_WIDTH-1:0]      awuser;
} sts_iniu_axi_aw_chnl;

typedef struct packed {
    logic [AXI_DATA_WIDTH-1:0]  wdata;
    logic [AXI_STRB_WIDTH-1:0]  wstrb;
    logic                       wlast;
} sts_iniu_axi_w_chnl;

typedef struct packed {
    logic [AXI_BID_WIDTH-1:0]   bid;
    logic [1:0]                 bresp;
} sts_iniu_axi_b_chnl;

typedef struct packed {
    logic [AXI_ARID_WIDTH-1:0]      arid;
    logic [AXI_ADDR_WIDTH-1:0]      araddr;
    logic [AXI_ARLEN_WIDTH-1:0]     arlen;
    logic [AXI_SIZE_WIDTH-1:0]      arsize;
    logic                           arlock;
    logic [1:0]                     arburst;
    logic [3:0]                     arcache;
    logic [2:0]                     arprot;
    logic [3:0]                     arqos;
    logic [AXI_USER_WIDTH-1:0]      aruser;
} sts_iniu_axi_ar_chnl;

typedef struct packed {
    logic [AXI_RID_WIDTH-1:0]   rid;
    logic [AXI_DATA_WIDTH-1:0]  rdata;
    logic [1:0]                 rresp;
    logic                       rlast;
} sts_iniu_axi_r_chnl;

typedef struct packed {
    sts_cmn_typ     cmn;
    sts_req_ext_typ req;
} sts_req_typ;

typedef struct packed {
    sts_cmn_typ     cmn;
    sts_rsp_ext_typ rsp;
} sts_rsp_typ;

localparam int STS_CMN_WIDTH     = SRC_ID_WIDTH + TXN_ID_WIDTH + TGT_ID_WIDTH + 2 + 4;
localparam int STS_REQ_EXT_WIDTH = AXI_ADDR_WIDTH + 2 + 3 + 6 + 1
                                   + AXI_USER_WIDTH + AXI_DATA_WIDTH
                                   + AXI_DATA_WIDTH/8 + 1;
localparam int STS_RSP_EXT_WIDTH = 2 + AXI_DATA_WIDTH + 1;
localparam int STS_REQ_WIDTH     = STS_CMN_WIDTH + STS_REQ_EXT_WIDTH;
localparam int STS_RSP_WIDTH     = STS_CMN_WIDTH + STS_RSP_EXT_WIDTH;

// DEPRECATED: replaced by parameterized module sts_iniu_addr_map.
// Kept temporarily for reference; remove after full migration.
function automatic logic [TGT_ID_WIDTH-1:0] sts_iniu_sam(input logic [AXI_ADDR_WIDTH-1:0] in_addr);
    begin
        sts_iniu_sam = in_addr[AXI_ADDR_WIDTH-1 -: TGT_ID_WIDTH];
    end
endfunction

endpackage:sts_noc_ddr_ss2_tniu_lwnoc_sts_pack

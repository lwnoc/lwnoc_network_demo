import shutil
from pathlib import Path


WRAPPER_SHIM_DIR_NAME = "sts_top_wrapper_sources"
_LEGACY_WRAPPER_SHIM_DIR_NAMES = ("_source_wrappers",)


def wrapper_shim_dir(build_dir: Path) -> Path:
    return build_dir / WRAPPER_SHIM_DIR_NAME


def ensure_top_wrapper_shims(build_dir: Path, stale_publish_root: Path | None = None) -> None:
    shim_dir = wrapper_shim_dir(build_dir)
    for legacy_name in _LEGACY_WRAPPER_SHIM_DIR_NAMES:
        legacy_dir = build_dir / legacy_name
        if legacy_dir.exists() and legacy_dir != shim_dir:
            shutil.rmtree(legacy_dir)
            print(f"  [wrapper_shim] pruned legacy shim dir {legacy_dir}")

    if stale_publish_root is not None:
        stale_shim_dir = wrapper_shim_dir(stale_publish_root)
        if stale_shim_dir.exists() and stale_shim_dir != shim_dir:
            shutil.rmtree(stale_shim_dir)
            print(f"  [wrapper_shim] pruned stale publish shim dir {stale_shim_dir}")
        for legacy_name in _LEGACY_WRAPPER_SHIM_DIR_NAMES:
            legacy_dir = stale_publish_root / legacy_name
            if legacy_dir.exists():
                shutil.rmtree(legacy_dir)
                print(f"  [wrapper_shim] pruned legacy publish shim dir {legacy_dir}")

    shim_dir.mkdir(parents=True, exist_ok=True)

    rendered = {
        "sts_demo_iniu_wrap.sv": _render_iniu_wrapper(),
        "sts_demo_dec4_wrap.sv": _render_dec4_wrapper(),
    }
    for idx in range(4):
        wrapper_name = f"sts_demo_tniu{idx}_wrap"
        rendered[f"{wrapper_name}.sv"] = _render_tniu_wrapper(wrapper_name)

    updated = 0
    for name, content in rendered.items():
        target = shim_dir / name
        if target.exists() and target.read_text() == content:
            continue
        target.write_text(content)
        updated += 1

    print(f"  [wrapper_shim] refreshed {len(rendered)} source wrappers under {shim_dir} ({updated} updated)")


def _render_iniu_wrapper() -> str:
    return """module `_PREFIX_(sts_demo_iniu_wrap)
    import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter int unsigned STS_DEMO_NODE_NUM = 2,
    parameter int unsigned STS_DEMO_ADDR_MAP_ENTRY_NUM = 48,
    parameter logic [STS_DEMO_ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] STS_DEMO_ADDR_MAP_BASE_TABLE = '0,
    parameter logic [STS_DEMO_ADDR_MAP_ENTRY_NUM*AXI_ADDR_WIDTH-1:0] STS_DEMO_ADDR_MAP_MASK_TABLE = '0,
    parameter logic [STS_DEMO_ADDR_MAP_ENTRY_NUM*TGT_ID_WIDTH-1:0] STS_DEMO_ADDR_MAP_TGT_ID_TABLE = '0,
    parameter logic [TGT_ID_WIDTH-1:0] STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID = '1
)
(
    input   logic                       clk_src,
    input   logic                       clk_dst,
    input   logic                       rstn_src,
    input   logic                       rstn_dst,
    input   logic [SRC_ID_WIDTH-1:0]    node_id,

    input   logic                       s_awvalid,
    output  logic                       s_awready,
    input   logic [AXI_AWID_WIDTH-1:0]  s_awid,
    input   logic [AXI_ADDR_WIDTH-1:0]  s_awaddr,
    input   logic [AXI_AWLEN_WIDTH-1:0] s_awlen,
    input   logic [2:0]                 s_awsize,
    input   logic [1:0]                 s_awburst,
    input   logic                       s_awlock,
    input   logic [3:0]                 s_awcache,
    input   logic [2:0]                 s_awprot,
    input   logic [3:0]                 s_awqos,
    input   logic [AXI_USER_WIDTH-1:0]  s_awuser,

    input   logic                       s_wvalid,
    output  logic                       s_wready,
    input   logic [AXI_DATA_WIDTH-1:0]  s_wdata,
    input   logic [AXI_STRB_WIDTH-1:0]  s_wstrb,
    input   logic                       s_wlast,

    output  logic                       s_bvalid,
    input   logic                       s_bready,
    output  logic [AXI_BID_WIDTH-1:0]   s_bid,
    output  logic [1:0]                 s_bresp,

    input   logic                       s_arvalid,
    output  logic                       s_arready,
    input   logic [AXI_ARID_WIDTH-1:0]  s_arid,
    input   logic [AXI_ADDR_WIDTH-1:0]  s_araddr,
    input   logic [AXI_ARLEN_WIDTH-1:0] s_arlen,
    input   logic [2:0]                 s_arsize,
    input   logic [1:0]                 s_arburst,
    input   logic                       s_arlock,
    input   logic [3:0]                 s_arcache,
    input   logic [2:0]                 s_arprot,
    input   logic [3:0]                 s_arqos,
    input   logic [AXI_USER_WIDTH-1:0]  s_aruser,

    output  logic                       s_rvalid,
    input   logic                       s_rready,
    output  logic [AXI_RID_WIDTH-1:0]   s_rid,
    output  logic [AXI_DATA_WIDTH-1:0]  s_rdata,
    output  logic [1:0]                 s_rresp,
    output  logic                       s_rlast,

    output  logic                       out_req_vld,
    input   logic                       out_req_rdy,
    output  sts_req_typ                 out_req_pld,
    input   logic                       in_rsp_vld,
    output  logic                       in_rsp_rdy,
    input   sts_rsp_typ                 in_rsp_pld
);

    `_PREFIX_(sts_iniu_top) #(
        .NODE_NUM                (STS_DEMO_NODE_NUM),
        .ADDR_MAP_ENTRY_NUM      (STS_DEMO_ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_BASE_TABLE     (STS_DEMO_ADDR_MAP_BASE_TABLE),
        .ADDR_MAP_MASK_TABLE     (STS_DEMO_ADDR_MAP_MASK_TABLE),
        .ADDR_MAP_TGT_ID_TABLE   (STS_DEMO_ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_DEFAULT_TGT_ID (STS_DEMO_ADDR_MAP_DEFAULT_TGT_ID)
    ) u_sts_iniu_top (
        .clk_src             (clk_src),
        .clk_dst             (clk_dst),
        .rstn_src            (rstn_src),
        .rstn_dst            (rstn_dst),
        .node_id             (node_id),
        .sts_iniu_s_awvalid  (s_awvalid),
        .sts_iniu_s_awready  (s_awready),
        .sts_iniu_s_awid     (s_awid),
        .sts_iniu_s_awaddr   (s_awaddr),
        .sts_iniu_s_awlen    (s_awlen),
        .sts_iniu_s_awsize   (s_awsize),
        .sts_iniu_s_awburst  (s_awburst),
        .sts_iniu_s_awlock   (s_awlock),
        .sts_iniu_s_awcache  (s_awcache),
        .sts_iniu_s_awprot   (s_awprot),
        .sts_iniu_s_awqos    (s_awqos),
        .sts_iniu_s_awuser   (s_awuser),
        .sts_iniu_s_wvalid   (s_wvalid),
        .sts_iniu_s_wready   (s_wready),
        .sts_iniu_s_wdata    (s_wdata),
        .sts_iniu_s_wstrb    (s_wstrb),
        .sts_iniu_s_wlast    (s_wlast),
        .sts_iniu_s_bvalid   (s_bvalid),
        .sts_iniu_s_bready   (s_bready),
        .sts_iniu_s_bid      (s_bid),
        .sts_iniu_s_bresp    (s_bresp),
        .sts_iniu_s_arvalid  (s_arvalid),
        .sts_iniu_s_arready  (s_arready),
        .sts_iniu_s_arid     (s_arid),
        .sts_iniu_s_araddr   (s_araddr),
        .sts_iniu_s_arlen    (s_arlen),
        .sts_iniu_s_arsize   (s_arsize),
        .sts_iniu_s_arburst  (s_arburst),
        .sts_iniu_s_arlock   (s_arlock),
        .sts_iniu_s_arcache  (s_arcache),
        .sts_iniu_s_arprot   (s_arprot),
        .sts_iniu_s_arqos    (s_arqos),
        .sts_iniu_s_aruser   (s_aruser),
        .sts_iniu_s_rvalid   (s_rvalid),
        .sts_iniu_s_rready   (s_rready),
        .sts_iniu_s_rid      (s_rid),
        .sts_iniu_s_rdata    (s_rdata),
        .sts_iniu_s_rresp    (s_rresp),
        .sts_iniu_s_rlast    (s_rlast),
        .out_req_vld         (out_req_vld),
        .out_req_rdy         (out_req_rdy),
        .out_req_pld         (out_req_pld),
        .in_rsp_vld          (in_rsp_vld),
        .in_rsp_rdy          (in_rsp_rdy),
        .in_rsp_pld          (in_rsp_pld),
        .sys_cti_event_in    ('0),
        .sys_cti_event_out   (),
        .noc_cti_event_out   (),
        .noc_cti_event_in    ('0),
        .sys_cti_channel_in  ('0),
        .sys_cti_channel_out (),
        .noc_cti_channel_out (),
        .noc_cti_channel_in  ('0),
        .dbg_timestamp_in    ('0),
        .dbg_timestamp_out   (),
        .dbg_data_in         ('0),
        .dbg_data_out        ()
    );

endmodule
"""


def _render_tniu_wrapper(wrapper_name: str) -> str:
    return f"""module `_PREFIX_({wrapper_name})
    import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter int unsigned STS_DEMO_APB_ADDR_WIDTH = 32,
    parameter logic [TGT_ID_WIDTH-1:0] STS_DEMO_LOCAL_RSC_TGT_ID = '0,
    parameter logic [TGT_ID_WIDTH-1:0] STS_DEMO_LOCAL_REGBANK_TGT_ID = '0,
    parameter int unsigned STS_DEMO_SYS_APB_MASTER_NUM = 10,
    parameter logic [STS_DEMO_SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] STS_DEMO_SYS_APB_ROUTE_BASE = '0,
    parameter logic [STS_DEMO_SYS_APB_MASTER_NUM*TGT_ID_WIDTH-1:0] STS_DEMO_SYS_APB_ROUTE_MASK = '0
)
(
    input   logic                    clk_src,
    input   logic                    clk_dst,
    input   logic                    clk_dbg_timer,
    input   logic                    rstn_src,
    input   logic                    rstn_dst,
    input   logic                    rstn_dbg_timer,
    input   logic                    in_req_vld,
    output  logic                    in_req_rdy,
    input   sts_req_typ              in_req_pld,
    output  logic                    out_rsp_vld,
    input   logic                    out_rsp_rdy,
    output  sts_rsp_typ              out_rsp_pld,
    output  logic                    pmc_psel,
    output  logic                    pmc_penable,
    output  logic [31:0]             pmc_paddr,
    output  logic                    pmc_pwrite,
    output  logic [31:0]             pmc_pwdata,
    input   logic [31:0]             pmc_prdata,
    input   logic                    pmc_pready,
    output  logic [3:0]              pmc_pstrb,
    output  logic [2:0]              pmc_pprot,
    input   logic                    pmc_pslverr,
    output  logic [9:0]              m_psel,
    output  logic [31:0]             m_paddr,
    input   logic [9:0]              m_pready,
    input   logic [10*32-1:0]        m_prdata,
    input   logic [9:0]              m_pslverr,
    output  logic [2:0]              m_pprot,
    output  logic                    m_penable,
    output  logic                    m_pwrite,
    output  logic [31:0]             m_pwdata,
    output  logic [3:0]              m_pstrb,
    input   logic [31:0]             dbg_data_in,
    output  logic [31:0]             dbg_data_out,
    input   logic [63:0]             dbg_timestamp_in,
    output  logic [63:0]             dbg_timestamp_out,
    input   logic [CTI_EVENT_WIDTH-1:0] sys_cti_event_in,
    output  logic [CTI_EVENT_WIDTH-1:0] sys_cti_event_out,
    output  logic [CTI_EVENT_WIDTH-1:0] noc_cti_event_out,
    input   logic [CTI_EVENT_WIDTH-1:0] noc_cti_event_in,
    input   logic [CTI_EVENT_WIDTH-1:0] sys_cti_channel_in,
    output  logic [CTI_EVENT_WIDTH-1:0] sys_cti_channel_out,
    output  logic [CTI_EVENT_WIDTH-1:0] noc_cti_channel_out,
    input   logic [CTI_EVENT_WIDTH-1:0] noc_cti_channel_in
);

    `_PREFIX_(sts_tniu_top) #(
        .DBG_DATA_WIDTH        (32),
        .DBG_TIMESTAMP_WIDTH   (64),
        .APB_ADDR_WIDTH        (STS_DEMO_APB_ADDR_WIDTH),
        .LOCAL_RSC_TGT_ID      (STS_DEMO_LOCAL_RSC_TGT_ID),
        .LOCAL_REGBANK_TGT_ID  (STS_DEMO_LOCAL_REGBANK_TGT_ID),
        .SYS_APB_MASTER_NUM    (STS_DEMO_SYS_APB_MASTER_NUM),
        .SYS_APB_ROUTE_BASE    (STS_DEMO_SYS_APB_ROUTE_BASE),
        .SYS_APB_ROUTE_MASK    (STS_DEMO_SYS_APB_ROUTE_MASK)
    ) u_sts_tniu_top (
        .clk_src            (clk_dst),
        .clk_dst            (clk_src),
        .clk_dbg_timer      (clk_dbg_timer),
        .rstn_src           (rstn_dst),
        .rstn_dst           (rstn_src),
        .rstn_dbg_timer     (rstn_dbg_timer),
        .in_req_vld         (in_req_vld),
        .in_req_rdy         (in_req_rdy),
        .in_req_pld         (in_req_pld),
        .out_rsp_vld        (out_rsp_vld),
        .out_rsp_rdy        (out_rsp_rdy),
        .out_rsp_pld        (out_rsp_pld),
        .pmc_psel           (pmc_psel),
        .pmc_penable        (pmc_penable),
        .pmc_paddr          (pmc_paddr),
        .pmc_pwrite         (pmc_pwrite),
        .pmc_pwdata         (pmc_pwdata),
        .pmc_prdata         (pmc_prdata),
        .pmc_pready         (pmc_pready),
        .pmc_pstrb          (pmc_pstrb),
        .pmc_pprot          (pmc_pprot),
        .pmc_pslverr        (pmc_pslverr),
        .m_psel             (m_psel),
        .m_paddr            (m_paddr),
        .m_pready           (m_pready),
        .m_prdata           (m_prdata),
        .m_pslverr          (m_pslverr),
        .m_pprot            (m_pprot),
        .m_penable          (m_penable),
        .m_pwrite           (m_pwrite),
        .m_pwdata           (m_pwdata),
        .m_pstrb            (m_pstrb),
        .dbg_data_in        (dbg_data_in),
        .dbg_data_out       (dbg_data_out),
        .dbg_timestamp_in   (dbg_timestamp_in),
        .dbg_timestamp_out  (dbg_timestamp_out),
        .sys_cti_event_in   (sys_cti_event_in),
        .sys_cti_event_out  (sys_cti_event_out),
        .noc_cti_event_out  (noc_cti_event_out),
        .noc_cti_event_in   (noc_cti_event_in),
        .sys_cti_channel_in (sys_cti_channel_in),
        .sys_cti_channel_out(sys_cti_channel_out),
        .noc_cti_channel_out(noc_cti_channel_out),
        .noc_cti_channel_in (noc_cti_channel_in),
        .timing_bus1        (),
        .timing_bus2        (),
        .timing_bus3        (),
        .dbg_en             ()
    );

endmodule
"""


def _render_dec4_wrapper() -> str:
    return """module `_PREFIX_(sts_demo_dec4_wrap)
    import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter int unsigned STS_DEMO_DEC_SLAVE_NUM = 4,
    parameter logic [STS_DEMO_DEC_SLAVE_NUM*TGT_ID_WIDTH-1:0] STS_DEMO_ROUTE_BASE = '0,
    parameter logic [STS_DEMO_DEC_SLAVE_NUM*TGT_ID_WIDTH-1:0] STS_DEMO_ROUTE_MASK = '0,
    parameter int unsigned STS_DEMO_DBG_TIMESTAMP_WIDTH = 1,
    parameter int unsigned STS_DEMO_DBG_DATA_WIDTH = 1
)
(
    input   logic       clk,
    input   logic       rst_n,

    input   logic       mst_req_vld,
    output  logic       mst_req_rdy,
    input   sts_req_typ mst_req_pld,
    output  logic       mst_rsp_vld,
    input   logic       mst_rsp_rdy,
    output  sts_rsp_typ mst_rsp_pld,

    output  logic       slv0_req_vld,
    input   logic       slv0_req_rdy,
    output  sts_req_typ slv0_req_pld,
    input   sts_rsp_typ slv0_rsp_pld,
    input   logic       slv0_rsp_vld,
    output  logic       slv0_rsp_rdy,

    output  logic       slv1_req_vld,
    input   logic       slv1_req_rdy,
    output  sts_req_typ slv1_req_pld,
    input   sts_rsp_typ slv1_rsp_pld,
    input   logic       slv1_rsp_vld,
    output  logic       slv1_rsp_rdy,

    output  logic       slv2_req_vld,
    input   logic       slv2_req_rdy,
    output  sts_req_typ slv2_req_pld,
    input   sts_rsp_typ slv2_rsp_pld,
    input   logic       slv2_rsp_vld,
    output  logic       slv2_rsp_rdy,

    output  logic       slv3_req_vld,
    input   logic       slv3_req_rdy,
    output  sts_req_typ slv3_req_pld,
    input   sts_rsp_typ slv3_rsp_pld,
    input   logic       slv3_rsp_vld,
    output  logic       slv3_rsp_rdy
);

    logic [3:0] slv_req_vld_bus;
    logic [3:0] slv_req_rdy_bus;
    logic [3:0] slv_rsp_vld_bus;
    logic [3:0] slv_rsp_rdy_bus;
    sts_req_typ slv_req_pld_bus;
    sts_rsp_typ slv_rsp_pld_bus [3:0];

    assign slv_req_rdy_bus = {slv3_req_rdy, slv2_req_rdy, slv1_req_rdy, slv0_req_rdy};
    assign slv_rsp_vld_bus = {slv3_rsp_vld, slv2_rsp_vld, slv1_rsp_vld, slv0_rsp_vld};
    assign slv_rsp_pld_bus[0] = slv0_rsp_pld;
    assign slv_rsp_pld_bus[1] = slv1_rsp_pld;
    assign slv_rsp_pld_bus[2] = slv2_rsp_pld;
    assign slv_rsp_pld_bus[3] = slv3_rsp_pld;

    assign slv0_req_vld = slv_req_vld_bus[0];
    assign slv1_req_vld = slv_req_vld_bus[1];
    assign slv2_req_vld = slv_req_vld_bus[2];
    assign slv3_req_vld = slv_req_vld_bus[3];
    assign slv0_req_pld = slv_req_pld_bus;
    assign slv1_req_pld = slv_req_pld_bus;
    assign slv2_req_pld = slv_req_pld_bus;
    assign slv3_req_pld = slv_req_pld_bus;

    assign slv0_rsp_rdy = slv_rsp_rdy_bus[0];
    assign slv1_rsp_rdy = slv_rsp_rdy_bus[1];
    assign slv2_rsp_rdy = slv_rsp_rdy_bus[2];
    assign slv3_rsp_rdy = slv_rsp_rdy_bus[3];

    `_PREFIX_(sts_noc_dec_node) #(
        .SLAVE_NUM           (STS_DEMO_DEC_SLAVE_NUM),
        .ROUTE_BASE          (STS_DEMO_ROUTE_BASE),
        .ROUTE_MASK          (STS_DEMO_ROUTE_MASK),
        .DBG_TIMESTAMP_WIDTH (STS_DEMO_DBG_TIMESTAMP_WIDTH),
        .DBG_DATA_WIDTH      (STS_DEMO_DBG_DATA_WIDTH)
    ) u_sts_noc_dec_node (
        .clk                (clk),
        .rst_n              (rst_n),
        .mst_req_vld        (mst_req_vld),
        .mst_req_rdy        (mst_req_rdy),
        .mst_req_pld        (mst_req_pld),
        .mst_rsp_vld        (mst_rsp_vld),
        .mst_rsp_rdy        (mst_rsp_rdy),
        .mst_rsp_pld        (mst_rsp_pld),
        .slv_req_vld        (slv_req_vld_bus),
        .slv_req_rdy        (slv_req_rdy_bus),
        .slv_req_pld        (slv_req_pld_bus),
        .slv_rsp_vld        (slv_rsp_vld_bus),
        .slv_rsp_rdy        (slv_rsp_rdy_bus),
        .slv_rsp_pld        (slv_rsp_pld_bus),
        .mst_cti_channel_in ('0),
        .mst_cti_channel_out(),
        .slv_cti_channel_in ('0),
        .slv_cti_channel_out(),
        .mst_cti_event_in   ('0),
        .mst_cti_event_out  (),
        .slv_cti_event_in   ('0),
        .slv_cti_event_out  (),
        .mst_dbg_timestamp  ('0),
        .slv_dbg_timestamp  (),
        .slv_dbg_data       ('0),
        .mst_dbg_data       ()
    );

endmodule
"""
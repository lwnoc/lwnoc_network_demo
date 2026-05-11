`timescale 1ns/1ps

module tb_sts_aon_axi_access;
    import Base_lwnoc_sts_pack::*;

    localparam int unsigned TNIU_NUM             = 38;
    localparam int unsigned EXPECTED_ENTRY_NUM   = 191;
    localparam int unsigned TIMEOUT_CYCLES       = 2000;
    localparam logic [31:0] FUNC_STRIDE          = 32'h0002_0000;
    localparam logic [31:0] DEBUG_BASE_START     = 32'h0200_0000;
    localparam logic [31:0] DEBUG_STRIDE         = 32'h0200_0000;
    localparam logic [31:0] FUNC_SYS_SAMPLE_OFS  = 32'h0000_2000;
    localparam logic [31:0] DEBUG_SYS_SAMPLE_OFS = 32'h0000_2000;
    localparam logic [SRC_ID_WIDTH-1:0] AON_NODE_ID = '0;
    localparam logic [2:0] AXI_SINGLE_BEAT_SIZE = $clog2(AXI_STRB_WIDTH);

    logic clk;
    logic rst_n;

    logic                             s_awvalid;
    logic                             s_awready;
    logic [AXI_AWID_WIDTH-1:0]        s_awid;
    logic [AXI_ADDR_WIDTH-1:0]        s_awaddr;
    logic [AXI_AWLEN_WIDTH-1:0]       s_awlen;
    logic [2:0]                       s_awsize;
    logic [1:0]                       s_awburst;
    logic                             s_awlock;
    logic [3:0]                       s_awcache;
    logic [2:0]                       s_awprot;
    logic [3:0]                       s_awqos;
    logic [AXI_USER_WIDTH-1:0]        s_awuser;

    logic                             s_wvalid;
    logic                             s_wready;
    logic [AXI_DATA_WIDTH-1:0]        s_wdata;
    logic [AXI_STRB_WIDTH-1:0]        s_wstrb;
    logic                             s_wlast;

    logic                             s_bvalid;
    logic                             s_bready;
    logic [AXI_BID_WIDTH-1:0]         s_bid;
    logic [1:0]                       s_bresp;

    logic                             s_arvalid;
    logic                             s_arready;
    logic [AXI_ARID_WIDTH-1:0]        s_arid;
    logic [AXI_ADDR_WIDTH-1:0]        s_araddr;
    logic [AXI_ARLEN_WIDTH-1:0]       s_arlen;
    logic [2:0]                       s_arsize;
    logic [1:0]                       s_arburst;
    logic                             s_arlock;
    logic [3:0]                       s_arcache;
    logic [2:0]                       s_arprot;
    logic [3:0]                       s_arqos;
    logic [AXI_USER_WIDTH-1:0]        s_aruser;

    logic                             s_rvalid;
    logic                             s_rready;
    logic [AXI_RID_WIDTH-1:0]         s_rid;
    logic [AXI_DATA_WIDTH-1:0]        s_rdata;
    logic [1:0]                       s_rresp;
    logic                             s_rlast;

    logic                   bundle_aw_vld;
    logic                   bundle_aw_rdy;
    wire sts_iniu_axi_aw_chnl bundle_aw_pld;
    logic                   bundle_w_vld;
    logic                   bundle_w_rdy;
    wire sts_iniu_axi_w_chnl  bundle_w_pld;
    logic                   bundle_b_vld;
    logic                   bundle_b_rdy;
    wire sts_iniu_axi_b_chnl  bundle_b_pld;
    logic                   bundle_ar_vld;
    logic                   bundle_ar_rdy;
    wire sts_iniu_axi_ar_chnl bundle_ar_pld;
    logic                   bundle_r_vld;
    logic                   bundle_r_rdy;
    wire sts_iniu_axi_r_chnl  bundle_r_pld;

    logic                   out_req_vld;
    logic                   out_req_rdy;
    sts_req_typ             out_req_pld;
    logic                   in_rsp_vld;
    logic                   in_rsp_rdy;
    sts_rsp_typ             in_rsp_pld;

    logic safety_req_timeout_err;
    logic safety_rsp_timeout_err;
    logic safety_aw_timeout_err;
    logic safety_w_timeout_err;
    logic safety_ar_timeout_err;
    logic safety_arb_lockstep_err;
    logic addr_map_wr_err;
    logic addr_map_rd_err;

    string       resource_name [TNIU_NUM-1:0];
    int unsigned addr_idx      [TNIU_NUM-1:0];
    int unsigned tniu_id       [TNIU_NUM-1:0];
    logic        has_iniu_cti  [TNIU_NUM-1:0];
    int unsigned pass_count;
    int unsigned fail_count;
    int unsigned window_count;
    int unsigned next_write_id;
    int unsigned next_read_id;

    Base_sts_iniu_axi_bundle u_axi_bundle (
        .s_awvalid(s_awvalid), .s_awready(s_awready), .s_awid(s_awid),
        .s_awaddr(s_awaddr), .s_awlen(s_awlen), .s_awsize(s_awsize),
        .s_awburst(s_awburst), .s_awlock(s_awlock), .s_awcache(s_awcache),
        .s_awprot(s_awprot), .s_awqos(s_awqos), .s_awuser(s_awuser),
        .s_wvalid(s_wvalid), .s_wready(s_wready), .s_wdata(s_wdata),
        .s_wstrb(s_wstrb), .s_wlast(s_wlast),
        .s_bvalid(s_bvalid), .s_bready(s_bready), .s_bid(s_bid), .s_bresp(s_bresp),
        .s_arvalid(s_arvalid), .s_arready(s_arready), .s_arid(s_arid),
        .s_araddr(s_araddr), .s_arlen(s_arlen), .s_arsize(s_arsize),
        .s_arburst(s_arburst), .s_arlock(s_arlock), .s_arcache(s_arcache),
        .s_arprot(s_arprot), .s_arqos(s_arqos), .s_aruser(s_aruser),
        .s_rvalid(s_rvalid), .s_rready(s_rready), .s_rid(s_rid),
        .s_rdata(s_rdata), .s_rresp(s_rresp), .s_rlast(s_rlast),
        .m_aw_vld(bundle_aw_vld), .m_aw_rdy(bundle_aw_rdy), .m_aw_pld(bundle_aw_pld),
        .m_w_vld(bundle_w_vld), .m_w_rdy(bundle_w_rdy), .m_w_pld(bundle_w_pld),
        .m_b_vld(bundle_b_vld), .m_b_rdy(bundle_b_rdy), .m_b_pld(bundle_b_pld),
        .m_ar_vld(bundle_ar_vld), .m_ar_rdy(bundle_ar_rdy), .m_ar_pld(bundle_ar_pld),
        .m_r_vld(bundle_r_vld), .m_r_rdy(bundle_r_rdy), .m_r_pld(bundle_r_pld)
    );

    Base_sts_iniu_axi_iniu #(
        .NODE_NUM(`STS_INIU_NODE_NUM),
        .ADDR_MAP_ENTRY_NUM(`STS_INIU_ADDR_MAP_ENTRY_NUM),
        .ADDR_MAP_BASE_TABLE(`STS_INIU_ADDR_MAP_BASE_TABLE),
        .ADDR_MAP_MASK_TABLE(`STS_INIU_ADDR_MAP_MASK_TABLE),
        .ADDR_MAP_TGT_ID_TABLE(`STS_INIU_ADDR_MAP_TGT_ID_TABLE),
        .ADDR_MAP_DEFAULT_TGT_ID(`STS_INIU_ADDR_MAP_DEFAULT_TGT_ID),
        .SAFETY_TIMEOUT_EN(1'b0)
    ) dut (
        .clk(clk), .rst_n(rst_n), .node_id(AON_NODE_ID),
        .upstrm_aw_vld(bundle_aw_vld), .upstrm_aw_rdy(bundle_aw_rdy), .upstrm_aw_pld(bundle_aw_pld),
        .upstrm_w_vld(bundle_w_vld), .upstrm_w_rdy(bundle_w_rdy), .upstrm_w_pld(bundle_w_pld),
        .upstrm_b_vld(bundle_b_vld), .upstrm_b_rdy(bundle_b_rdy), .upstrm_b_pld(bundle_b_pld),
        .upstrm_ar_vld(bundle_ar_vld), .upstrm_ar_rdy(bundle_ar_rdy), .upstrm_ar_pld(bundle_ar_pld),
        .upstrm_r_vld(bundle_r_vld), .upstrm_r_rdy(bundle_r_rdy), .upstrm_r_pld(bundle_r_pld),
        .out_req_vld(out_req_vld), .out_req_rdy(out_req_rdy), .out_req_pld(out_req_pld),
        .in_rsp_vld(in_rsp_vld), .in_rsp_rdy(in_rsp_rdy), .in_rsp_pld(in_rsp_pld),
        .safety_req_timeout_err(safety_req_timeout_err),
        .safety_rsp_timeout_err(safety_rsp_timeout_err),
        .safety_aw_timeout_err(safety_aw_timeout_err),
        .safety_w_timeout_err(safety_w_timeout_err),
        .safety_ar_timeout_err(safety_ar_timeout_err),
        .safety_arb_lockstep_err(safety_arb_lockstep_err),
        .addr_map_wr_err(addr_map_wr_err),
        .addr_map_rd_err(addr_map_rd_err)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task automatic set_resource(input int unsigned resource_idx, input string name,
                                input int unsigned addr_idx_value,
                                input int unsigned tniu_id_value,
                                input logic has_iniu_cti_value);
        resource_name[resource_idx] = name;
        addr_idx[resource_idx]      = addr_idx_value;
        tniu_id[resource_idx]       = tniu_id_value;
        has_iniu_cti[resource_idx]  = has_iniu_cti_value;
    endtask

    task automatic init_resources();
        set_resource( 0, "safetyss_aon_local",  0, 34, 1'b1);
        set_resource( 1, "cpuss",                1,  1, 1'b0);
        set_resource( 2, "gpuss0",               2,  2, 1'b0);
        set_resource( 3, "gpuss1",               3,  3, 1'b0);
        set_resource( 4, "npuss0",               4,  4, 1'b0);
        set_resource( 5, "npuss1",               5,  5, 1'b0);
        set_resource( 6, "npuss2",               6,  6, 1'b0);
        set_resource( 7, "npuss3",               7,  7, 1'b0);
        set_resource( 8, "npuss4",               8,  8, 1'b0);
        set_resource( 9, "mipiss",               9,  9, 1'b0);
        set_resource(10, "camera_ss",           10, 10, 1'b0);
        set_resource(11, "ddrss0",              11, 11, 1'b0);
        set_resource(12, "ddrss1",              12, 12, 1'b0);
        set_resource(13, "ddrss2",              13, 13, 1'b0);
        set_resource(14, "ddrss3",              14, 14, 1'b0);
        set_resource(15, "ddrss4",              15, 15, 1'b0);
        set_resource(16, "ddrss5",              16, 16, 1'b0);
        set_resource(17, "ddrss6",              17, 17, 1'b0);
        set_resource(18, "ddrss7",              18, 18, 1'b0);
        set_resource(19, "ddrss8",              19, 19, 1'b0);
        set_resource(20, "ddrss9",              20, 20, 1'b0);
        set_resource(21, "ddrss10",             21, 21, 1'b0);
        set_resource(22, "ddrss11",             22, 22, 1'b0);
        set_resource(23, "vpuss",               23, 23, 1'b0);
        set_resource(24, "display_ss",          24, 24, 1'b0);
        set_resource(25, "pcie_ethss",          25, 25, 1'b0);
        set_resource(26, "vdspss0",             26, 26, 1'b0);
        set_resource(27, "vdspss1",             27, 27, 1'b0);
        set_resource(28, "vdspss2",             28, 28, 1'b0);
        set_resource(29, "vdspss3",             29, 29, 1'b0);
        set_resource(30, "vdspss4",             30, 30, 1'b0);
        set_resource(31, "vdspss5",             31, 31, 1'b0);
        set_resource(32, "usb_dpss",            32, 32, 1'b0);
        set_resource(33, "ufsss",               33, 33, 1'b0);
        set_resource(34, "periss",              34, 35, 1'b0);
        set_resource(35, "debug_ss",            35, 36, 1'b0);
        set_resource(36, "mcuss",               36, 37, 1'b0);
        set_resource(37, "nocss",               37, 38, 1'b0);
    endtask

    task automatic clear_axi_drive();
        s_awvalid = 1'b0; s_awid = '0; s_awaddr = '0; s_awlen = '0; s_awsize = '0;
        s_awburst = '0; s_awlock = '0; s_awcache = '0; s_awprot = '0; s_awqos = '0; s_awuser = '0;
        s_wvalid = 1'b0; s_wdata = '0; s_wstrb = '0; s_wlast = 1'b0;
        s_bready = 1'b1;
        s_arvalid = 1'b0; s_arid = '0; s_araddr = '0; s_arlen = '0; s_arsize = '0;
        s_arburst = '0; s_arlock = '0; s_arcache = '0; s_arprot = '0; s_arqos = '0; s_aruser = '0;
        s_rready = 1'b1;
        out_req_rdy = 1'b1;
        in_rsp_vld = 1'b0;
        in_rsp_pld = '0;
    endtask

    task automatic check_request(input string label, input logic [1:0] expected_opcode,
                                 input logic [AXI_ADDR_WIDTH-1:0] expected_addr,
                                 input logic [TGT_ID_WIDTH-1:0] expected_tgt_id,
                                 input logic [AXI_DATA_WIDTH-1:0] expected_data,
                                 input logic [AXI_STRB_WIDTH-1:0] expected_strb);
        logic ok;
        ok = 1'b1;
        if (out_req_pld.cmn.src_id !== AON_NODE_ID) begin
            ok = 1'b0;
            $display("[FAIL] %-42s src_id=0x%0h expected=0x%0h", label, out_req_pld.cmn.src_id, AON_NODE_ID);
        end
        if (out_req_pld.cmn.opcode !== expected_opcode) begin
            ok = 1'b0;
            $display("[FAIL] %-42s opcode=0x%0h expected=0x%0h", label, out_req_pld.cmn.opcode, expected_opcode);
        end
        if (out_req_pld.cmn.tgt_id !== expected_tgt_id) begin
            ok = 1'b0;
            $display("[FAIL] %-42s tgt_id=0x%03h expected=0x%03h addr=0x%08h", label,
                     out_req_pld.cmn.tgt_id, expected_tgt_id, expected_addr);
        end
        if (out_req_pld.req.addr !== expected_addr) begin
            ok = 1'b0;
            $display("[FAIL] %-42s req_addr=0x%08h expected=0x%08h", label, out_req_pld.req.addr, expected_addr);
        end
        if (out_req_pld.req.data !== expected_data) begin
            ok = 1'b0;
            $display("[FAIL] %-42s data=0x%08h expected=0x%08h", label, out_req_pld.req.data, expected_data);
        end
        if (out_req_pld.req.strb !== expected_strb) begin
            ok = 1'b0;
            $display("[FAIL] %-42s strb=0x%0h expected=0x%0h", label, out_req_pld.req.strb, expected_strb);
        end
        if (ok) pass_count++;
        else fail_count++;
    endtask

    task automatic drive_rsp(input logic [1:0] opcode, input logic [TXN_ID_WIDTH-1:0] txn_id,
                             input logic [TGT_ID_WIDTH-1:0] rsp_src_id,
                             input logic [AXI_DATA_WIDTH-1:0] rsp_data);
        int timeout;
        @(negedge clk);
        in_rsp_pld = '0;
        in_rsp_pld.cmn.src_id = rsp_src_id[SRC_ID_WIDTH-1:0];
        in_rsp_pld.cmn.tgt_id = '0;
        in_rsp_pld.cmn.txn_id = txn_id;
        in_rsp_pld.cmn.opcode = opcode;
        in_rsp_pld.rsp.resp   = 2'b00;
        in_rsp_pld.rsp.data   = rsp_data;
        in_rsp_pld.rsp.last   = 1'b1;
        in_rsp_vld = 1'b1;
        timeout = 0;
        while (in_rsp_vld) begin
            @(posedge clk);
            timeout++;
            if (timeout > TIMEOUT_CYCLES) $fatal(1, "Timeout waiting for response acceptance");
            if (in_rsp_vld && in_rsp_rdy) in_rsp_vld <= 1'b0;
        end
    endtask

    task automatic run_write_access(input string label, input logic [AXI_ADDR_WIDTH-1:0] addr,
                                    input int unsigned expected_tgt_id_value);
        logic [TGT_ID_WIDTH-1:0] expected_tgt_id;
        logic [AXI_AWID_WIDTH-1:0] axi_id;
        logic [TXN_ID_WIDTH-1:0] remap_id;
        logic [AXI_DATA_WIDTH-1:0] write_data;
        int timeout;
        logic request_seen;
        expected_tgt_id = expected_tgt_id_value;
        axi_id = next_write_id[AXI_AWID_WIDTH-1:0];
        next_write_id++;
        write_data = 32'hA500_0000 ^ addr ^ expected_tgt_id_value;
        @(negedge clk);
        s_awid = axi_id; s_awaddr = addr; s_awlen = '0; s_awsize = AXI_SINGLE_BEAT_SIZE;
        s_awburst = 2'b01; s_awlock = 1'b0; s_awcache = 4'h0; s_awprot = 3'h0; s_awqos = 4'h1; s_awuser = '0;
        s_wdata = write_data; s_wstrb = {AXI_STRB_WIDTH{1'b1}}; s_wlast = 1'b1;
        s_awvalid = 1'b1; s_wvalid = 1'b1;
        request_seen = 1'b0;
        timeout = 0;
        while (!request_seen) begin
            @(posedge clk);
            timeout++;
            if (timeout > TIMEOUT_CYCLES) $fatal(1, "Timeout waiting for write request: %s", label);
            if (s_awvalid && s_awready) s_awvalid <= 1'b0;
            if (s_wvalid && s_wready) s_wvalid <= 1'b0;
            if (out_req_vld && out_req_rdy) begin
                request_seen = 1'b1;
                remap_id = out_req_pld.cmn.txn_id;
                check_request({"WR ", label}, cfgOpcode_WrReq, addr, expected_tgt_id, write_data, {AXI_STRB_WIDTH{1'b1}});
            end
        end
        @(negedge clk);
        s_awvalid = 1'b0;
        s_wvalid = 1'b0;
        drive_rsp(cfgOpcode_WrRsp, remap_id, expected_tgt_id, '0);
        timeout = 0;
        while (!s_bvalid) begin
            @(posedge clk);
            timeout++;
            if (timeout > TIMEOUT_CYCLES) $fatal(1, "Timeout waiting for AXI B: %s", label);
        end
        if ((s_bid !== axi_id) || (s_bresp !== 2'b00)) begin
            fail_count++;
            $display("[FAIL] WR %-39s AXI B bid=0x%0h/0x%0h bresp=0x%0h", label, s_bid, axi_id, s_bresp);
        end
    endtask

    task automatic run_read_access(input string label, input logic [AXI_ADDR_WIDTH-1:0] addr,
                                   input int unsigned expected_tgt_id_value);
        logic [TGT_ID_WIDTH-1:0] expected_tgt_id;
        logic [AXI_ARID_WIDTH-1:0] axi_id;
        logic [TXN_ID_WIDTH-1:0] remap_id;
        logic [AXI_DATA_WIDTH-1:0] read_data;
        int timeout;
        logic request_seen;
        expected_tgt_id = expected_tgt_id_value;
        axi_id = next_read_id[AXI_ARID_WIDTH-1:0];
        next_read_id++;
        read_data = 32'h5A00_0000 ^ addr ^ expected_tgt_id_value;
        @(negedge clk);
        s_arid = axi_id; s_araddr = addr; s_arlen = '0; s_arsize = AXI_SINGLE_BEAT_SIZE;
        s_arburst = 2'b01; s_arlock = 1'b0; s_arcache = 4'h0; s_arprot = 3'h0; s_arqos = 4'h2; s_aruser = '0;
        s_arvalid = 1'b1;
        request_seen = 1'b0;
        timeout = 0;
        while (!request_seen) begin
            @(posedge clk);
            timeout++;
            if (timeout > TIMEOUT_CYCLES) $fatal(1, "Timeout waiting for read request: %s", label);
            if (s_arvalid && s_arready) s_arvalid <= 1'b0;
            if (out_req_vld && out_req_rdy) begin
                request_seen = 1'b1;
                remap_id = out_req_pld.cmn.txn_id;
                check_request({"RD ", label}, cfgOpcode_RdReq, addr, expected_tgt_id, '0, '0);
            end
        end
        @(negedge clk);
        s_arvalid = 1'b0;
        drive_rsp(cfgOpcode_RdRsp, remap_id, expected_tgt_id, read_data);
        timeout = 0;
        while (!s_rvalid) begin
            @(posedge clk);
            timeout++;
            if (timeout > TIMEOUT_CYCLES) $fatal(1, "Timeout waiting for AXI R: %s", label);
        end
        if ((s_rid !== axi_id) || (s_rresp !== 2'b00) || (s_rdata !== read_data) || (s_rlast !== 1'b1)) begin
            fail_count++;
            $display("[FAIL] RD %-39s AXI R rid=0x%0h/0x%0h rresp=0x%0h rlast=%0b rdata=0x%08h/0x%08h",
                     label, s_rid, axi_id, s_rresp, s_rlast, s_rdata, read_data);
        end
    endtask

    task automatic access_window(input string label, input logic [AXI_ADDR_WIDTH-1:0] addr,
                                 input int unsigned expected_tgt_id);
        window_count++;
        run_write_access(label, addr, expected_tgt_id);
        run_read_access(label, addr, expected_tgt_id);
    endtask

    initial begin
        logic [AXI_ADDR_WIDTH-1:0] func_base_addr;
        logic [AXI_ADDR_WIDTH-1:0] debug_base_addr;
        string label;

        init_resources();
        clear_axi_drive();
        rst_n = 1'b0;
        pass_count = 0;
        fail_count = 0;
        window_count = 0;
        next_write_id = 1;
        next_read_id = 64;

        if (`STS_INIU_ADDR_MAP_ENTRY_NUM != EXPECTED_ENTRY_NUM) begin
            $fatal(1, "AON INIU address-map entry count mismatch: got %0d expected %0d",
                   `STS_INIU_ADDR_MAP_ENTRY_NUM, EXPECTED_ENTRY_NUM);
        end
        if (TGT_ID_WIDTH != 9) $fatal(1, "AON INIU target ID width mismatch: got %0d expected 9", TGT_ID_WIDTH);

        repeat (8) @(posedge clk);
        rst_n = 1'b1;
        repeat (20) @(posedge clk);

        for (int unsigned resource_idx = 0; resource_idx < TNIU_NUM; resource_idx++) begin
            func_base_addr  = addr_idx[resource_idx] * FUNC_STRIDE;
            debug_base_addr = DEBUG_BASE_START + (addr_idx[resource_idx] * DEBUG_STRIDE);

            label = {resource_name[resource_idx], ".local_regbank"};
            access_window(label, func_base_addr, 32'h080 | tniu_id[resource_idx]);

            label = {resource_name[resource_idx], ".sys_reg"};
            access_window(label, func_base_addr + 32'h0000_1000, 32'h040 | tniu_id[resource_idx]);

            label = {resource_name[resource_idx], ".func_sys_apb"};
            access_window(label, func_base_addr + FUNC_SYS_SAMPLE_OFS, tniu_id[resource_idx]);

            label = {resource_name[resource_idx], ".local_cti"};
            access_window(label, debug_base_addr, 32'h0C0 | tniu_id[resource_idx]);

            if (has_iniu_cti[resource_idx]) begin
                label = {resource_name[resource_idx], ".local_iniu_cti"};
                access_window(label, debug_base_addr + 32'h0000_1000, 32'h100 | tniu_id[resource_idx]);
            end

            label = {resource_name[resource_idx], ".debug_sys_apb"};
            access_window(label, debug_base_addr + DEBUG_SYS_SAMPLE_OFS, tniu_id[resource_idx]);
        end

        repeat (10) @(posedge clk);
        if (addr_map_wr_err || addr_map_rd_err || safety_arb_lockstep_err) begin
            fail_count++;
            $display("[FAIL] safety errors: addr_map_wr=%0b addr_map_rd=%0b arb_lockstep=%0b",
                     addr_map_wr_err, addr_map_rd_err, safety_arb_lockstep_err);
        end
        if (window_count != EXPECTED_ENTRY_NUM) begin
            fail_count++;
            $display("[FAIL] window count=%0d expected=%0d", window_count, EXPECTED_ENTRY_NUM);
        end
        if (fail_count != 0) begin
            $fatal(1, "AON AXI access test FAILED: pass=%0d fail=%0d windows=%0d", pass_count, fail_count, window_count);
        end

        $display("[PASS] AON AXI access test passed: %0d AXI transactions across %0d address windows",
                 pass_count, window_count);
        $finish;
    end
endmodule

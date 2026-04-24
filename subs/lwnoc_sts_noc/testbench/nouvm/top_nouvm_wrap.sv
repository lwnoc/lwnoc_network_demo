module top_nouvm_wrap;
    timeunit 1ns;
    timeprecision 1ps;

    import `_PREFIX_(lwnoc_sts_pack):: *;

    localparam int DBG_TIMESTAMP_WIDTH = 64;
    localparam int DBG_DATA_WIDTH      = 32;
    localparam int SRC_TIMEOUT_CYCLES  = 60000;
    localparam int LEGAL_WINDOW_COUNT  = 12;

    logic clk_src        = 1'b0;
    logic clk_dst        = 1'b0;
    logic clk_dbg_timer  = 1'b0;
    logic rstn_src       = 1'b1;
    logic rstn_dst       = 1'b1;
    logic rstn_dbg_timer = 1'b1;

    logic [SRC_ID_WIDTH-1:0] node_id;

    logic                       s_awvalid;
    logic                       s_awready;
    logic [AXI_AWID_WIDTH-1:0]  s_awid;
    logic [AXI_ADDR_WIDTH-1:0]  s_awaddr;
    logic [AXI_AWLEN_WIDTH-1:0] s_awlen;
    logic [2:0]                 s_awsize;
    logic [1:0]                 s_awburst;
    logic                       s_awlock;
    logic [3:0]                 s_awcache;
    logic [2:0]                 s_awprot;
    logic [3:0]                 s_awqos;
    logic [AXI_USER_WIDTH-1:0]  s_awuser;
    logic                       s_wvalid;
    logic                       s_wready;
    logic [AXI_DATA_WIDTH-1:0]  s_wdata;
    logic [AXI_STRB_WIDTH-1:0]  s_wstrb;
    logic                       s_wlast;
    logic                       s_bvalid;
    logic                       s_bready;
    logic [AXI_BID_WIDTH-1:0]   s_bid;
    logic [1:0]                 s_bresp;
    logic                       s_arvalid;
    logic                       s_arready;
    logic [AXI_ARID_WIDTH-1:0]  s_arid;
    logic [AXI_ADDR_WIDTH-1:0]  s_araddr;
    logic [AXI_ARLEN_WIDTH-1:0] s_arlen;
    logic [2:0]                 s_arsize;
    logic [1:0]                 s_arburst;
    logic                       s_arlock;
    logic [3:0]                 s_arcache;
    logic [2:0]                 s_arprot;
    logic [3:0]                 s_arqos;
    logic [AXI_USER_WIDTH-1:0]  s_aruser;
    logic                       s_rvalid;
    logic                       s_rready;
    logic [AXI_RID_WIDTH-1:0]   s_rid;
    logic [AXI_DATA_WIDTH-1:0]  s_rdata;
    logic [1:0]                 s_rresp;
    logic                       s_rlast;

    logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_in;
    logic [CTI_EVENT_WIDTH-1:0]     sys_cti_event_out;
    logic [CTI_CHANNEL_WIDTH-1:0]   sys_cti_channel_in;
    logic [CTI_CHANNEL_WIDTH-1:0]   sys_cti_channel_out;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_in;
    logic [DBG_DATA_WIDTH-1:0]      dbg_data_in;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out_0;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out_1;
    logic [DBG_TIMESTAMP_WIDTH-1:0] dbg_timestamp_out_2;
    logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_0;
    logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_1;
    logic [DBG_DATA_WIDTH-1:0]      dbg_data_out_2;
    logic [2:0][31:0]               timing_bus1;
    logic [2:0][31:0]               timing_bus2;
    logic [2:0][31:0]               timing_bus3;
    logic [2:0][31:0]               dbg_en;

    string testcase;
    bit enable_trace;
    bit enable_vcd;
    bit saw_dbg_data_out_0;
    bit saw_dbg_data_out_1;
    bit saw_dbg_data_out_2;
    bit saw_dbg_timestamp_out_0;
    bit saw_dbg_timestamp_out_1;
    bit saw_dbg_timestamp_out_2;
    bit saw_sys_cti_event_out;
    bit saw_sys_cti_channel_out;
    int unsigned b_handshake_count;
    int unsigned r_handshake_count;
    int unsigned aw_handshake_count;
    int unsigned w_handshake_count;
    int unsigned ar_handshake_count;
    logic [AXI_BID_WIDTH-1:0]  last_b_id;
    logic [1:0]                last_b_resp;
    logic [AXI_RID_WIDTH-1:0]  last_r_id;
    logic [AXI_DATA_WIDTH-1:0] last_r_data;
    logic [1:0]                last_r_resp;
    logic                      last_r_last;

    always #1ns clk_src = ~clk_src;
    always #2ns clk_dst = ~clk_dst;
    always #2ns clk_dbg_timer = ~clk_dbg_timer;

    always_ff @(posedge clk_dbg_timer or negedge rstn_dbg_timer) begin
        if (!rstn_dbg_timer) begin
            dbg_timestamp_in <= '0;
        end else begin
            dbg_timestamp_in <= dbg_timestamp_in + 1'b1;
        end
    end

    always_ff @(posedge clk_src or negedge rstn_src) begin
        if (!rstn_src) begin
            dbg_data_in <= '0;
        end else begin
            dbg_data_in <= dbg_data_in + 32'h1;
        end
    end

    always_ff @(posedge clk_src or negedge rstn_src) begin
        if (!rstn_src) begin
            aw_handshake_count <= '0;
            w_handshake_count  <= '0;
            ar_handshake_count <= '0;
            b_handshake_count <= '0;
            r_handshake_count <= '0;
            last_b_id         <= '0;
            last_b_resp       <= '0;
            last_r_id         <= '0;
            last_r_data       <= '0;
            last_r_resp       <= '0;
            last_r_last       <= '0;
        end else begin
            if (s_awvalid && s_awready) begin
                aw_handshake_count <= aw_handshake_count + 1'b1;
            end
            if (s_wvalid && s_wready) begin
                w_handshake_count <= w_handshake_count + 1'b1;
            end
            if (s_arvalid && s_arready) begin
                ar_handshake_count <= ar_handshake_count + 1'b1;
            end
            if (s_bvalid && s_bready) begin
                b_handshake_count <= b_handshake_count + 1'b1;
                last_b_id         <= s_bid;
                last_b_resp       <= s_bresp;
            end
            if (s_rvalid && s_rready) begin
                r_handshake_count <= r_handshake_count + 1'b1;
                last_r_id         <= s_rid;
                last_r_data       <= s_rdata;
                last_r_resp       <= s_rresp;
                last_r_last       <= s_rlast;
            end
        end
    end

    always @(posedge clk_src) begin
        if (enable_trace && rstn_src && s_awvalid && s_awready) begin
            $display("[%0t] AW addr=0x%08h id=%0d", $time, s_awaddr, s_awid);
        end
        if (enable_trace && rstn_src && s_wvalid && s_wready) begin
            $display("[%0t] W data=0x%08h strb=0x%0h last=%0b", $time, s_wdata, s_wstrb, s_wlast);
        end
        if (enable_trace && rstn_src && s_bvalid && s_bready) begin
            $display("[%0t] B resp=%0d id=%0d", $time, s_bresp, s_bid);
        end
        if (enable_trace && rstn_src && s_arvalid && s_arready) begin
            $display("[%0t] AR addr=0x%08h id=%0d", $time, s_araddr, s_arid);
        end
        if (enable_trace && rstn_src && s_rvalid && s_rready) begin
            $display("[%0t] R data=0x%08h resp=%0d id=%0d last=%0b", $time, s_rdata, s_rresp, s_rid, s_rlast);
        end
        if (enable_trace && rstn_src && u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_vld) begin
            $display("[%0t] TNIU0 local req vld=%0b rdy=%0b opcode=%0b addr=0x%08h data=0x%08h strb=0x%0h tgt=0x%0h psel_pre=%0b penable_pre=%0b psel_reg=%0b pready_reg=%0b rsp_apb_vld=%0b out_rsp_vld=%0b", $time,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_vld,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_rdy,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_pld.cmn.opcode,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_pld.req.addr,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_pld.req.data,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_pld.req.strb,
                u_dut.u_top_wrap.u_tniu_noc.req_apb_tniu_pld.cmn.tgt_id,
                u_dut.u_top_wrap.u_tniu_noc.psel_pre_dec,
                u_dut.u_top_wrap.u_tniu_noc.penable_pre_dec,
                u_dut.u_top_wrap.u_tniu_noc.psel_reg,
                u_dut.u_top_wrap.u_tniu_noc.pready_reg,
                u_dut.u_top_wrap.u_tniu_noc.rsp_apb_tniu_vld,
                u_dut.tniu0_rsp_vld);
        end
        if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.psel ||
                                         u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.rsp_pending ||
                                         u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.fifo_in_rsp_vld)) begin
            $display("[%0t] TNIU0 APB state fifo_out_vld=%0b fifo_out_rdy=%0b psel=%0b penable=%0b pwrite=%0b paddr=0x%08h pwdata=0x%08h prdata=0x%08h pready=%0b ptgt=0x%0h rsp_pending=%0b fifo_rsp_vld=%0b fifo_rsp_rdy=%0b reg0=0x%08h", $time,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.fifo_out_req_vld,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.fifo_out_req_rdy,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.psel,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.penable,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.pwrite,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.paddr,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.pwdata,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.prdata,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.pready,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.ptgt_id,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.rsp_pending,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.fifo_in_rsp_vld,
                u_dut.u_top_wrap.u_tniu_noc.u_sts_tniu_apb_noc.fifo_in_rsp_rdy,
                u_dut.u_top_wrap.u_tniu_noc.u_regbank_sts_tniu.debug_en_debug_en);
        end
        if (enable_trace && rstn_src && u_dut.tniu0_rsp_vld) begin
            $display("[%0t] TNIU0 rsp vld=%0b rdy=%0b opcode=%0b resp=%0b last=%0b", $time,
                u_dut.tniu0_rsp_vld,
                u_dut.tniu0_rsp_rdy,
                u_dut.tniu0_rsp_pld.cmn.opcode,
                u_dut.tniu0_rsp_pld.rsp.resp,
                u_dut.tniu0_rsp_pld.rsp.last);
        end
        if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_tniu_noc.rsp_tniu_sys_vld ||
                                         u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.read_resp_vld ||
                                         u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.stall_buffer_vld ||
                                         u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.trans_cnt != 0)) begin
            $display("[%0t] TNIU0_RSP_AFIFO trans_cnt=%0d read_vld=%0b read_rdy=%0b read_last=%0b stall_vld=%0b stall_rdy=%0b rsp_sys_vld=%0b rsp_sys_rdy=%0b rsp_sys_last=%0b out_vld=%0b out_rdy=%0b out_last=%0b", $time,
                u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.trans_cnt,
                u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.read_resp_vld,
                u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.read_resp_rdy,
                u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.read_resp_last,
                u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.stall_buffer_vld,
                u_dut.u_top_wrap.u_tniu_noc.u_tniu_noc_afifo_slv.stall_buffer_rdy,
                u_dut.u_top_wrap.u_tniu_noc.rsp_tniu_sys_vld,
                u_dut.u_top_wrap.u_tniu_noc.rsp_tniu_sys_rdy,
                u_dut.u_top_wrap.u_tniu_noc.rsp_tniu_sys_pld.rsp.last,
                u_dut.tniu0_rsp_vld,
                u_dut.tniu0_rsp_rdy,
                u_dut.tniu0_rsp_pld.rsp.last);
        end
        if (enable_trace && rstn_src && u_dut.iniu_rsp_vld) begin
            $display("[%0t] INIU rsp vld=%0b rdy=%0b opcode=%0b resp=%0b last=%0b", $time,
                u_dut.iniu_rsp_vld,
                u_dut.iniu_rsp_rdy,
                u_dut.iniu_rsp_pld.cmn.opcode,
                u_dut.iniu_rsp_pld.rsp.resp,
                u_dut.iniu_rsp_pld.rsp.last);
        end
        if (enable_trace && rstn_src && u_dut.u_top_wrap.u_iniu_sys.rsp_vld_temp) begin
            $display("[%0t] INIU_SYS rsp_temp vld=%0b rdy=%0b opcode=%0b resp=%0b last=%0b", $time,
                u_dut.u_top_wrap.u_iniu_sys.rsp_vld_temp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_rdy_temp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_pld_temp.cmn.opcode,
                u_dut.u_top_wrap.u_iniu_sys.rsp_pld_temp.rsp.resp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_pld_temp.rsp.last);
        end
        if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.bundle_b_vld ||
                                         s_bvalid)) begin
            $display("[%0t] WR_CH rsp_vld=%0b rsp_rdy=%0b bundle_b_vld=%0b bundle_b_rdy=%0b s_bvalid=%0b s_bready=%0b bid=%0d bresp=%0d", $time,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_rdy,
                u_dut.u_top_wrap.u_iniu_sys.bundle_b_vld,
                u_dut.u_top_wrap.u_iniu_sys.bundle_b_rdy,
                s_bvalid,
                s_bready,
                s_bid,
                s_bresp);
        end
        if (enable_trace && rstn_src && u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_vld) begin
            $display("[%0t] WR_CH in_rsp vld=%0b rdy=%0b txn_id=%0d last=%0b up_b_vld=%0b up_b_rdy=%0b", $time,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_pld.rsp.last,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_b_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_b_rdy);
        end
        if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.alloc_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_rsp_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_b_vld)) begin
            $display("[%0t] WR_MAP alloc_vld=%0b alloc_rdy=%0b alloc_id=%0d remap_id=%0d check_idx=%0d check_ack=%0b check_id=%0d b_vld=%0b b_rdy=%0b b_id=%0d",
                $time,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.alloc_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.alloc_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.alloc_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.wr_id_alloc,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.check_idx,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.check_ack,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.check_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_b_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_b_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_b_pld.bid);
        end
        if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.bundle_aw_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_aw_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_aw_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.bundle_w_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_w_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_w_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.merged_req_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.out_req_vld)) begin
            $display("[%0t] WR_PIPE s_aw_vld=%0b s_aw_rdy=%0b s_aw_addr=0x%08h bundle_aw_vld=%0b bundle_aw_rdy=%0b bundle_aw_addr=0x%08h chnl_in_aw_vld=%0b chnl_in_aw_rdy=%0b chnl_in_aw_addr=0x%08h s_w_vld=%0b s_w_rdy=%0b s_w_data=0x%08h bundle_w_vld=%0b bundle_w_rdy=%0b bundle_w_data=0x%08h chnl_in_w_vld=%0b chnl_in_w_rdy=%0b chnl_in_w_data=0x%08h aw_seen=%0b aw_hold=%0b aw_vld=%0b aw_rdy=%0b aw_id=%0d w_seen=%0b w_hold=%0b w_vld=%0b w_rdy=%0b w_data=0x%08h merged_vld=%0b merged_rdy=%0b merged_data=0x%08h out_req_vld=%0b out_req_rdy=%0b out_txn=%0d out_data=0x%08h",
                $time,
                s_awvalid,
                s_awready,
                s_awaddr,
                u_dut.u_top_wrap.u_iniu_sys.bundle_aw_vld,
                u_dut.u_top_wrap.u_iniu_sys.bundle_aw_rdy,
                u_dut.u_top_wrap.u_iniu_sys.bundle_aw_pld.awaddr,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_aw_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_aw_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_aw_pld.awaddr,
                s_wvalid,
                s_wready,
                s_wdata,
                u_dut.u_top_wrap.u_iniu_sys.bundle_w_vld,
                u_dut.u_top_wrap.u_iniu_sys.bundle_w_rdy,
                u_dut.u_top_wrap.u_iniu_sys.bundle_w_pld.wdata,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_w_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_w_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.upstrm_w_pld.wdata,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.aw_stage_seen,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.aw_hold_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_aw_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_aw_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_aw_pld.awid,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.w_stage_seen,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.w_hold_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_w_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_w_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.fifo_out_w_pld.wdata,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.merged_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.merged_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.merged_req_pld.req.data,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.out_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.out_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.out_req_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_wr_chnl.out_req_pld.req.data);
        end
            if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.in_rsp_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.bundle_r_vld ||
                             s_rvalid)) begin
                $display("[%0t] RD_CH ar_fifo_vld=%0b ar_fifo_rdy=%0b ar_id=%0d alloc_vld=%0b alloc_rdy=%0b remap_id=%0d out_req_vld=%0b out_req_rdy=%0b out_txn=%0d in_rsp_vld=%0b in_rsp_rdy=%0b check_idx=%0d r_vld=%0b r_rdy=%0b rid=%0d last=%0b",
                $time,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.alloc_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.alloc_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.rd_id_alloc,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.in_rsp_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.in_rsp_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.check_idx,
                u_dut.u_top_wrap.u_iniu_sys.bundle_r_vld,
                u_dut.u_top_wrap.u_iniu_sys.bundle_r_rdy,
                u_dut.u_top_wrap.u_iniu_sys.bundle_r_pld.rid,
                u_dut.u_top_wrap.u_iniu_sys.bundle_r_pld.rlast);
            end
            if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.bundle_ar_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_hold_vld)) begin
                $display("[%0t] RD_MAP bundle_ar_vld=%0b bundle_ar_rdy=%0b bundle_addr=0x%08h map_tgt=0x%0h fifo_in_addr=0x%08h fifo_in_tgt=0x%0h fifo_out_addr=0x%08h fifo_out_tgt=0x%0h hold_vld=%0b hold_addr=0x%08h hold_tgt=0x%0h",
                $time,
                u_dut.u_top_wrap.u_iniu_sys.bundle_ar_vld,
                u_dut.u_top_wrap.u_iniu_sys.bundle_ar_rdy,
                u_dut.u_top_wrap.u_iniu_sys.bundle_ar_pld.araddr,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.mapped_ar_tgt_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_in_ar_pld.req.addr,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_in_ar_pld.cmn.tgt_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_pld.req.addr,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_pld.cmn.tgt_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_hold_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_hold_pld.req.addr,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_hold_pld.cmn.tgt_id);
            end
            if (enable_trace && rstn_src && (s_arvalid ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_stage_seen ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_in_ar_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_hold_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_vld)) begin
                $display("[%0t] RD_REQ s_ar_vld=%0b s_ar_rdy=%0b stage_seen=%0b in_hold=%0b fifo_in_vld=%0b fifo_in_rdy=%0b fifo_out_vld=%0b fifo_out_rdy=%0b hold_vld=%0b alloc_vld=%0b alloc_rdy=%0b out_req_vld=%0b out_req_rdy=%0b out_tgt=0x%0h out_addr=0x%08h",
                $time,
                s_arvalid,
                s_arready,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_stage_seen,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_in_hold_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_in_ar_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_in_ar_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.fifo_out_ar_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.ar_hold_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.alloc_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.alloc_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_pld.cmn.tgt_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.out_req_pld.req.addr);
            end
            if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_req_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.rd_req_vld ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.out_req_vld)) begin
                $display("[%0t] INIU_ARB wr_vld=%0b wr_rdy=%0b wr_txn=%0d rd_vld=%0b rd_rdy=%0b rd_txn=%0d arb_vld=%0b arb_rdy=%0b arb_txn=%0d out_req_vld=%0b out_req_rdy=%0b out_opcode=%0b out_txn=%0d",
                $time,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.wr_req_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.rd_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.rd_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.rd_req_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.arb_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.arb_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.arb_pld.cmn.txn_id,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.out_req_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.out_req_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.out_req_pld.cmn.opcode,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_axi_iniu_sys_side.out_req_pld.cmn.txn_id);
            end
        if (enable_trace && rstn_src && (u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.trans_cnt != 0 ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_vld ||
                                         u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.stall_buffer_vld)) begin
            $display("[%0t] AFIFO_SRC trans_cnt=%0d req_hs=%0b req_last=%0b read_rsp_vld=%0b read_rsp_rdy=%0b read_rsp_last=%0b stall_vld=%0b stall_rdy=%0b rsp_m_vld=%0b rsp_m_rdy=%0b rsp_last=%0b",
                $time,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.trans_cnt,
                (u_dut.u_top_wrap.u_iniu_sys.req_vld_temp && u_dut.u_top_wrap.u_iniu_sys.req_rdy_temp),
                u_dut.u_top_wrap.u_iniu_sys.req_last_temp,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_last,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.stall_buffer_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.stall_buffer_rdy,
                u_dut.u_top_wrap.u_iniu_sys.rsp_vld_temp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_rdy_temp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_last_temp);
        end
            if (enable_trace && rstn_src && (u_dut.u_top_wrap.iniu_rsp_wptr_async != '0 ||
                             u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.u_rsp_afifo_src.wptr_async_inner_SIZE_ONLY != '0 ||
                             u_dut.u_top_wrap.iniu_rsp_rptr_async != '0 ||
                             u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_vld ||
                             u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_rdy ||
                             u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_vld)) begin
                $display("[%0t] INIU_RSP_AFIFO dst_vld=%0b dst_rdy=%0b dst_last_in=%0b dst_pld_last=%0b dst_hs=%0b dst_winc=%0b dst_wptr_sync=0x%0h dst_fifo_wptr=0x%0h wptr=0x%0h rptr_async=0x%0h rptr_sync=0x%0h src_read_vld=%0b src_read_rdy=%0b src_read_last=%0b src_rsp_vld=%0b src_rsp_rdy=%0b src_rsp_last=%0b",
                $time,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_vld,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_rdy,
                u_dut.u_top_wrap.u_iniu_noc.rsp_m_last,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_pld[0],
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.u_rsp_afifo_src.s_handshake,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.u_rsp_afifo_src.winc,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.u_rsp_afifo_src.wptr_sync,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.u_rsp_afifo_src.wptr_async_inner_SIZE_ONLY,
                u_dut.u_top_wrap.iniu_rsp_wptr_async,
                u_dut.u_top_wrap.iniu_rsp_rptr_async,
                u_dut.u_top_wrap.iniu_rsp_rptr_sync,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_vld,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_rdy,
                u_dut.u_top_wrap.u_iniu_sys.u_sts_iniu_afifo_src.read_resp_last,
                u_dut.u_top_wrap.u_iniu_sys.rsp_vld_temp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_rdy_temp,
                u_dut.u_top_wrap.u_iniu_sys.rsp_last_temp);
            end
            if (enable_trace && rstn_src && (u_dut.u_top_wrap.iniu_req_wptr_async != '0 ||
                             u_dut.u_top_wrap.iniu_req_rptr_async != '0 ||
                             u_dut.u_top_wrap.iniu_req_rptr_sync != '0 ||
                             u_dut.u_top_wrap.u_iniu_sys.req_vld_temp ||
                             u_dut.u_top_wrap.u_iniu_noc.req_s_vld)) begin
                $display("[%0t] INIU_REQ_AFIFO src_req_vld=%0b src_req_rdy=%0b src_last=%0b wptr=0x%0h rptr_async=0x%0h rptr_sync=0x%0h dst_req_vld=%0b dst_req_rdy=%0b dst_last=%0b",
                $time,
                u_dut.u_top_wrap.u_iniu_sys.req_vld_temp,
                u_dut.u_top_wrap.u_iniu_sys.req_rdy_temp,
                u_dut.u_top_wrap.u_iniu_sys.req_last_temp,
                u_dut.u_top_wrap.iniu_req_wptr_async,
                u_dut.u_top_wrap.iniu_req_rptr_async,
                u_dut.u_top_wrap.iniu_req_rptr_sync,
                u_dut.u_top_wrap.u_iniu_noc.req_s_vld,
                u_dut.u_top_wrap.u_iniu_noc.req_s_rdy,
                u_dut.u_top_wrap.u_iniu_noc.req_s_last_afifo);
            end
    end

    always @(posedge clk_dst) begin
        if (enable_trace && rstn_dst && (u_dut.iniu_rsp_vld ||
                                         u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_vld)) begin
            $display("[%0t] INIU_NOC_DST rsp_in_vld=%0b rsp_in_rdy=%0b afifo_in_vld=%0b afifo_in_rdy=%0b afifo_in_last=%0b wptr_raw=0x%0h wptr_out=0x%0h",
                $time,
                u_dut.iniu_rsp_vld,
                u_dut.iniu_rsp_rdy,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_vld,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_rdy,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.rsp_ext_m_last,
                u_dut.u_top_wrap.u_iniu_noc.u_sts_iniu_afifo_dst.u_rsp_afifo_src.wptr_async_inner_SIZE_ONLY,
                u_dut.u_top_wrap.iniu_rsp_wptr_async);
        end
            if (enable_trace && rstn_dst && (u_dut.u_top_wrap.u_tniu_sys.rsp_apb_tniu_vld ||
                             u_dut.u_top_wrap.u_tniu_sys.u_tniu_sys_afifo_mst.rsp_m_vld ||
                             u_dut.u_top_wrap.u_tniu_sys.u_sts_tniu_apb_sys.out_rsp_vld)) begin
                $display("[%0t] TNIU0_SYS_RSP apb_vld=%0b apb_rdy=%0b apb_last=%0b afifo_rsp_vld=%0b afifo_rsp_rdy=%0b afifo_rsp_last=%0b", $time,
                u_dut.u_top_wrap.u_tniu_sys.u_sts_tniu_apb_sys.out_rsp_vld,
                u_dut.u_top_wrap.u_tniu_sys.u_sts_tniu_apb_sys.out_rsp_rdy,
                u_dut.u_top_wrap.u_tniu_sys.u_sts_tniu_apb_sys.out_rsp_pld.rsp.last,
                u_dut.u_top_wrap.u_tniu_sys.rsp_apb_tniu_vld,
                u_dut.u_top_wrap.u_tniu_sys.rsp_apb_tniu_rdy,
                u_dut.u_top_wrap.u_tniu_sys.rsp_apb_tniu_pld.rsp.last);
            end
    end

    always @(posedge clk_src or negedge rstn_src) begin
        if (!rstn_src) begin
            saw_dbg_data_out_0   <= 1'b0;
            saw_dbg_data_out_1   <= 1'b0;
            saw_dbg_data_out_2   <= 1'b0;
            saw_sys_cti_event_out   <= 1'b0;
            saw_sys_cti_channel_out <= 1'b0;
        end else begin
            if (!$isunknown(dbg_data_out_0) && (dbg_data_out_0 != '0)) saw_dbg_data_out_0 <= 1'b1;
            if (!$isunknown(dbg_data_out_1) && (dbg_data_out_1 != '0)) saw_dbg_data_out_1 <= 1'b1;
            if (!$isunknown(dbg_data_out_2) && (dbg_data_out_2 != '0)) saw_dbg_data_out_2 <= 1'b1;
            if (sys_cti_event_out == '1) saw_sys_cti_event_out <= 1'b1;
            if (sys_cti_channel_out == '1) saw_sys_cti_channel_out <= 1'b1;
        end
    end

    always @(posedge clk_dbg_timer or negedge rstn_dbg_timer) begin
        if (!rstn_dbg_timer) begin
            saw_dbg_timestamp_out_0 <= 1'b0;
            saw_dbg_timestamp_out_1 <= 1'b0;
            saw_dbg_timestamp_out_2 <= 1'b0;
        end else begin
            if (!$isunknown(dbg_timestamp_out_0) && (dbg_timestamp_out_0 != '0)) saw_dbg_timestamp_out_0 <= 1'b1;
            if (!$isunknown(dbg_timestamp_out_1) && (dbg_timestamp_out_1 != '0)) saw_dbg_timestamp_out_1 <= 1'b1;
            if (!$isunknown(dbg_timestamp_out_2) && (dbg_timestamp_out_2 != '0)) saw_dbg_timestamp_out_2 <= 1'b1;
        end
    end

    task automatic reset_dut();
        begin
            s_awvalid = 1'b0;
            s_wvalid  = 1'b0;
            s_bready  = 1'b1;
            s_arvalid = 1'b0;
            s_rready  = 1'b1;
            s_awid    = '0;
            s_awaddr  = '0;
            s_awlen   = '0;
            s_awsize  = 3'd2;
            s_awburst = 2'b01;
            s_awlock  = 1'b0;
            s_awcache = '0;
            s_awprot  = '0;
            s_awqos   = '0;
            s_awuser  = '0;
            s_wdata   = '0;
            s_wstrb   = '1;
            s_wlast   = 1'b1;
            s_arid    = '0;
            s_araddr  = '0;
            s_arlen   = '0;
            s_arsize  = 3'd2;
            s_arburst = 2'b01;
            s_arlock  = 1'b0;
            s_arcache = '0;
            s_arprot  = '0;
            s_arqos   = '0;
            s_aruser  = '0;
            node_id   = 8'h01;
            sys_cti_event_in   = '0;
            sys_cti_channel_in = '0;

            rstn_src       = 1'b0;
            rstn_dst       = 1'b0;
            rstn_dbg_timer = 1'b0;
            repeat (20) @(posedge clk_src);
            rstn_src       = 1'b1;
            rstn_dst       = 1'b1;
            rstn_dbg_timer = 1'b1;
            repeat (4) @(posedge clk_src);
        end
    endtask

    task automatic set_apb_stall_cycles(input int cycles);
        begin
            u_dut.u_pmc0.stall_cycles_cfg  = cycles;
            u_dut.u_sys00.stall_cycles_cfg = cycles;
            u_dut.u_sys01.stall_cycles_cfg = cycles;
            u_dut.u_pmc1.stall_cycles_cfg  = cycles;
            u_dut.u_sys10.stall_cycles_cfg = cycles;
            u_dut.u_sys11.stall_cycles_cfg = cycles;
            u_dut.u_pmc2.stall_cycles_cfg  = cycles;
            u_dut.u_sys20.stall_cycles_cfg = cycles;
            u_dut.u_sys21.stall_cycles_cfg = cycles;
        end
    endtask

    task automatic do_axi_write(
        input logic [31:0] addr,
        input logic [31:0] data,
        input logic [7:0] id,
        input logic [1:0] exp_resp
    );
        bit aw_done;
        bit w_done;
        bit got_bresp;
        bit aw_timeout_hit;
        bit w_timeout_hit;
        logic [AXI_BID_WIDTH-1:0] b_id;
        logic [1:0]               b_resp;
        logic [7:0]               axi_id;
        int cycle;
        begin
            aw_done = 1'b0;
            w_done  = 1'b0;
            got_bresp = 1'b0;
            aw_timeout_hit = 1'b0;
            w_timeout_hit  = 1'b0;
            b_id = '0;
            b_resp = '0;
            axi_id = id;

            s_awid    = axi_id;
            s_awaddr  = addr;
            s_awlen   = '0;
            s_awsize  = 3'd2;
            s_awburst = 2'b01;
            s_awvalid = 1'b1;

            s_wdata   = data;
            s_wstrb   = 4'hf;
            s_wlast   = 1'b1;
            s_wvalid  = 1'b1;

            @(negedge clk_src);

            fork
                begin : aw_ctrl
                    fork : aw_wait_or_timeout
                        begin
                            @(posedge clk_src iff s_awready);
                            s_awvalid = 1'b0;
                            aw_done = 1'b1;
                            if (enable_trace) begin
                                $display("[%0t] DO_AXI_WRITE AW done addr=0x%08h id=%0d", $time, addr, axi_id);
                            end
                        end
                        begin
                            repeat (SRC_TIMEOUT_CYCLES) @(posedge clk_src);
                            if (!aw_done) begin
                                aw_timeout_hit = 1'b1;
                            end
                        end
                    join_any
                    disable aw_wait_or_timeout;
                end
                begin : w_ctrl
                    fork : w_wait_or_timeout
                        begin
                            @(posedge clk_src iff s_wready);
                            s_wvalid = 1'b0;
                            w_done = 1'b1;
                            if (enable_trace) begin
                                $display("[%0t] DO_AXI_WRITE W done addr=0x%08h id=%0d", $time, addr, axi_id);
                            end
                        end
                        begin
                            repeat (SRC_TIMEOUT_CYCLES) @(posedge clk_src);
                            if (!w_done) begin
                                w_timeout_hit = 1'b1;
                            end
                        end
                    join_any
                    disable w_wait_or_timeout;
                end
            join

            if (!(aw_done && w_done) || aw_timeout_hit || w_timeout_hit) begin
                s_awvalid = 1'b0;
                s_wvalid = 1'b0;
                $fatal(1, "WRITE handshake timeout addr=0x%08h id=%0d", addr, axi_id);
            end

            if (enable_trace) begin
                $display("[%0t] DO_AXI_WRITE wait B addr=0x%08h id=%0d", $time, addr, axi_id);
            end

            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (s_bvalid && s_bready) begin
                    b_id = s_bid;
                    b_resp = s_bresp;
                    got_bresp = 1'b1;
                    break;
                end
            end

            if (!got_bresp) begin
                $fatal(1, "WRITE response timeout addr=0x%08h id=%0d", addr, axi_id);
            end

            if (b_id !== axi_id) begin
                $fatal(1, "WRITE id mismatch exp=%0d act=%0d", axi_id, b_id);
            end
            if (b_resp !== exp_resp) begin
                $fatal(1, "WRITE resp mismatch addr=0x%08h exp=%0d act=%0d", addr, exp_resp, b_resp);
            end

            @(posedge clk_src);
        end
    endtask

    task automatic do_axi_write_masked(
        input logic [31:0] addr,
        input logic [31:0] data,
        input logic [3:0]  strb,
        input logic [7:0]  id,
        input logic [1:0]  exp_resp
    );
        bit aw_done;
        bit w_done;
        bit got_bresp;
        bit aw_timeout_hit;
        bit w_timeout_hit;
        logic [AXI_BID_WIDTH-1:0] b_id;
        logic [1:0]               b_resp;
        logic [7:0]               axi_id;
        int cycle;
        begin
            aw_done = 1'b0;
            w_done  = 1'b0;
            got_bresp = 1'b0;
            aw_timeout_hit = 1'b0;
            w_timeout_hit  = 1'b0;
            b_id = '0;
            b_resp = '0;
            axi_id = id;

            s_awid    = axi_id;
            s_awaddr  = addr;
            s_awlen   = '0;
            s_awsize  = 3'd2;
            s_awburst = 2'b01;
            s_awvalid = 1'b1;

            s_wdata   = data;
            s_wstrb   = strb;
            s_wlast   = 1'b1;
            s_wvalid  = 1'b1;

            @(negedge clk_src);

            fork
                begin : aw_ctrl
                    fork : aw_wait_or_timeout
                        begin
                            @(posedge clk_src iff s_awready);
                            s_awvalid = 1'b0;
                            aw_done = 1'b1;
                        end
                        begin
                            repeat (SRC_TIMEOUT_CYCLES) @(posedge clk_src);
                            if (!aw_done) begin
                                aw_timeout_hit = 1'b1;
                            end
                        end
                    join_any
                    disable aw_wait_or_timeout;
                end
                begin : w_ctrl
                    fork : w_wait_or_timeout
                        begin
                            @(posedge clk_src iff s_wready);
                            s_wvalid = 1'b0;
                            w_done = 1'b1;
                        end
                        begin
                            repeat (SRC_TIMEOUT_CYCLES) @(posedge clk_src);
                            if (!w_done) begin
                                w_timeout_hit = 1'b1;
                            end
                        end
                    join_any
                    disable w_wait_or_timeout;
                end
            join

            if (!(aw_done && w_done) || aw_timeout_hit || w_timeout_hit) begin
                s_awvalid = 1'b0;
                s_wvalid = 1'b0;
                $fatal(1, "MASKED WRITE handshake timeout addr=0x%08h id=%0d", addr, axi_id);
            end

            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (s_bvalid && s_bready) begin
                    b_id = s_bid;
                    b_resp = s_bresp;
                    got_bresp = 1'b1;
                    break;
                end
            end

            if (!got_bresp) begin
                $fatal(1, "MASKED WRITE response timeout addr=0x%08h id=%0d", addr, axi_id);
            end
            if (b_id !== axi_id) begin
                $fatal(1, "MASKED WRITE id mismatch exp=%0d act=%0d", axi_id, b_id);
            end
            if (b_resp !== exp_resp) begin
                $fatal(1, "MASKED WRITE resp mismatch addr=0x%08h exp=%0d act=%0d", addr, exp_resp, b_resp);
            end

            @(posedge clk_src);
        end
    endtask

    task automatic do_axi_write_skewed(
        input logic [31:0] addr,
        input logic [31:0] data,
        input logic [7:0]  id,
        input logic [1:0]  exp_resp,
        input int unsigned aw_delay_cycles,
        input int unsigned w_delay_cycles
    );
        bit aw_started;
        bit w_started;
        bit aw_done;
        bit w_done;
        bit got_bresp;
        bit aw_timeout_hit;
        bit w_timeout_hit;
        logic [AXI_BID_WIDTH-1:0] b_id;
        logic [1:0]               b_resp;
        logic [7:0]               axi_id;
        int cycle;
        begin
            aw_started = 1'b0;
            w_started  = 1'b0;
            aw_done    = 1'b0;
            w_done     = 1'b0;
            got_bresp  = 1'b0;
            aw_timeout_hit = 1'b0;
            w_timeout_hit  = 1'b0;
            b_id       = '0;
            b_resp     = '0;
            axi_id     = id;

            s_awid    = axi_id;
            s_awaddr  = addr;
            s_awlen   = '0;
            s_awsize  = 3'd2;
            s_awburst = 2'b01;
            s_awvalid = 1'b0;

            s_wdata   = data;
            s_wstrb   = 4'hf;
            s_wlast   = 1'b1;
            s_wvalid  = 1'b0;

            fork
                begin : aw_ctrl
                    fork : aw_wait_or_timeout
                        begin
                            repeat (aw_delay_cycles) @(negedge clk_src);
                            s_awvalid = 1'b1;
                            aw_started = 1'b1;
                            @(posedge clk_src iff s_awready);
                            s_awvalid = 1'b0;
                            aw_done = 1'b1;
                        end
                        begin
                            repeat (SRC_TIMEOUT_CYCLES) @(posedge clk_src);
                            if (!aw_done) begin
                                aw_timeout_hit = 1'b1;
                            end
                        end
                    join_any
                    disable aw_wait_or_timeout;
                end
                begin : w_ctrl
                    fork : w_wait_or_timeout
                        begin
                            repeat (w_delay_cycles) @(negedge clk_src);
                            s_wvalid = 1'b1;
                            w_started = 1'b1;
                            @(posedge clk_src iff s_wready);
                            s_wvalid = 1'b0;
                            w_done = 1'b1;
                        end
                        begin
                            repeat (SRC_TIMEOUT_CYCLES) @(posedge clk_src);
                            if (!w_done) begin
                                w_timeout_hit = 1'b1;
                            end
                        end
                    join_any
                    disable w_wait_or_timeout;
                end
            join

            if (!(aw_done && w_done) || aw_timeout_hit || w_timeout_hit) begin
                s_awvalid = 1'b0;
                s_wvalid = 1'b0;
                $fatal(1, "SKEWED WRITE handshake timeout addr=0x%08h aw_delay=%0d w_delay=%0d", addr, aw_delay_cycles, w_delay_cycles);
            end

            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (s_bvalid && s_bready) begin
                    b_id = s_bid;
                    b_resp = s_bresp;
                    got_bresp = 1'b1;
                    break;
                end
            end

            if (!got_bresp) begin
                $fatal(1, "SKEWED WRITE response timeout addr=0x%08h", addr);
            end
            if (b_id !== axi_id) begin
                $fatal(1, "SKEWED WRITE id mismatch exp=%0d act=%0d", axi_id, b_id);
            end
            if (b_resp !== exp_resp) begin
                $fatal(1, "SKEWED WRITE resp mismatch addr=0x%08h exp=%0d act=%0d", addr, exp_resp, b_resp);
            end

            @(posedge clk_src);
        end
    endtask

    task automatic do_axi_read(
        input  logic [31:0] addr,
        input  logic [7:0]  id,
        input  logic [1:0]  exp_resp,
        input  logic [31:0] exp_data,
        input  bit          check_data
    );
        bit got_rresp;
        logic [AXI_RID_WIDTH-1:0]  r_id;
        logic [AXI_DATA_WIDTH-1:0] r_data;
        logic [1:0]                r_resp;
        logic                      r_last;
        logic [7:0]                axi_id;
        int cycle;
        begin
            got_rresp = 1'b0;
            r_id = '0;
            r_data = '0;
            r_resp = '0;
            r_last = 1'b0;
            axi_id = id;
            @(negedge clk_src);

            s_arid    = axi_id;
            s_araddr  = addr;
            s_arlen   = '0;
            s_arsize  = 3'd2;
            s_arburst = 2'b01;
            s_arvalid = 1'b1;
            @(posedge clk_src);

            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (s_arvalid && s_arready) begin
                    s_arvalid = 1'b0;
                    break;
                end
            end

            if (s_arvalid) begin
                s_arvalid = 1'b0;
                $fatal(1, "READ address handshake timeout addr=0x%08h id=%0d", addr, axi_id);
            end

            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (s_rvalid && s_rready) begin
                    r_id = s_rid;
                    r_data = s_rdata;
                    r_resp = s_rresp;
                    r_last = s_rlast;
                    got_rresp = 1'b1;
                    break;
                end
            end

            if (!got_rresp) begin
                $fatal(1, "READ response timeout addr=0x%08h id=%0d", addr, axi_id);
            end

            if (r_id !== axi_id) begin
                $fatal(1, "READ id mismatch exp=%0d act=%0d", axi_id, r_id);
            end
            if (r_resp !== exp_resp) begin
                $fatal(1, "READ resp mismatch addr=0x%08h exp=%0d act=%0d", addr, exp_resp, r_resp);
            end
            if (!r_last) begin
                $fatal(1, "READ last missing addr=0x%08h id=%0d", addr, axi_id);
            end
            if (check_data && (r_data !== exp_data)) begin
                $fatal(1, "READ data mismatch addr=0x%08h exp=0x%08h act=0x%08h", addr, exp_data, r_data);
            end

            @(posedge clk_src);
        end
    endtask

    task automatic run_smoke();
        begin
            do_axi_write(32'h0000_2000, 32'h0000_2050, 8'd0, 2'b00);
            do_axi_read (32'h0000_2000, 8'd0, 2'b00, 32'h0000_2050, 1'b1);
        end
    endtask

    task automatic run_reset_smoke();
        begin
            repeat (8) @(posedge clk_src);
        end
    endtask

    function automatic logic [31:0] apply_strobe(
        input logic [31:0] original_data,
        input logic [31:0] write_data,
        input logic [3:0]  strobe
    );
        logic [31:0] merged_data;
        begin
            merged_data = original_data;
            if (strobe[0]) merged_data[7:0]   = write_data[7:0];
            if (strobe[1]) merged_data[15:8]  = write_data[15:8];
            if (strobe[2]) merged_data[23:16] = write_data[23:16];
            if (strobe[3]) merged_data[31:24] = write_data[31:24];
            return merged_data;
        end
    endfunction

    task automatic check_regbank_window(
        input logic [31:0] base_addr,
        input logic [31:0] seed,
        input int          id_base
    );
        begin
            do_axi_write(base_addr + 32'h0,  seed | 32'h0000_0001, id_base + 0, 2'b00);
            do_axi_write(base_addr + 32'h4,  seed | 32'h0000_0012, id_base + 1, 2'b00);
            do_axi_write(base_addr + 32'h8,  seed | 32'h0000_0024, id_base + 2, 2'b00);
            do_axi_write(base_addr + 32'hc,  seed | 32'h0000_0048, id_base + 3, 2'b00);
            do_axi_write(base_addr + 32'h10, 32'h0000_0001,        id_base + 4, 2'b00);

            do_axi_read(base_addr + 32'h0,  id_base + 5,  2'b00, seed | 32'h0000_0001, 1'b1);
            do_axi_read(base_addr + 32'h4,  id_base + 6,  2'b00, seed | 32'h0000_0012, 1'b1);
            do_axi_read(base_addr + 32'h8,  id_base + 7,  2'b00, seed | 32'h0000_0024, 1'b1);
            do_axi_read(base_addr + 32'hc,  id_base + 8,  2'b00, seed | 32'h0000_0048, 1'b1);
            do_axi_read(base_addr + 32'h10, id_base + 9,  2'b00, 32'h0000_0001,        1'b1);
            do_axi_read(base_addr + 32'h14, id_base + 10, 2'b00, 32'hFFFF_FFFE,        1'b1);
        end
    endtask

    task automatic check_stub_window(
        input logic [31:0] base_addr,
        input logic [31:0] default_data,
        input logic [31:0] write_data,
        input int          id_base
    );
        begin
            do_axi_read (base_addr, id_base + 0, 2'b00, default_data, 1'b1);
            do_axi_write(base_addr, write_data, id_base + 1, 2'b00);
            do_axi_read (base_addr, id_base + 2, 2'b00, write_data,   1'b1);
        end
    endtask

    task automatic check_regbank_basic(
        input logic [31:0] base_addr,
        input logic [31:0] write_data,
        input int          id_base
    );
        begin
            do_axi_write(base_addr + 32'h0, write_data, id_base + 0, 2'b00);
            do_axi_read (base_addr + 32'h0, id_base + 1, 2'b00, write_data, 1'b1);
            do_axi_read (base_addr + 32'h14, id_base + 2, 2'b00, 32'hFFFF_FFFE, 1'b1);
        end
    endtask

    task automatic run_window_mixed_sequence();
        begin
            check_regbank_window(32'h0000_0000, 32'h1000_0000, 0);
            check_stub_window(32'h0000_1000, 32'hA000_0000, 32'hA0A0_1001, 20);
            check_stub_window(32'h0000_2000, 32'hA100_0000, 32'hA1A1_2002, 24);
            check_stub_window(32'h0000_3000, 32'hA200_0000, 32'hA2A2_3003, 28);
            check_regbank_window(32'h0000_4000, 32'h2000_0000, 40);
            check_stub_window(32'h0000_5000, 32'hB000_0000, 32'hB0B0_5005, 60);
            check_stub_window(32'h0000_6000, 32'hB100_0000, 32'hB1B1_6006, 64);
            check_stub_window(32'h0000_7000, 32'hB200_0000, 32'hB2B2_7007, 68);
            check_regbank_window(32'h0000_8000, 32'h3000_0000, 80);
            check_stub_window(32'h0000_9000, 32'hC000_0000, 32'hC0C0_9009, 100);
            check_stub_window(32'h0000_A000, 32'hC100_0000, 32'hC1C1_A00A, 104);
            check_stub_window(32'h0000_B000, 32'hC200_0000, 32'hC2C2_B00B, 108);
        end
    endtask

    function automatic logic [31:0] get_random_legal_addr(input int index);
        case (index)
            0: return 32'h0000_0000;
            1: return 32'h0000_1000;
            2: return 32'h0000_2000;
            3: return 32'h0000_3000;
            4: return 32'h0000_4000;
            5: return 32'h0000_5000;
            6: return 32'h0000_6000;
            7: return 32'h0000_7000;
            8: return 32'h0000_8000;
            9: return 32'h0000_9000;
            10: return 32'h0000_A000;
            default: return 32'h0000_B000;
        endcase
    endfunction

    function automatic logic [31:0] get_random_legal_default(input int index);
        case (index)
            0: return 32'h0000_0000;
            1: return 32'hA000_0000;
            2: return 32'hA100_0000;
            3: return 32'hA200_0000;
            4: return 32'h0000_0000;
            5: return 32'hB000_0000;
            6: return 32'hB100_0000;
            7: return 32'hB200_0000;
            8: return 32'h0000_0000;
            9: return 32'hC000_0000;
            10: return 32'hC100_0000;
            default: return 32'hC200_0000;
        endcase
    endfunction

    task automatic run_backpressure_rsp();
        begin
            s_bready = 1'b0;
            fork
                begin
                    repeat (12) @(posedge clk_src);
                    s_bready = 1'b1;
                end
                begin
                    do_axi_write(32'h0000_1000, 32'h1234_5678, 8'd140, 2'b00);
                end
            join

            s_rready = 1'b0;
            fork
                begin
                    repeat (12) @(posedge clk_src);
                    s_rready = 1'b1;
                end
                begin
                    do_axi_read(32'h0000_1000, 8'd141, 2'b00, 32'h1234_5678, 1'b1);
                end
            join
        end
    endtask

    task automatic run_debug_timestamp_path();
        begin
            do_axi_write(32'h0000_0010, 32'h0000_0001, 8'd150, 2'b00);
            do_axi_write(32'h0000_4010, 32'h0000_0001, 8'd151, 2'b00);
            do_axi_write(32'h0000_8010, 32'h0000_0001, 8'd152, 2'b00);
            wait_for_sideband_activity();
        end
    endtask

    task automatic run_cti_connectivity();
        begin
            do_axi_write(32'h0000_0010, 32'h0000_0001, 8'd160, 2'b00);
            do_axi_write(32'h0000_4010, 32'h0000_0001, 8'd161, 2'b00);
            do_axi_write(32'h0000_8010, 32'h0000_0001, 8'd162, 2'b00);

            fork
                inject_cti_pulse();
            join_none

            wait_for_cti_activity();
        end
    endtask

    task automatic run_random_addr_constrained();
        logic [31:0] expected_data[0:LEGAL_WINDOW_COUNT-1];
        int hit_count[0:LEGAL_WINDOW_COUNT-1];
        int read_count;
        int write_count;
        int idx;
        int cycle_idx;
        logic [31:0] addr;
        logic [31:0] data;
        begin
            read_count = 0;
            write_count = 0;

            for (idx = 0; idx < LEGAL_WINDOW_COUNT; idx++) begin
                expected_data[idx] = get_random_legal_default(idx);
                hit_count[idx] = 0;
            end

            for (idx = 0; idx < LEGAL_WINDOW_COUNT; idx++) begin
                addr = get_random_legal_addr(idx);
                data = 32'h5000_0000 | idx;
                do_axi_write(addr, data, 8'(170 + idx), 2'b00);
                expected_data[idx] = data;
                hit_count[idx]++;
                write_count++;
            end

            for (idx = 0; idx < LEGAL_WINDOW_COUNT; idx++) begin
                addr = get_random_legal_addr(idx);
                do_axi_read(addr, 8'(190 + idx), 2'b00, expected_data[idx], 1'b1);
                hit_count[idx]++;
                read_count++;
            end

            for (cycle_idx = 0; cycle_idx < 176; cycle_idx++) begin
                idx = $urandom_range(0, LEGAL_WINDOW_COUNT - 1);
                addr = get_random_legal_addr(idx);
                hit_count[idx]++;
                if ((cycle_idx % 2) == 0) begin
                    data = 32'h6000_0000 | cycle_idx;
                    do_axi_write(addr, data, 8'((cycle_idx % 40) + 50), 2'b00);
                    expected_data[idx] = data;
                    write_count++;
                end else begin
                    do_axi_read(addr, 8'((cycle_idx % 40) + 90), 2'b00, expected_data[idx], 1'b1);
                    read_count++;
                end
            end

            for (idx = 0; idx < LEGAL_WINDOW_COUNT; idx++) begin
                if (hit_count[idx] == 0) begin
                    $fatal(1, "RANDOM LEGAL missed window idx=%0d", idx);
                end
            end
            if (read_count < 50) begin
                $fatal(1, "RANDOM LEGAL insufficient reads count=%0d", read_count);
            end
            if (write_count < 50) begin
                $fatal(1, "RANDOM LEGAL insufficient writes count=%0d", write_count);
            end
        end
    endtask

    task automatic run_random_illegal_addr();
        logic [31:0] addr;
        logic [31:0] data;
        int idx;
        begin
            for (idx = 0; idx < 100; idx++) begin
                addr = 32'h0000_C000 + ({18'h0, $urandom} & 32'h0000_3FFC);
                data = 32'h7000_0000 | idx;
                if ((idx % 2) == 0) begin
                    do_axi_write(addr, data, 8'((idx % 40) + 10), 2'b11);
                end else begin
                    do_axi_read(addr, 8'((idx % 40) + 60), 2'b11, 32'h0000_0000, 1'b0);
                end
            end
        end
    endtask

    task automatic run_reset_during_idle();
        begin
            repeat (10) @(posedge clk_src);
            reset_dut();
            run_smoke();
        end
    endtask

    task automatic wait_for_sideband_activity();
        int cycle;
        begin
            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (saw_dbg_data_out_0 && saw_dbg_data_out_1 && saw_dbg_data_out_2 &&
                    saw_dbg_timestamp_out_0 && saw_dbg_timestamp_out_1 && saw_dbg_timestamp_out_2) begin
                    return;
                end
            end

            $fatal(1, "SIDEBAND activity timeout");
        end
    endtask

    task automatic inject_cti_pulse();
        begin
            repeat (8) @(posedge clk_src);
            sys_cti_event_in   <= '1;
            sys_cti_channel_in <= '1;
            repeat (4) @(posedge clk_src);
            sys_cti_event_in   <= '0;
            sys_cti_channel_in <= '0;
        end
    endtask

    task automatic wait_for_cti_activity();
        int cycle;
        begin
            for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_src);
                if (saw_sys_cti_event_out && saw_sys_cti_channel_out) begin
                    return;
                end
            end

            $fatal(1, "CTI activity timeout");
        end
    endtask

    task automatic run_addr_map();
        begin
            run_window_mixed_sequence();
        end
    endtask

    task automatic run_decerr();
        begin
            do_axi_write(32'h0000_C000, 32'hDEAD_BEEF, 8'd100, 2'b11);
            do_axi_read (32'h0000_C000, 8'd101, 2'b11, 32'h0000_0000, 1'b0);
        end
    endtask

    task automatic run_masked_write();
        logic [31:0] expected_data;
        begin
            expected_data = apply_strobe(32'hA000_0000, 32'h1122_3344, 4'b0101);
            do_axi_write_masked(32'h0000_1000, 32'h1122_3344, 4'b0101, 8'd110, 2'b00);
            do_axi_read(32'h0000_1000, 8'd111, 2'b00, expected_data, 1'b1);

            expected_data = apply_strobe(32'hB100_0000, 32'h5566_7788, 4'b1010);
            do_axi_write_masked(32'h0000_6000, 32'h5566_7788, 4'b1010, 8'd112, 2'b00);
            do_axi_read(32'h0000_6000, 8'd113, 2'b00, expected_data, 1'b1);
        end
    endtask

    task automatic run_stub_slverr();
        begin
            do_axi_write(32'h0000_1100, 32'hCAFE_BA11, 8'd120, 2'b10);
            do_axi_read (32'h0000_1100, 8'd121, 2'b10, 32'hDEAD_BEEF, 1'b1);
            do_axi_write(32'h0000_5100, 32'hCAFE_BA51, 8'd122, 2'b10);
            do_axi_read (32'h0000_5100, 8'd123, 2'b10, 32'hDEAD_BEEF, 1'b1);
            do_axi_write(32'h0000_A100, 32'hCAFE_BAA1, 8'd124, 2'b10);
            do_axi_read (32'h0000_A100, 8'd125, 2'b10, 32'hDEAD_BEEF, 1'b1);
        end
    endtask

    task automatic run_aw_w_skewed_arrival();
        begin
            do_axi_write_skewed(32'h0000_1000, 32'h1357_2468, 8'd180, 2'b00, 0, 6);
            do_axi_read        (32'h0000_1000, 8'd181, 2'b00, 32'h1357_2468, 1'b1);

            do_axi_write_skewed(32'h0000_5000, 32'h2468_1357, 8'd182, 2'b00, 6, 0);
            do_axi_read        (32'h0000_5000, 8'd183, 2'b00, 32'h2468_1357, 1'b1);

            do_axi_write_skewed(32'h0000_9000, 32'h55AA_33CC, 8'd184, 2'b00, 2, 9);
            do_axi_read        (32'h0000_9000, 8'd185, 2'b00, 32'h55AA_33CC, 1'b1);
        end
    endtask

    task automatic run_apb_waitstate_backpressure();
        begin
            set_apb_stall_cycles(3);

            s_bready = 1'b0;
            fork
                begin
                    repeat (10) @(posedge clk_src);
                    s_bready = 1'b1;
                end
                begin
                    do_axi_write(32'h0000_1000, 32'hFACE_1001, 8'd190, 2'b00);
                end
            join

            s_rready = 1'b0;
            fork
                begin
                    repeat (10) @(posedge clk_src);
                    s_rready = 1'b1;
                end
                begin
                    do_axi_read(32'h0000_1000, 8'd191, 2'b00, 32'hFACE_1001, 1'b1);
                end
            join

            do_axi_write(32'h0000_5000, 32'hFACE_5005, 8'd192, 2'b00);
            do_axi_read (32'h0000_5000, 8'd193, 2'b00, 32'hFACE_5005, 1'b1);

            set_apb_stall_cycles(0);
        end
    endtask

    task automatic run_sideband();
        begin
            wait_for_sideband_activity();
        end
    endtask

    task automatic run_cov_boost();
        begin
            run_addr_map();
            run_decerr();
            run_masked_write();
            run_stub_slverr();
            run_debug_timestamp_path();
            run_cti_connectivity();
        end
    endtask

    task automatic run_tc002_regbank_rw_tniu0();
        begin
            check_regbank_basic(32'h0000_0000, 32'h1000_0001, 0);
        end
    endtask

    task automatic run_tc003_rsc_rw_tniu0();
        begin
            check_stub_window(32'h0000_1000, 32'hA000_0000, 32'hA0A0_1001, 10);
        end
    endtask

    task automatic run_tc004_regbank_rw_tniu1();
        begin
            check_regbank_basic(32'h0000_4000, 32'h2000_0001, 20);
        end
    endtask

    task automatic run_tc005_rsc_rw_tniu1();
        begin
            check_stub_window(32'h0000_5000, 32'hB000_0000, 32'hB0B0_5005, 30);
        end
    endtask

    task automatic run_tc006_regbank_rw_tniu2();
        begin
            check_regbank_basic(32'h0000_8000, 32'h3000_0001, 40);
        end
    endtask

    task automatic run_tc007_rsc_rw_tniu2();
        begin
            check_stub_window(32'h0000_9000, 32'hC000_0000, 32'hC0C0_9009, 50);
        end
    endtask

    task automatic run_tc008_decode_miss();
        begin
            run_decerr();
        end
    endtask

    task automatic run_tc009_mixed_read_write();
        begin
            run_addr_map();
        end
    endtask

    task automatic run_tc010_backpressure_rsp();
        begin
            run_backpressure_rsp();
        end
    endtask

    task automatic run_tc011_cti_connectivity();
        begin
            run_cti_connectivity();
        end
    endtask

    task automatic run_tc012_debug_timestamp_path();
        begin
            run_debug_timestamp_path();
        end
    endtask

    task automatic run_tc013_random_addr_constrained();
        begin
            run_random_addr_constrained();
        end
    endtask

    task automatic run_tc014_random_illegal_addr();
        begin
            run_random_illegal_addr();
        end
    endtask

    task automatic run_tc015_reset_during_idle();
        begin
            run_reset_during_idle();
        end
    endtask

    task automatic run_tc016_apb_local_slverr_mapped_window();
        begin
            run_stub_slverr();
        end
    endtask

    task automatic run_tc017_aw_w_skewed_arrival();
        begin
            run_aw_w_skewed_arrival();
        end
    endtask

    task automatic run_tc018_apb_waitstate_backpressure();
        begin
            run_apb_waitstate_backpressure();
        end
    endtask

    // ======================================================================
    // NEW TESTS tc019-tc028: Coverage Gap Closure
    // ======================================================================

    // ------------------------------------------------------------------
    // tc019: Toggle Data Patterns
    // Target: Toggle wdata/rdata/pwdata/prdata across all 3 TNIUs.
    // Writes 10 complementary patterns + walking-1/0 to 9 stub windows.
    // ------------------------------------------------------------------
    task automatic run_tc019_toggle_data_patterns();
        logic [31:0] data;
        logic [7:0]  tid;
        int p, w, b;
        logic [31:0] stub_base [0:8];
        begin
            stub_base[0] = 32'h0000_1000; stub_base[1] = 32'h0000_2000;
            stub_base[2] = 32'h0000_3000; stub_base[3] = 32'h0000_5000;
            stub_base[4] = 32'h0000_6000; stub_base[5] = 32'h0000_7000;
            stub_base[6] = 32'h0000_9000; stub_base[7] = 32'h0000_A000;
            stub_base[8] = 32'h0000_B000;
            // Phase 1: 10 complementary patterns to all 9 stub windows
            for (w = 0; w < 9; w++) begin
                for (p = 0; p < 10; p++) begin
                    case (p)
                        0: data = 32'h0000_0000; 1: data = 32'hFFFF_FFFF;
                        2: data = 32'h5555_5555; 3: data = 32'hAAAA_AAAA;
                        4: data = 32'h0F0F_0F0F; 5: data = 32'hF0F0_F0F0;
                        6: data = 32'h00FF_00FF; 7: data = 32'hFF00_FF00;
                        8: data = 32'h3333_3333; default: data = 32'hCCCC_CCCC;
                    endcase
                    tid = w * 10 + p;
                    do_axi_write(stub_base[w], data, tid, 2'b00);
                end
            end
            // Phase 2: Walking-1 on TNIU0 resource
            for (b = 0; b < 32; b++) begin
                tid = b;
                do_axi_write(32'h0000_1000, 32'h1 << b, tid, 2'b00);
            end
            // Phase 3: Walking-0 on TNIU1 resource
            for (b = 0; b < 32; b++) begin
                tid = b;
                do_axi_write(32'h0000_5000, ~(32'h1 << b), tid, 2'b00);
            end
            // Phase 4: Walking-1 on TNIU2 resource
            for (b = 0; b < 32; b++) begin
                tid = b + 32;
                do_axi_write(32'h0000_9000, 32'h1 << b, tid, 2'b00);
            end
            // Phase 5: Read from every window (toggle rdata path)
            for (w = 0; w < 9; w++)
                do_axi_read(stub_base[w], 8'd0, 2'b00, 32'h0, 1'b0);
        end
    endtask

    // ------------------------------------------------------------------
    // tc020: Toggle AXI ID, node_id, and Control Signals
    // Target: Toggle on awid/bid, node_id, awcache/prot/qos/user/lock.
    // ------------------------------------------------------------------
    task automatic run_tc020_toggle_id_ctrl();
        logic [7:0] tid;
        int i;
        begin
            // Phase 1: Diverse write IDs across all TNIUs
            do_axi_write(32'h0000_2000, 32'hACE0_0001, 8'h00, 2'b00);
            do_axi_write(32'h0000_2000, 32'hACE0_0002, 8'hFF, 2'b00);
            do_axi_write(32'h0000_6000, 32'hACE0_0003, 8'h55, 2'b00);
            do_axi_write(32'h0000_6000, 32'hACE0_0004, 8'hAA, 2'b00);
            do_axi_write(32'h0000_A000, 32'hACE0_0005, 8'h0F, 2'b00);
            do_axi_write(32'h0000_A000, 32'hACE0_0006, 8'hF0, 2'b00);
            do_axi_write(32'h0000_2000, 32'hACE0_0007, 8'h33, 2'b00);
            do_axi_write(32'h0000_6000, 32'hACE0_0008, 8'hCC, 2'b00);
            // Phase 2: Walking-1 on ID bits
            for (i = 0; i < 8; i++) begin
                tid = 8'h1 << i;
                do_axi_write(32'h0000_2000, 32'h1D00_0000 | i, tid, 2'b00);
            end
            // Phase 3: Toggle node_id with diverse patterns
            node_id = 8'h00;
            do_axi_write(32'h0000_2000, 32'hD0DE_0001, 8'd1, 2'b00);
            node_id = 8'hFF;
            do_axi_write(32'h0000_6000, 32'hD0DE_0002, 8'd2, 2'b00);
            node_id = 8'h55;
            do_axi_write(32'h0000_A000, 32'hD0DE_0003, 8'd3, 2'b00);
            node_id = 8'hAA;
            do_axi_write(32'h0000_2000, 32'hD0DE_0004, 8'd4, 2'b00);
            node_id = 8'h0F;
            do_axi_write(32'h0000_6000, 32'hD0DE_0005, 8'd5, 2'b00);
            node_id = 8'hF0;
            do_axi_write(32'h0000_A000, 32'hD0DE_0006, 8'd6, 2'b00);
            node_id = 8'h01; // restore default
            // Phase 4: Idle AXI control signal toggle (toggling counts for toggle cov)
            s_awlock  = 1'b1; @(posedge clk_src); s_awlock  = 1'b0;
            s_awcache = 4'hF; @(posedge clk_src); s_awcache = 4'h5;
            @(posedge clk_src); s_awcache = 4'hA;
            @(posedge clk_src); s_awcache = 4'h0;
            s_awprot  = 3'h7; @(posedge clk_src); s_awprot  = 3'h0;
            s_awqos   = 4'hF; @(posedge clk_src); s_awqos   = 4'h5;
            @(posedge clk_src); s_awqos   = 4'hA;
            @(posedge clk_src); s_awqos   = 4'h0;
            s_awuser  = '1;   @(posedge clk_src); s_awuser  = '0;
            s_arlock  = 1'b1; @(posedge clk_src); s_arlock  = 1'b0;
            s_arcache = 4'hF; @(posedge clk_src); s_arcache = 4'h5;
            @(posedge clk_src); s_arcache = 4'hA;
            @(posedge clk_src); s_arcache = 4'h0;
            s_arprot  = 3'h7; @(posedge clk_src); s_arprot  = 3'h0;
            s_arqos   = 4'hF; @(posedge clk_src); s_arqos   = 4'h5;
            @(posedge clk_src); s_arqos   = 4'hA;
            @(posedge clk_src); s_arqos   = 4'h0;
            s_aruser  = '1;   @(posedge clk_src); s_aruser  = '0;
        end
    endtask

    // ------------------------------------------------------------------
    // tc021: CTI Bit-Walking
    // Target: CTI handler line/branch/toggle (73.55% line, 70.37% branch).
    // Exercises all 8 bits of event/channel with walking patterns.
    // ------------------------------------------------------------------
    task automatic run_tc021_cti_bitwalking();
        int b;
        begin
            // Enable debug on all 3 TNIUs
            do_axi_write(32'h0000_0010, 32'h0000_0001, 8'd0, 2'b00);
            do_axi_write(32'h0000_4010, 32'h0000_0001, 8'd1, 2'b00);
            do_axi_write(32'h0000_8010, 32'h0000_0001, 8'd2, 2'b00);
            // Walking-1 on event
            for (b = 0; b < 8; b++) begin
                sys_cti_event_in = 8'h1 << b;
                repeat (4) @(posedge clk_src);
                sys_cti_event_in = 8'h0;
                repeat (4) @(posedge clk_src);
            end
            // Walking-1 on channel
            for (b = 0; b < 8; b++) begin
                sys_cti_channel_in = 8'h1 << b;
                repeat (4) @(posedge clk_src);
                sys_cti_channel_in = 8'h0;
                repeat (4) @(posedge clk_src);
            end
            // Walking-0 on event
            for (b = 0; b < 8; b++) begin
                sys_cti_event_in = ~(8'h1 << b);
                repeat (4) @(posedge clk_src);
                sys_cti_event_in = 8'h0;
                repeat (4) @(posedge clk_src);
            end
            // Walking-0 on channel
            for (b = 0; b < 8; b++) begin
                sys_cti_channel_in = ~(8'h1 << b);
                repeat (4) @(posedge clk_src);
                sys_cti_channel_in = 8'h0;
                repeat (4) @(posedge clk_src);
            end
            // Complementary patterns
            sys_cti_event_in   = 8'h55; sys_cti_channel_in = 8'hAA;
            repeat (6) @(posedge clk_src);
            sys_cti_event_in   = 8'hAA; sys_cti_channel_in = 8'h55;
            repeat (6) @(posedge clk_src);
            sys_cti_event_in   = 8'hFF; sys_cti_channel_in = 8'hFF;
            repeat (6) @(posedge clk_src);
            sys_cti_event_in   = 8'h0F; sys_cti_channel_in = 8'hF0;
            repeat (6) @(posedge clk_src);
            sys_cti_event_in   = 8'hF0; sys_cti_channel_in = 8'h0F;
            repeat (6) @(posedge clk_src);
            sys_cti_event_in   = 8'h00; sys_cti_channel_in = 8'h00;
            // Wait for CDC propagation
            repeat (60) @(posedge clk_src);
        end
    endtask

    // ------------------------------------------------------------------
    // tc022: Simultaneous Read+Write Arbitration
    // Target: req_arb condition coverage (age-matrix arbiter contention).
    // Forked write+read use separate AXI channels to stress the arbiter.
    // ------------------------------------------------------------------
    task automatic run_tc022_simultaneous_rd_wr();
        int i;
        begin
            // Seed data so reads return content
            do_axi_write(32'h0000_2000, 32'hBEEF_0001, 8'd10, 2'b00);
            do_axi_write(32'h0000_6000, 32'hBEEF_0002, 8'd11, 2'b00);
            do_axi_write(32'h0000_A000, 32'hBEEF_0003, 8'd12, 2'b00);
            // Concurrent write+read across different TNIUs
            for (i = 0; i < 6; i++) begin
                fork
                    do_axi_write(32'h0000_2000, 32'hCA00_0000 | i, 8'(20+i), 2'b00);
                    do_axi_read(32'h0000_6000, 8'd0, 2'b00, 32'h0, 1'b0);
                join
                fork
                    do_axi_read(32'h0000_A000, 8'd0, 2'b00, 32'h0, 1'b0);
                    do_axi_write(32'h0000_6000, 32'hCB00_0000 | i, 8'(30+i), 2'b00);
                join
            end
        end
    endtask

    // ------------------------------------------------------------------
    // tc023: Register Bank Full Toggle
    // Target: Regbank toggle (40.80%), register decode conditions.
    // Writes 6 diverse patterns + walking-1 to all regbank offsets on all TNIUs.
    // ------------------------------------------------------------------
    task automatic run_tc023_regbank_full_toggle();
        logic [31:0] data;
        logic [7:0]  tid;
        logic [31:0] rb_base [0:2];
        int t, p, r;
        begin
            rb_base[0] = 32'h0000_0000;
            rb_base[1] = 32'h0000_4000;
            rb_base[2] = 32'h0000_8000;
            for (t = 0; t < 3; t++) begin
                // 6 diverse patterns to offsets 0x0, 0x4, 0x8, 0xC, 0x10
                for (p = 0; p < 6; p++) begin
                    case (p)
                        0: data = 32'h0000_0000; 1: data = 32'hFFFF_FFFF;
                        2: data = 32'h5555_5555; 3: data = 32'hAAAA_AAAA;
                        4: data = 32'h0F0F_0F0F; default: data = 32'hF0F0_F0F0;
                    endcase
                    for (r = 0; r < 5; r++) begin
                        tid = t * 30 + p * 5 + r;
                        do_axi_write(rb_base[t] + (r * 4), data, tid, 2'b00);
                    end
                end
                // Walking-1 on first register
                for (r = 0; r < 32; r++) begin
                    tid = 100 + t;
                    do_axi_write(rb_base[t], 32'h1 << r, tid, 2'b00);
                end
                // Read all 5 registers
                for (r = 0; r < 5; r++)
                    do_axi_read(rb_base[t] + (r * 4), 8'd0, 2'b00, 32'h0, 1'b0);
            end
        end
    endtask

    // ------------------------------------------------------------------
    // tc024: APB Stall Sweep
    // Target: FSM ACCESS->ACCESS self-loop, APB wait-state conditions.
    // Sweeps stall_cycles 0-5 with transactions to all 3 TNIUs.
    // ------------------------------------------------------------------
    task automatic run_tc024_apb_stall_sweep();
        int stall;
        begin
            for (stall = 0; stall <= 5; stall++) begin
                set_apb_stall_cycles(stall);
                do_axi_write(32'h0000_2000, 32'h5A00_0000 | stall, 8'(stall), 2'b00);
                do_axi_read (32'h0000_2000, 8'd0, 2'b00, 32'h0, 1'b0);
                do_axi_write(32'h0000_6000, 32'h5B00_0000 | stall, 8'(stall+10), 2'b00);
                do_axi_read (32'h0000_6000, 8'd0, 2'b00, 32'h0, 1'b0);
                do_axi_write(32'h0000_A000, 32'h5C00_0000 | stall, 8'(stall+20), 2'b00);
                do_axi_read (32'h0000_A000, 8'd0, 2'b00, 32'h0, 1'b0);
            end
            set_apb_stall_cycles(0);
        end
    endtask

    // ------------------------------------------------------------------
    // tc025: Strobe Pattern Walk
    // Target: wstrb toggle, write channel condition coverage.
    // All 16 strobe combinations on all 3 TNIUs.
    // ------------------------------------------------------------------
    task automatic run_tc025_strobe_walk();
        logic [7:0]  tid;
        logic [3:0]  strb;
        int s;
        begin
            for (s = 0; s < 16; s++) begin
                tid  = s;
                strb = s[3:0];
                do_axi_write_masked(32'h0000_2000, 32'hFF00_FF00 | s, strb, tid, 2'b00);
            end
            for (s = 0; s < 16; s++) begin
                tid  = s + 16;
                strb = s[3:0];
                do_axi_write_masked(32'h0000_6000, 32'h00FF_00FF | (s << 8), strb, tid, 2'b00);
            end
            for (s = 0; s < 16; s++) begin
                tid  = s + 32;
                strb = s[3:0];
                do_axi_write_masked(32'h0000_A000, 32'hA5A5_A5A5, strb, tid, 2'b00);
            end
            do_axi_read(32'h0000_2000, 8'd0, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_6000, 8'd0, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_A000, 8'd0, 2'b00, 32'h0, 1'b0);
        end
    endtask

    // ------------------------------------------------------------------
    // tc026: Backpressure Pattern
    // Target: Response buffer toggle/condition, bready/rready toggling.
    // Rapid bready/rready toggle during transactions to each TNIU.
    // ------------------------------------------------------------------
    task automatic run_tc026_backpressure_pattern();
        int i;
        begin
            // Rapid bready toggle during writes
            for (i = 0; i < 3; i++) begin
                fork
                    begin
                        repeat (3) @(posedge clk_src);
                        s_bready = 1'b0;
                        repeat (2) @(posedge clk_src);
                        s_bready = 1'b1;
                        repeat (3) @(posedge clk_src);
                        s_bready = 1'b0;
                        repeat (1) @(posedge clk_src);
                        s_bready = 1'b1;
                    end
                    do_axi_write(32'h0000_2000 + (i * 32'h4000),
                                 32'hBA00_0000 | i, 8'(i), 2'b00);
                join
            end
            // Rapid rready toggle during reads
            for (i = 0; i < 3; i++) begin
                fork
                    begin
                        repeat (5) @(posedge clk_src);
                        s_rready = 1'b0;
                        repeat (3) @(posedge clk_src);
                        s_rready = 1'b1;
                        repeat (2) @(posedge clk_src);
                        s_rready = 1'b0;
                        repeat (1) @(posedge clk_src);
                        s_rready = 1'b1;
                    end
                    do_axi_read(32'h0000_2000 + (i * 32'h4000),
                                8'd0, 2'b00, 32'h0, 1'b0);
                join
            end
            s_bready = 1'b1;
            s_rready = 1'b1;
        end
    endtask

    // ------------------------------------------------------------------
    // tc027: Address Offset Sweep
    // Target: Address bit toggle (bits 2-11 via offsets, bits 12-31 via DECERR).
    // ------------------------------------------------------------------
    task automatic run_tc027_addr_offset_sweep();
        logic [7:0] tid;
        int b;
        begin
            // Offset walk within TNIU0 sys APB M0 window (bits 2-7)
            do_axi_write(32'h0000_2000, 32'hADD0_0000, 8'd0,  2'b00);
            do_axi_write(32'h0000_2004, 32'hADD0_0004, 8'd1,  2'b00);
            do_axi_write(32'h0000_2008, 32'hADD0_0008, 8'd2,  2'b00);
            do_axi_write(32'h0000_200C, 32'hADD0_000C, 8'd3,  2'b00);
            do_axi_write(32'h0000_2010, 32'hADD0_0010, 8'd4,  2'b00);
            do_axi_write(32'h0000_2020, 32'hADD0_0020, 8'd5,  2'b00);
            do_axi_write(32'h0000_2040, 32'hADD0_0040, 8'd6,  2'b10);
            do_axi_write(32'h0000_2080, 32'hADD0_0080, 8'd7,  2'b10);
            // Offset walk within TNIU1 sys APB M0 window
            do_axi_write(32'h0000_6000, 32'hADD1_0000, 8'd10, 2'b00);
            do_axi_write(32'h0000_6004, 32'hADD1_0004, 8'd11, 2'b00);
            do_axi_write(32'h0000_6008, 32'hADD1_0008, 8'd12, 2'b00);
            do_axi_write(32'h0000_600C, 32'hADD1_000C, 8'd13, 2'b00);
            do_axi_write(32'h0000_6010, 32'hADD1_0010, 8'd14, 2'b00);
            do_axi_write(32'h0000_6020, 32'hADD1_0020, 8'd15, 2'b00);
            do_axi_write(32'h0000_6040, 32'hADD1_0040, 8'd16, 2'b10);
            do_axi_write(32'h0000_6080, 32'hADD1_0080, 8'd17, 2'b10);
            // High address bits via DECERR path (bits 12-31)
            for (b = 2; b < 32; b++) begin
                tid = b;
                do_axi_write(32'h0000_C000 | (32'h1 << b),
                             32'hDEC0_0000 | b, tid, 2'b11);
            end
            // Read at offsets
            do_axi_read(32'h0000_2004, 8'd0, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_6004, 8'd0, 2'b00, 32'h0, 1'b0);
        end
    endtask

    // ------------------------------------------------------------------
    // tc028: DECERR Path Data Toggle
    // Target: INIU decode-error path data/ID toggle.
    // Diverse data patterns and IDs sent to out-of-range addresses.
    // ------------------------------------------------------------------
    task automatic run_tc028_decerr_data_toggle();
        logic [31:0] data;
        logic [7:0]  tid;
        int p, b;
        begin
            // 10 complementary patterns on DECERR writes
            for (p = 0; p < 10; p++) begin
                case (p)
                    0: data = 32'h0000_0000; 1: data = 32'hFFFF_FFFF;
                    2: data = 32'h5555_5555; 3: data = 32'hAAAA_AAAA;
                    4: data = 32'h0F0F_0F0F; 5: data = 32'hF0F0_F0F0;
                    6: data = 32'h00FF_00FF; 7: data = 32'hFF00_FF00;
                    8: data = 32'h3333_3333; default: data = 32'hCCCC_CCCC;
                endcase
                tid = p;
                do_axi_write(32'h0000_C000, data, tid, 2'b11);
            end
            // Walking-1 on DECERR write data
            for (b = 0; b < 32; b++) begin
                tid = b + 10;
                do_axi_write(32'h0000_C000, 32'h1 << b, tid, 2'b11);
            end
            // Diverse IDs on DECERR writes
            do_axi_write(32'h0000_D000, 32'hDEAD_0001, 8'h55, 2'b11);
            do_axi_write(32'h0000_E000, 32'hDEAD_0002, 8'hAA, 2'b11);
            do_axi_write(32'h0000_F000, 32'hDEAD_0003, 8'hFF, 2'b11);
            // DECERR reads
            for (p = 0; p < 8; p++) begin
                tid = p + 50;
                do_axi_read(32'h0000_C000 + (p * 32'h100), tid, 2'b11, 32'h0, 1'b0);
            end
        end
    endtask

    // ======================================================================
    // NEW TESTS tc029-tc034: Deep Coverage Gap Closure (Round 2)
    // ======================================================================

    // ------------------------------------------------------------------
    // tc029: AXI Sideband Toggle
    // Target: Toggle len, burst, lock, cache, qos, prot, user fields.
    // Uses single-beat writes/reads but with varied sideband values.
    // ------------------------------------------------------------------
    task automatic run_tc029_axi_sideband_toggle();
        logic [7:0] tid;
        int i;
        begin
            // Phase 1: Write with varied sideband fields to stub window (TNIU0 sys M0)
            // awlen is always 0 per INIU protocol constraint (single-beat only);
            // other sideband fields are toggled for coverage.
            s_awlen   = 8'h00;  s_awsize  = 3'd2; s_awburst = 2'b01;
            s_awlock  = 1'b1;   s_awcache = 4'hF; s_awqos   = 4'hF;
            s_awprot  = 3'h7;   s_awuser  = 8'hFF;
            s_awid    = 8'hAA;  s_awaddr  = 32'h0000_2000;
            s_wdata   = 32'hCAFE_BEEF; s_wstrb = 4'hF; s_wlast = 1'b1;
            s_awvalid = 1'b1;   s_wvalid  = 1'b1;
            @(negedge clk_src);
            fork
                begin @(posedge clk_src iff s_awready); s_awvalid = 1'b0; end
                begin @(posedge clk_src iff s_wready);  s_wvalid  = 1'b0; end
            join
            @(posedge clk_src iff (s_bvalid && s_bready));
            @(posedge clk_src);

            // burst=FIXED, lock=0, cache=0xA, qos=0x5
            s_awlen   = 8'h00;  s_awsize  = 3'd1; s_awburst = 2'b00;
            s_awlock  = 1'b0;   s_awcache = 4'hA; s_awqos   = 4'h5;
            s_awprot  = 3'h5;   s_awuser  = 8'hAA;
            s_awid    = 8'h55;  s_awaddr  = 32'h0000_2004;
            s_wdata   = 32'h1234_5678; s_wstrb = 4'hF; s_wlast = 1'b1;
            s_awvalid = 1'b1;   s_wvalid  = 1'b1;
            @(negedge clk_src);
            fork
                begin @(posedge clk_src iff s_awready); s_awvalid = 1'b0; end
                begin @(posedge clk_src iff s_wready);  s_wvalid  = 1'b0; end
            join
            @(posedge clk_src iff (s_bvalid && s_bready));
            @(posedge clk_src);

            // burst=WRAP, size=3'd0
            s_awlen   = 8'h00;  s_awsize  = 3'd0; s_awburst = 2'b10;
            s_awlock  = 1'b1;   s_awcache = 4'h5; s_awqos   = 4'hA;
            s_awprot  = 3'h2;   s_awuser  = 8'h55;
            s_awid    = 8'hFF;  s_awaddr  = 32'h0000_2008;
            s_wdata   = 32'hDEAD_FACE; s_wstrb = 4'hF; s_wlast = 1'b1;
            s_awvalid = 1'b1;   s_wvalid  = 1'b1;
            @(negedge clk_src);
            fork
                begin @(posedge clk_src iff s_awready); s_awvalid = 1'b0; end
                begin @(posedge clk_src iff s_wready);  s_wvalid  = 1'b0; end
            join
            @(posedge clk_src iff (s_bvalid && s_bready));
            @(posedge clk_src);

            // burst=2'b11 (reserved)
            s_awlen   = 8'h00;  s_awsize  = 3'd3; s_awburst = 2'b11;
            s_awlock  = 1'b0;   s_awcache = 4'h0; s_awqos   = 4'h0;
            s_awprot  = 3'h0;   s_awuser  = 8'h00;
            s_awid    = 8'h00;  s_awaddr  = 32'h0000_200C;
            s_wdata   = 32'h0000_0000; s_wstrb = 4'hF; s_wlast = 1'b1;
            s_awvalid = 1'b1;   s_wvalid  = 1'b1;
            @(negedge clk_src);
            fork
                begin @(posedge clk_src iff s_awready); s_awvalid = 1'b0; end
                begin @(posedge clk_src iff s_wready);  s_wvalid  = 1'b0; end
            join
            @(posedge clk_src iff (s_bvalid && s_bready));
            @(posedge clk_src);

            // Phase 2: Read with varied sideband fields (arlen always 0)
            s_arlen   = 8'h00;  s_arsize  = 3'd2; s_arburst = 2'b01;
            s_arlock  = 1'b1;   s_arcache = 4'hF; s_arqos   = 4'hF;
            s_arprot  = 3'h7;   s_aruser  = 8'hFF;
            s_arid    = 8'hAA;  s_araddr  = 32'h0000_2000;
            s_arvalid = 1'b1;
            @(negedge clk_src);
            @(posedge clk_src iff s_arready); s_arvalid = 1'b0;
            @(posedge clk_src iff (s_rvalid && s_rready));
            @(posedge clk_src);

            s_arlen   = 8'h00;  s_arsize  = 3'd1; s_arburst = 2'b00;
            s_arlock  = 1'b0;   s_arcache = 4'hA; s_arqos   = 4'h5;
            s_arprot  = 3'h5;   s_aruser  = 8'hAA;
            s_arid    = 8'h55;  s_araddr  = 32'h0000_2004;
            s_arvalid = 1'b1;
            @(negedge clk_src);
            @(posedge clk_src iff s_arready); s_arvalid = 1'b0;
            @(posedge clk_src iff (s_rvalid && s_rready));
            @(posedge clk_src);

            s_arlen   = 8'h00;  s_arsize  = 3'd0; s_arburst = 2'b10;
            s_arlock  = 1'b1;   s_arcache = 4'h5; s_arqos   = 4'hA;
            s_arprot  = 3'h2;   s_aruser  = 8'h55;
            s_arid    = 8'hFF;  s_araddr  = 32'h0000_2008;
            s_arvalid = 1'b1;
            @(negedge clk_src);
            @(posedge clk_src iff s_arready); s_arvalid = 1'b0;
            @(posedge clk_src iff (s_rvalid && s_rready));
            @(posedge clk_src);

            // Restore defaults
            s_awlen = '0; s_awsize = 3'd2; s_awburst = 2'b01; s_awlock = 1'b0;
            s_awcache = '0; s_awqos = '0; s_awprot = '0; s_awuser = '0;
            s_arlen = '0; s_arsize = 3'd2; s_arburst = 2'b01; s_arlock = 1'b0;
            s_arcache = '0; s_arqos = '0; s_arprot = '0; s_aruser = '0;
        end
    endtask

    // ------------------------------------------------------------------
    // tc030: Upper Address Bit Toggle
    // Target: Toggle addr[31:16] through decode-error path.
    // ------------------------------------------------------------------
    task automatic run_tc030_upper_addr_toggle();
        int b;
        logic [7:0] tid;
        begin
            // Walking-1 on upper address bits via DECERR
            for (b = 16; b < 32; b++) begin
                tid = b;
                do_axi_write(32'h0000_C000 | (32'h1 << b),
                             32'hABCD_0000 | b, tid, 2'b11);
            end
            // Walking-0 on upper address bits
            for (b = 16; b < 32; b++) begin
                tid = b + 16;
                do_axi_write(32'hFFFF_C000 & ~(32'h1 << b),
                             32'hDCBA_0000 | b, tid, 2'b11);
            end
            // Read with upper bits
            for (b = 16; b < 32; b++) begin
                tid = b + 32;
                do_axi_read(32'h0000_C000 | (32'h1 << b), tid, 2'b11, 32'h0, 1'b0);
            end
        end
    endtask

    // ------------------------------------------------------------------
    // tc031: Stub Slave Full Offset Toggle
    // Target: Write+read all 16 valid offsets (0x00-0x3C) per stub.
    // ------------------------------------------------------------------
    task automatic run_tc031_stub_full_offset();
        int w, off;
        logic [31:0] stub_base [0:8];
        logic [7:0] tid;
        begin
            stub_base[0] = 32'h0000_1000; stub_base[1] = 32'h0000_2000;
            stub_base[2] = 32'h0000_3000; stub_base[3] = 32'h0000_5000;
            stub_base[4] = 32'h0000_6000; stub_base[5] = 32'h0000_7000;
            stub_base[6] = 32'h0000_9000; stub_base[7] = 32'h0000_A000;
            stub_base[8] = 32'h0000_B000;
            // Write all-1 then all-0 to all 16 offsets in 3 key stubs
            for (w = 0; w < 3; w++) begin
                for (off = 0; off < 16; off++) begin
                    tid = w * 32 + off;
                    do_axi_write(stub_base[w*3] + (off * 4), 32'hFFFF_FFFF, tid, 2'b00);
                end
                for (off = 0; off < 16; off++) begin
                    tid = w * 32 + off + 16;
                    do_axi_write(stub_base[w*3] + (off * 4), 32'h0000_0000, tid, 2'b00);
                end
                // Read back all offsets
                for (off = 0; off < 16; off++) begin
                    tid = off;
                    do_axi_read(stub_base[w*3] + (off * 4), tid, 2'b00, 32'h0, 1'b0);
                end
            end
        end
    endtask

    // ------------------------------------------------------------------
    // tc032: CTI Sys-Side Drive
    // Target: Toggle sys_cti_event_in and sys_cti_channel_in.
    // ------------------------------------------------------------------
    task automatic run_tc032_cti_sys_drive();
        int b;
        begin
            // Walking-1 on sys_cti_event_in
            for (b = 0; b < 8; b++) begin
                sys_cti_event_in = 8'h1 << b;
                @(posedge clk_src);
                sys_cti_event_in = '0;
                repeat (4) @(posedge clk_src);
            end
            // Walking-1 on sys_cti_channel_in
            for (b = 0; b < 8; b++) begin
                sys_cti_channel_in = 8'h1 << b;
                @(posedge clk_src);
                sys_cti_channel_in = '0;
                repeat (4) @(posedge clk_src);
            end
            // Complementary patterns
            sys_cti_event_in = 8'hFF;
            sys_cti_channel_in = 8'hFF;
            @(posedge clk_src);
            sys_cti_event_in = 8'h00;
            sys_cti_channel_in = 8'h00;
            repeat (4) @(posedge clk_src);
            sys_cti_event_in = 8'hAA;
            sys_cti_channel_in = 8'h55;
            @(posedge clk_src);
            sys_cti_event_in = 8'h55;
            sys_cti_channel_in = 8'hAA;
            @(posedge clk_src);
            sys_cti_event_in = '0;
            sys_cti_channel_in = '0;
            repeat (4) @(posedge clk_src);
            // Do a write to ensure NoC is still functioning
            do_axi_write(32'h0000_2000, 32'h1234_5678, 8'd0, 2'b00);
        end
    endtask

    // ------------------------------------------------------------------
    // tc033: Regbank Unmapped Offset + Default Branch
    // Target: Hit default address decode in regbank (offset > 0x10).
    // ------------------------------------------------------------------
    task automatic run_tc033_regbank_unmapped();
        int t;
        begin
            // Write to valid regbank offsets first (TNIU0 regbank window=0x0000)
            do_axi_write(32'h0000_0000, 32'hFFFF_FFFF, 8'd0, 2'b00);
            do_axi_write(32'h0000_0004, 32'hFFFF_FFFF, 8'd1, 2'b00);
            do_axi_write(32'h0000_0008, 32'hFFFF_FFFF, 8'd2, 2'b00);
            do_axi_write(32'h0000_000C, 32'hFFFF_FFFF, 8'd3, 2'b00);
            do_axi_write(32'h0000_0010, 32'hFFFF_FFFF, 8'd4, 2'b00);
            // Write to unmapped offsets (> 0x10 but < 0x1000 within regbank window)
            // p_slverr is hardcoded to 0, so these still return OKAY
            do_axi_write(32'h0000_0014, 32'hDEAD_BEEF, 8'd5, 2'b00);
            do_axi_write(32'h0000_0020, 32'hDEAD_BEEF, 8'd6, 2'b00);
            do_axi_write(32'h0000_003C, 32'hDEAD_BEEF, 8'd7, 2'b00);
            // Read from unmapped offsets (hits default rack_data/rack_vld/wreq_rdy)
            do_axi_read(32'h0000_0014, 8'd10, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_0020, 8'd11, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_003C, 8'd12, 2'b00, 32'h0, 1'b0);
            // Repeat for TNIU1 regbank (window 0x4000) and TNIU2 (0x8000)
            for (t = 0; t < 2; t++) begin
                do_axi_write(32'h0000_4000 + (t * 32'h4000) + 32'h14,
                             32'hBEEF_CAFE, 8'd20 + t, 2'b00);
                do_axi_read(32'h0000_4000 + (t * 32'h4000) + 32'h14,
                            8'd30 + t, 2'b00, 32'h0, 1'b0);
            end
            // Zero-out registers after
            do_axi_write(32'h0000_0000, 32'h0000_0000, 8'd40, 2'b00);
            do_axi_write(32'h0000_0004, 32'h0000_0000, 8'd41, 2'b00);
            do_axi_write(32'h0000_0008, 32'h0000_0000, 8'd42, 2'b00);
            do_axi_write(32'h0000_000C, 32'h0000_0000, 8'd43, 2'b00);
            do_axi_write(32'h0000_0010, 32'h0000_0000, 8'd44, 2'b00);
        end
    endtask

    // ------------------------------------------------------------------
    // tc034: Rapid-Fire Transactions (FIFO depth exercise)
    // Target: Fill INIU FIFOs to exercise hold-register and backpressure.
    // ------------------------------------------------------------------
    task automatic run_tc034_rapid_fire();
        int i;
        begin
            // Set APB stall to create backpressure
            set_apb_stall_cycles(3);
            // Rapid writes - send several writes quickly to different targets
            // to exercise FIFO fullness and pipeline backpressure
            fork
                begin
                    for (i = 0; i < 8; i++) begin
                        do_axi_write(32'h0000_2000 + (i * 4), 32'hAAAA_0000 | i, i, 2'b00);
                    end
                end
            join
            // Rapid reads
            fork
                begin
                    for (i = 0; i < 8; i++) begin
                        do_axi_read(32'h0000_2000 + (i * 4), i, 2'b00, 32'h0, 1'b0);
                    end
                end
            join
            // Mixed rapid write/read to different TNIUs
            set_apb_stall_cycles(5);
            do_axi_write(32'h0000_2000, 32'hBBBB_1111, 8'd10, 2'b00);
            do_axi_write(32'h0000_6000, 32'hBBBB_2222, 8'd11, 2'b00);
            do_axi_write(32'h0000_A000, 32'hBBBB_3333, 8'd12, 2'b00);
            do_axi_read(32'h0000_2000, 8'd20, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_6000, 8'd21, 2'b00, 32'h0, 1'b0);
            do_axi_read(32'h0000_A000, 8'd22, 2'b00, 32'h0, 1'b0);
            set_apb_stall_cycles(0);
        end
    endtask

    // ------------------------------------------------------------------
    // tc035: RD ID-Remap Entry Toggle
    // Cycle through all 128 prealloc entries with varied AXI IDs so that
    // entry_id / check_id toggle.  Also spread traffic across all TNIUs.
    // ------------------------------------------------------------------
    task automatic run_tc035_rd_entry_toggle();
        logic [31:0] tniu_addr [0:2];
        logic [7:0]  id_pat [0:3];
        int i;
        begin
            tniu_addr[0] = 32'h0000_2000;  // TNIU0 stub
            tniu_addr[1] = 32'h0000_6000;  // TNIU1 stub
            tniu_addr[2] = 32'h0000_A000;  // TNIU2 stub

            id_pat[0] = 8'h00;
            id_pat[1] = 8'hAA;
            id_pat[2] = 8'h55;
            id_pat[3] = 8'hFF;

            // Seed stub memories with known data for all 3 TNIUs
            for (i = 0; i < 3; i++) begin
                do_axi_write(tniu_addr[i],      32'hCAFE_0000 | i, 8'(i), 2'b00);
                do_axi_write(tniu_addr[i] + 4,  32'hBEEF_0000 | i, 8'(i+3), 2'b00);
            end

            // Phase 1: 256 reads cycling IDs to fill all 128 entries twice.
            // Each entry will see at least 2 different alloc_id values,
            // causing entry_id / check_id to toggle.
            for (i = 0; i < 256; i++) begin
                do_axi_read(tniu_addr[i % 3] + ((i & 1) << 2),
                            id_pat[i % 4],
                            2'b00, 32'h0, 1'b0);
            end

            // Phase 2: walking-1 and walking-0 on AXI ID to toggle all ID bits.
            for (i = 0; i < 8; i++) begin
                do_axi_read(tniu_addr[0], 8'(1 << i), 2'b00, 32'h0, 1'b0);
                do_axi_read(tniu_addr[1], 8'(~(1 << i)), 2'b00, 32'h0, 1'b0);
            end

            // Phase 3: extra round to ensure tniu1 and tniu2 get more traffic.
            for (i = 0; i < 128; i++) begin
                do_axi_read(tniu_addr[1] + ((i & 1) << 2),
                            id_pat[(i + 1) % 4],
                            2'b00, 32'h0, 1'b0);
                do_axi_read(tniu_addr[2] + ((i & 1) << 2),
                            id_pat[(i + 2) % 4],
                            2'b00, 32'h0, 1'b0);
            end
        end
    endtask

    // ------------------------------------------------------------------
    // tc036: TNIU APB Address / Payload Toggle
    // Exercise varied APB addresses and data patterns to all 3 TNIUs
    // so that apb_dec, req_fifo, and AFIFO payload bits toggle.
    // ------------------------------------------------------------------
    task automatic run_tc036_tniu_apb_toggle();
        logic [31:0] base [0:2];
        int i, t;
        logic [31:0] data;
        logic [31:0] addr;
        begin
            // Target different 4KB pages within each TNIU to exercise the
            // APB address decoder and request FIFO payload diversity.
            base[0] = 32'h0000_0000;  // TNIU0 regbank
            base[1] = 32'h0000_4000;  // TNIU1 regbank
            base[2] = 32'h0000_8000;  // TNIU2 regbank

            // Phase 1: bit-walking writes to regbank on all TNIUs
            for (t = 0; t < 3; t++) begin
                for (i = 0; i < 16; i++) begin
                    addr = base[t] + ((i & 32'hF) << 2);  // offset 0x00..0x3C
                    data = 32'h1 << i;
                    do_axi_write(addr, data, 8'(t * 50 + i), 2'b00);
                end
                for (i = 0; i < 16; i++) begin
                    addr = base[t] + ((i & 32'hF) << 2);
                    data = ~(32'h1 << i);
                    do_axi_write(addr, data, 8'(t * 50 + 16 + i), 2'b00);
                end
            end

            // Phase 2: bit-walking reads from stub addresses on all TNIUs
            for (t = 0; t < 3; t++) begin
                for (i = 0; i < 16; i++) begin
                    addr = base[t] + 32'h1000 + ((i & 32'hF) << 2);
                    do_axi_read(addr, 8'(t * 50 + 32 + i), 2'b00, 32'h0, 1'b0);
                end
            end

            // Phase 3: write data toggle patterns to all stub addresses
            for (t = 0; t < 3; t++) begin
                do_axi_write(base[t] + 32'h2000, 32'hAAAA_AAAA, 8'(200 + t*3), 2'b00);
                do_axi_write(base[t] + 32'h2004, 32'h5555_5555, 8'(201 + t*3), 2'b00);
                do_axi_write(base[t] + 32'h2008, 32'hFFFF_FFFF, 8'(202 + t*3), 2'b00);
                do_axi_read (base[t] + 32'h2000, 8'(210 + t*3), 2'b00, 32'h0, 1'b0);
                do_axi_read (base[t] + 32'h2004, 8'(211 + t*3), 2'b00, 32'h0, 1'b0);
                do_axi_read (base[t] + 32'h2008, 8'(212 + t*3), 2'b00, 32'h0, 1'b0);
            end
        end
    endtask

    // ============================================================
    // tc037 – Pipelined outstanding entry toggle
    //   Exercises all 128 id_remap entries by issuing back-to-back
    //   AR/AW in batches of BATCH without waiting for R/B per-txn.
    //   Repeats with complementary ID patterns (3 rounds) to toggle
    //   all check_id / entry_id bits in every entry.
    // ============================================================
    task automatic run_tc037_pipeline_entry_toggle();
        int cycle;
        logic [7:0] id_val;
        logic [31:0] tgt_addrs [3];
        int unsigned r_base, b_base;
        localparam BATCH = 16;
        localparam N_BATCHES = 128 / BATCH;  // 8

        tgt_addrs[0] = 32'h0000_1000;  // tniu0
        tgt_addrs[1] = 32'h0000_5000;  // tniu1
        tgt_addrs[2] = 32'h0000_9000;  // tniu2

        $display("[tc037] start pipeline entry toggle, BATCH=%0d", BATCH);

        // ---- Pipelined READS: 3 rounds × 8 batches × 16 ARs ----
        for (int round = 0; round < 3; round++) begin
            for (int batch = 0; batch < N_BATCHES; batch++) begin
                @(posedge clk_src);
                r_base = r_handshake_count;

                // Send BATCH ARs back-to-back
                for (int b = 0; b < BATCH; b++) begin
                    int idx;
                    idx = batch * BATCH + b;
                    case (round)
                        0: id_val = idx[7:0];
                        1: id_val = ~idx[7:0];
                        default: id_val = {idx[3:0], idx[7:4]};
                    endcase
                    // Setup at negedge — hardware will sample at next posedge
                    @(negedge clk_src);
                    s_arid    = id_val;
                    s_araddr  = tgt_addrs[idx % 3];
                    s_arlen   = '0;
                    s_arsize  = 3'd2;
                    s_arburst = 2'b01;
                    s_arvalid = 1'b1;
                    // Wait for posedge where arready=1 (handshake occurs in HW)
                    for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                        @(posedge clk_src);
                        if (s_arready) break;
                    end
                    // Deassert at negedge — AFTER hardware has sampled the handshake
                    @(negedge clk_src);
                    s_arvalid = 1'b0;
                end

                // Wait for all BATCH R responses
                for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                    @(posedge clk_src);
                    if (r_handshake_count - r_base >= BATCH) break;
                end
                if (r_handshake_count - r_base < BATCH)
                    $fatal(1, "tc037 RD timeout round=%0d batch=%0d got=%0d",
                           round, batch, r_handshake_count - r_base);
            end
            $display("[tc037] RD round %0d done", round);
            repeat (20) @(posedge clk_src);
        end

        // ---- Pipelined WRITES: 3 rounds × 8 batches × 16 AWs ----
        for (int round = 0; round < 3; round++) begin
            for (int batch = 0; batch < N_BATCHES; batch++) begin
                @(posedge clk_src);
                b_base = b_handshake_count;

                // Send BATCH AW+W back-to-back
                for (int b = 0; b < BATCH; b++) begin
                    int idx;
                    idx = batch * BATCH + b;
                    case (round)
                        0: id_val = idx[7:0];
                        1: id_val = ~idx[7:0];
                        default: id_val = {idx[3:0], idx[7:4]};
                    endcase
                    // Setup at negedge
                    @(negedge clk_src);
                    s_awid    = id_val;
                    s_awaddr  = tgt_addrs[idx % 3];
                    s_awlen   = '0;
                    s_awsize  = 3'd2;
                    s_awburst = 2'b01;
                    s_awvalid = 1'b1;
                    s_wdata   = {24'h0, id_val};
                    s_wstrb   = 4'hf;
                    s_wlast   = 1'b1;
                    s_wvalid  = 1'b1;
                    // Wait for both AW and W handshakes at posedge
                    begin
                        bit aw_done, w_done;
                        aw_done = 0; w_done = 0;
                        while (!aw_done || !w_done) begin
                            @(posedge clk_src);
                            if (!aw_done && s_awready) aw_done = 1;
                            if (!w_done  && s_wready)  w_done  = 1;
                        end
                    end
                    // Deassert at negedge — AFTER hardware sampled
                    @(negedge clk_src);
                    s_awvalid = 1'b0;
                    s_wvalid  = 1'b0;
                end

                // Wait for all BATCH B responses
                for (cycle = 0; cycle < SRC_TIMEOUT_CYCLES; cycle++) begin
                    @(posedge clk_src);
                    if (b_handshake_count - b_base >= BATCH) break;
                end
                if (b_handshake_count - b_base < BATCH)
                    $fatal(1, "tc037 WR timeout round=%0d batch=%0d got=%0d",
                           round, batch, b_handshake_count - b_base);
            end
            $display("[tc037] WR round %0d done", round);
            repeat (20) @(posedge clk_src);
        end

        $display("[tc037] all done");
    endtask

    initial begin
        enable_trace = $test$plusargs("ENABLE_TRACE");
        enable_vcd   = $test$plusargs("ENABLE_VCD");
        if (!$value$plusargs("TESTCASE=%s", testcase)) begin
            testcase = "tc001_reset_smoke";
        end

        if (enable_vcd) begin
            $dumpfile("debug_nouvm.vcd");
            $dumpvars(0, top_nouvm_wrap);
            $dumplimit(5_000_000);
        end

        reset_dut();
        $display("[NONUVM] testcase=%s", testcase);

        if ((testcase == "smoke") || (testcase == "tc001_reset_smoke")) begin
            run_reset_smoke();
        end else if (testcase == "tc002_regbank_rw_tniu0") begin
            run_tc002_regbank_rw_tniu0();
        end else if (testcase == "tc003_rsc_rw_tniu0") begin
            run_tc003_rsc_rw_tniu0();
        end else if (testcase == "tc004_regbank_rw_tniu1") begin
            run_tc004_regbank_rw_tniu1();
        end else if (testcase == "tc005_rsc_rw_tniu1") begin
            run_tc005_rsc_rw_tniu1();
        end else if (testcase == "tc006_regbank_rw_tniu2") begin
            run_tc006_regbank_rw_tniu2();
        end else if (testcase == "tc007_rsc_rw_tniu2") begin
            run_tc007_rsc_rw_tniu2();
        end else if ((testcase == "decerr") || (testcase == "tc008_decode_miss")) begin
            run_tc008_decode_miss();
        end else if ((testcase == "addr_map") || (testcase == "tc009_mixed_read_write")) begin
            run_tc009_mixed_read_write();
        end else if (testcase == "tc010_backpressure_rsp") begin
            run_tc010_backpressure_rsp();
        end else if ((testcase == "sideband") || (testcase == "tc011_cti_connectivity")) begin
            run_tc011_cti_connectivity();
        end else if (testcase == "tc012_debug_timestamp_path") begin
            run_tc012_debug_timestamp_path();
        end else if (testcase == "tc013_random_addr_constrained") begin
            run_tc013_random_addr_constrained();
        end else if (testcase == "tc014_random_illegal_addr") begin
            run_tc014_random_illegal_addr();
        end else if (testcase == "tc015_reset_during_idle") begin
            run_tc015_reset_during_idle();
        end else if (testcase == "tc016_apb_local_slverr_mapped_window") begin
            run_tc016_apb_local_slverr_mapped_window();
        end else if (testcase == "tc017_aw_w_skewed_arrival") begin
            run_tc017_aw_w_skewed_arrival();
        end else if (testcase == "tc018_apb_waitstate_backpressure") begin
            run_tc018_apb_waitstate_backpressure();
        end else if (testcase == "smoke_legacy") begin
            run_smoke();
        end else if (testcase == "masked_write") begin
            run_masked_write();
        end else if (testcase == "stub_slverr") begin
            run_stub_slverr();
        end else if (testcase == "cov_boost") begin
            run_cov_boost();
        end else if (testcase == "tc019_toggle_data_patterns") begin
            run_tc019_toggle_data_patterns();
        end else if (testcase == "tc020_toggle_id_ctrl") begin
            run_tc020_toggle_id_ctrl();
        end else if (testcase == "tc021_cti_bitwalking") begin
            run_tc021_cti_bitwalking();
        end else if (testcase == "tc022_simultaneous_rd_wr") begin
            run_tc022_simultaneous_rd_wr();
        end else if (testcase == "tc023_regbank_full_toggle") begin
            run_tc023_regbank_full_toggle();
        end else if (testcase == "tc024_apb_stall_sweep") begin
            run_tc024_apb_stall_sweep();
        end else if (testcase == "tc025_strobe_walk") begin
            run_tc025_strobe_walk();
        end else if (testcase == "tc026_backpressure_pattern") begin
            run_tc026_backpressure_pattern();
        end else if (testcase == "tc027_addr_offset_sweep") begin
            run_tc027_addr_offset_sweep();
        end else if (testcase == "tc028_decerr_data_toggle") begin
            run_tc028_decerr_data_toggle();
        end else if (testcase == "tc029_axi_sideband_toggle") begin
            run_tc029_axi_sideband_toggle();
        end else if (testcase == "tc030_upper_addr_toggle") begin
            run_tc030_upper_addr_toggle();
        end else if (testcase == "tc031_stub_full_offset") begin
            run_tc031_stub_full_offset();
        end else if (testcase == "tc032_cti_sys_drive") begin
            run_tc032_cti_sys_drive();
        end else if (testcase == "tc033_regbank_unmapped") begin
            run_tc033_regbank_unmapped();
        end else if (testcase == "tc034_rapid_fire") begin
            run_tc034_rapid_fire();
        end else if (testcase == "tc035_rd_entry_toggle") begin
            run_tc035_rd_entry_toggle();
        end else if (testcase == "tc036_tniu_apb_toggle") begin
            run_tc036_tniu_apb_toggle();
        end else if (testcase == "tc037_pipeline_entry_toggle") begin
            run_tc037_pipeline_entry_toggle();
        end else begin
            $fatal(1, "Unknown TESTCASE=%s", testcase);
        end

        repeat (10) @(posedge clk_src);
        $display("[NONUVM] PASS testcase=%s", testcase);
        $finish;
    end

    `_PREFIX_(sts_wrap_1iniu_1tniu_dut) u_dut (
        .clk_src            (clk_src),
        .clk_dst            (clk_dst),
        .clk_dbg_timer      (clk_dbg_timer),
        .rstn_src           (rstn_src),
        .rstn_dst           (rstn_dst),
        .rstn_dbg_timer     (rstn_dbg_timer),
        .node_id            (node_id),
        .s_awvalid          (s_awvalid),
        .s_awready          (s_awready),
        .s_awid             (s_awid),
        .s_awaddr           (s_awaddr),
        .s_awlen            (s_awlen),
        .s_awsize           (s_awsize),
        .s_awburst          (s_awburst),
        .s_awlock           (s_awlock),
        .s_awcache          (s_awcache),
        .s_awprot           (s_awprot),
        .s_awqos            (s_awqos),
        .s_awuser           (s_awuser),
        .s_wvalid           (s_wvalid),
        .s_wready           (s_wready),
        .s_wdata            (s_wdata),
        .s_wstrb            (s_wstrb),
        .s_wlast            (s_wlast),
        .s_bvalid           (s_bvalid),
        .s_bready           (s_bready),
        .s_bid              (s_bid),
        .s_bresp            (s_bresp),
        .s_arvalid          (s_arvalid),
        .s_arready          (s_arready),
        .s_arid             (s_arid),
        .s_araddr           (s_araddr),
        .s_arlen            (s_arlen),
        .s_arsize           (s_arsize),
        .s_arburst          (s_arburst),
        .s_arlock           (s_arlock),
        .s_arcache          (s_arcache),
        .s_arprot           (s_arprot),
        .s_arqos            (s_arqos),
        .s_aruser           (s_aruser),
        .s_rvalid           (s_rvalid),
        .s_rready           (s_rready),
        .s_rid              (s_rid),
        .s_rdata            (s_rdata),
        .s_rresp            (s_rresp),
        .s_rlast            (s_rlast),
        .sys_cti_event_in   (sys_cti_event_in),
        .sys_cti_event_out  (sys_cti_event_out),
        .sys_cti_channel_in (sys_cti_channel_in),
        .sys_cti_channel_out(sys_cti_channel_out),
        .dbg_timestamp_in   (dbg_timestamp_in),
        .dbg_data_in        (dbg_data_in),
        .dbg_timestamp_out_0(dbg_timestamp_out_0),
        .dbg_timestamp_out_1(dbg_timestamp_out_1),
        .dbg_timestamp_out_2(dbg_timestamp_out_2),
        .dbg_data_out_0     (dbg_data_out_0),
        .dbg_data_out_1     (dbg_data_out_1),
        .dbg_data_out_2     (dbg_data_out_2),
        .timing_bus1        (timing_bus1),
        .timing_bus2        (timing_bus2),
        .timing_bus3        (timing_bus3),
        .dbg_en             (dbg_en)
    );

endmodule
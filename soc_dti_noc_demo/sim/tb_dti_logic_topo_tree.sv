`timescale 1ns/1ps

module tb_dti_logic_topo_tree;
    localparam int unsigned LEAF_NUM = 11;
    localparam int unsigned TIMEOUT_CYCLES = 4000;

    typedef struct packed {
        logic [79:0] data;
        logic [9:0]  keep;
        logic        last;
        logic [5:0]  tid;
    } dti_beat_t;

`define DTI_INIU_PORTS(NAME, IDX) \
        .NAME``_iniu_node_clk_sys_porting_clk_sys_clk(clk_sys[IDX]), \
        .NAME``_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n(rst_sys_n[IDX]), \
        .NAME``_iniu_node_dti_req_porting_dti_req_req_tdata(iniu_req_tdata[IDX]), \
        .NAME``_iniu_node_dti_req_porting_dti_req_req_tkeep(iniu_req_tkeep[IDX]), \
        .NAME``_iniu_node_dti_req_porting_dti_req_req_tlast(iniu_req_tlast[IDX]), \
        .NAME``_iniu_node_dti_req_porting_dti_req_req_tready(iniu_req_tready[IDX]), \
        .NAME``_iniu_node_dti_req_porting_dti_req_req_ttid(iniu_req_ttid[IDX]), \
        .NAME``_iniu_node_dti_req_porting_dti_req_req_tvalid(iniu_req_tvalid[IDX]), \
        .NAME``_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata(iniu_rsp_tdata[IDX]), \
        .NAME``_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep(iniu_rsp_tkeep[IDX]), \
        .NAME``_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast(iniu_rsp_tlast[IDX]), \
        .NAME``_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready(iniu_rsp_tready[IDX]), \
        .NAME``_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid(iniu_rsp_ttid[IDX]), \
        .NAME``_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid(iniu_rsp_tvalid[IDX]), \
        .NAME``_iniu_node_timeout_val_porting_timeout_val_timeout_val(iniu_timeout_val[IDX]), \
        .NAME``_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept(iniu_paccept[IDX]), \
        .NAME``_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive(iniu_pactive[IDX]), \
        .NAME``_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny(iniu_pdeny[IDX]), \
        .NAME``_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq(iniu_preq[IDX]), \
        .NAME``_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate(iniu_pstate[IDX])

    logic clk_noc = 1'b0;
    logic rst_noc_n = 1'b0;
    logic [LEAF_NUM-1:0] clk_sys = '0;
    logic [LEAF_NUM-1:0] rst_sys_n = '0;
    logic clk_sys_tcu = 1'b0;
    logic rst_sys_tcu_n = 1'b0;

    logic [LEAF_NUM-1:0][79:0] iniu_req_tdata;
    logic [LEAF_NUM-1:0][9:0]  iniu_req_tkeep;
    logic [LEAF_NUM-1:0]       iniu_req_tlast;
    logic [LEAF_NUM-1:0]       iniu_req_tready;
    logic [LEAF_NUM-1:0][5:0]  iniu_req_ttid;
    logic [LEAF_NUM-1:0]       iniu_req_tvalid;

    logic [LEAF_NUM-1:0][79:0] iniu_rsp_tdata;
    logic [LEAF_NUM-1:0][9:0]  iniu_rsp_tkeep;
    logic [LEAF_NUM-1:0]       iniu_rsp_tlast;
    logic [LEAF_NUM-1:0]       iniu_rsp_tready;
    logic [LEAF_NUM-1:0][5:0]  iniu_rsp_ttid;
    logic [LEAF_NUM-1:0]       iniu_rsp_tvalid;

    logic [LEAF_NUM-1:0][9:0]  iniu_timeout_val;
    logic [LEAF_NUM-1:0]       iniu_paccept;
    logic [LEAF_NUM-1:0][1:0]  iniu_pactive;
    logic [LEAF_NUM-1:0]       iniu_pdeny;
    logic [LEAF_NUM-1:0]       iniu_preq;
    logic [LEAF_NUM-1:0][1:0]  iniu_pstate;

    logic [79:0] tcu_req_tdata;
    logic [9:0]  tcu_req_tkeep;
    logic        tcu_req_tlast;
    logic        tcu_req_tready;
    logic [5:0]  tcu_req_ttid;
    logic        tcu_req_tvalid;

    logic [79:0] tcu_rsp_tdata;
    logic [9:0]  tcu_rsp_tkeep;
    logic        tcu_rsp_tlast;
    logic        tcu_rsp_tready;
    logic [5:0]  tcu_rsp_ttid;
    logic        tcu_rsp_tvalid;

    logic        tcu_paccept;
    logic [1:0]  tcu_pactive;
    logic        tcu_pdeny;
    logic        tcu_preq;
    logic [1:0]  tcu_pstate;

    string leaf_name [LEAF_NUM-1:0];
    int unsigned pass_count;
    string testcase;

    always #1 clk_noc = ~clk_noc;
    always #1 clk_sys = ~clk_sys;
    always #1 clk_sys_tcu = ~clk_sys_tcu;

    always @(posedge clk_noc) begin
        if (dut.pcie_eth_iniu.top_side.req_valid && dut.pcie_eth_iniu.top_side.req_ready) begin
            $display("[DTI TREE][DBG] leaf0 top_side handshake payload=%h srcid=%0d tgtid=%0d last=%0b", 
                     dut.pcie_eth_iniu.top_side.req_payload,
                     dut.pcie_eth_iniu.top_side.req_srcid,
                     dut.pcie_eth_iniu.top_side.req_tgtid,
                     dut.pcie_eth_iniu.top_side.req_last);
        end
        if (tcu_req_tvalid && tcu_req_tready) begin
            $display("[DTI TREE][DBG] tcu req handshake data=%h keep=%h last=%0b tid=%0d", 
                     tcu_req_tdata,
                     tcu_req_tkeep,
                     tcu_req_tlast,
                     tcu_req_ttid);
        end
    end

    function automatic dti_beat_t make_beat(
        input logic [79:0] data,
        input logic [9:0]  keep,
        input logic        last,
        input logic [5:0]  tid
    );
        dti_beat_t beat;
        begin
            beat.data = data;
            beat.keep = keep;
            beat.last = last;
            beat.tid = tid;
            return beat;
        end
    endfunction

    task automatic drive_idle_inputs;
        begin
            iniu_req_tdata = '0;
            iniu_req_tkeep = '0;
            iniu_req_tlast = '0;
            iniu_req_ttid = '0;
            iniu_req_tvalid = '0;
            iniu_rsp_tready = '1;
            iniu_preq = '1;
            for (int i = 0; i < LEAF_NUM; i++) begin
                iniu_timeout_val[i] = 10'd32;
                iniu_pstate[i] = lwnoc_lp_define_package::P_POWER_ON;
            end

            tcu_req_tready = 1'b1;
            tcu_rsp_tdata = '0;
            tcu_rsp_tkeep = '0;
            tcu_rsp_tlast = 1'b0;
            tcu_rsp_ttid = '0;
            tcu_rsp_tvalid = 1'b0;
            tcu_preq = 1'b1;
            tcu_pstate = lwnoc_lp_define_package::P_POWER_ON;
        end
    endtask

    task automatic reset_dut;
        begin
            drive_idle_inputs();
            rst_noc_n = 1'b0;
            rst_sys_n = '0;
            rst_sys_tcu_n = 1'b0;
            repeat (10) @(posedge clk_noc);
            rst_noc_n = 1'b1;
            rst_sys_n = '1;
            rst_sys_tcu_n = 1'b1;
            repeat (20) @(posedge clk_noc);
        end
    endtask

    task automatic wait_power_on;
        bit all_power_on;
        bit async_req_ready;
        int stable_ready_cycles;
        begin
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_noc);
                all_power_on = (tcu_pactive == 2'd1);
                for (int i = 0; i < LEAF_NUM; i++) begin
                    all_power_on &= (iniu_pactive[i] == 2'd1);
                end
                if (all_power_on) begin
                    stable_ready_cycles = 0;
                    for (int settle_cycle = 0; settle_cycle < TIMEOUT_CYCLES; settle_cycle++) begin
                        @(posedge clk_noc);
                        async_req_ready =
                            !dut.pcie_eth_iniu.top_side.req_async_clear &&
                            !dut.vpu_iniu.top_side.req_async_clear &&
                            !dut.dsp2_iniu.top_side.req_async_clear &&
                            !dut.dsp1_iniu.top_side.req_async_clear &&
                            !dut.dsp0_iniu.top_side.req_async_clear &&
                            !dut.noc_tbu1_iniu.top_side.req_async_clear &&
                            !dut.usb_ufs_iniu.top_side.req_async_clear &&
                            !dut.mipi0_iniu.top_side.req_async_clear &&
                            !dut.mipi1_iniu.top_side.req_async_clear &&
                            !dut.camera_iniu.top_side.req_async_clear &&
                            !dut.noc_tbu0_iniu.top_side.req_async_clear &&
                            !dut.tcu_tniu.sys_side.req_async_clear;
                        if (async_req_ready) begin
                            stable_ready_cycles++;
                            if (stable_ready_cycles >= 64) begin
                                return;
                            end
                        end
                        else begin
                            stable_ready_cycles = 0;
                        end
                    end
                    $fatal(1, "[DTI TREE] async request bridge clear timeout");
                end
            end
            $fatal(1, "[DTI TREE] power-on handshake timeout");
        end
    endtask

    task automatic check_known_outputs;
        begin
            if ($isunknown({tcu_req_tdata, tcu_req_tkeep, tcu_req_tlast, tcu_req_ttid, tcu_req_tvalid,
                            tcu_rsp_tready, tcu_paccept, tcu_pactive, tcu_pdeny})) begin
                $fatal(1, "[DTI TREE] TCU outputs contain X/Z after reset");
            end

            for (int i = 0; i < LEAF_NUM; i++) begin
                if ($isunknown({iniu_req_tready[i], iniu_rsp_tdata[i], iniu_rsp_tkeep[i], iniu_rsp_tlast[i],
                                iniu_rsp_ttid[i], iniu_rsp_tvalid[i], iniu_paccept[i], iniu_pactive[i], iniu_pdeny[i]})) begin
                    $fatal(1, "[DTI TREE] leaf %0d (%s) outputs contain X/Z after reset", i, leaf_name[i]);
                end
            end
        end
    endtask

    task automatic send_leaf_beat(input int unsigned leaf_idx, input dti_beat_t beat);
        bit done;
        begin
            done = 0;
            @(posedge clk_sys[leaf_idx]);
            iniu_req_tdata[leaf_idx] = beat.data;
            iniu_req_tkeep[leaf_idx] = beat.keep;
            iniu_req_tlast[leaf_idx] = beat.last;
            iniu_req_ttid[leaf_idx] = beat.tid;
            iniu_req_tvalid[leaf_idx] = 1'b1;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys[leaf_idx]);
                if (iniu_req_tvalid[leaf_idx] && iniu_req_tready[leaf_idx]) begin
                    if (leaf_idx == 0) begin
                        $display("[DTI TREE][DBG] leaf0 handshake data=%h keep=%h last=%0b tid=%0d sys.req_valid=%0b sys.req_ready=%0b top_req_wptr=%h top_req_rptr=%h", 
                                 beat.data,
                                 beat.keep,
                                 beat.last,
                                 beat.tid,
                                 dut.pcie_eth_iniu.sys_side.req_valid,
                                 dut.pcie_eth_iniu.sys_side.req_ready,
                                 dut.pcie_eth_iniu.sys_side_TO_top_side_SIG_req_wptr_async,
                                 dut.pcie_eth_iniu.top_side_TO_sys_side_SIG_req_rptr_async);
                        $display("[DTI TREE][DBG] leaf0 top.req_async stall=%0b clear=%0b full_zero=%0b idle=%0b", 
                                 dut.pcie_eth_iniu.top_side.req_async_stall,
                                 dut.pcie_eth_iniu.top_side.req_async_clear,
                                 dut.pcie_eth_iniu.top_side.req_async_full_zero,
                                 dut.pcie_eth_iniu.top_side.req_async_idle);
                    end
                    done = 1;
                    iniu_req_tvalid[leaf_idx] = 1'b0;
                    iniu_req_tdata[leaf_idx] = '0;
                    iniu_req_tkeep[leaf_idx] = '0;
                    iniu_req_tlast[leaf_idx] = 1'b0;
                    iniu_req_ttid[leaf_idx] = '0;
                    break;
                end
            end
            if (!done) begin
                $fatal(1, "[DTI TREE] leaf request timeout leaf=%0d (%s)", leaf_idx, leaf_name[leaf_idx]);
            end
        end
    endtask

    task automatic send_leaf_packet2(
        input int unsigned leaf_idx,
        input dti_beat_t beat0,
        input dti_beat_t beat1
    );
        begin
            send_leaf_beat(leaf_idx, beat0);
            send_leaf_beat(leaf_idx, beat1);
        end
    endtask

    task automatic collect_root_req(output dti_beat_t beat);
        bit got_req;
        begin
            got_req = 0;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys_tcu);
                if (tcu_req_tvalid && tcu_req_tready) begin
                    beat.data = tcu_req_tdata;
                    beat.keep = tcu_req_tkeep;
                    beat.last = tcu_req_tlast;
                    beat.tid = tcu_req_ttid;
                    got_req = 1;
                    break;
                end
            end
            if (!got_req) begin
                $display("[DTI TREE][DBG] leaf0 req_vld=%0b req_rdy=%0b top_req_wptr=%h top_req_rptr=%h tcu_req_vld=%0b tcu_req_rdy=%0b tcu_req_twakeup=%0b", 
                         iniu_req_tvalid[0],
                         iniu_req_tready[0],
                         dut.pcie_eth_iniu.sys_side_TO_top_side_SIG_req_wptr_async,
                         dut.pcie_eth_iniu.top_side_TO_sys_side_SIG_req_rptr_async,
                         tcu_req_tvalid,
                         tcu_req_tready,
                         dut.tcu_tniu.sys_side.req_twakeup);
                $display("[DTI TREE][DBG] leaf0 sys.req_valid=%0b sys.req_ready=%0b leaf0 top.req_valid=%0b tcu.sys.req_valid=%0b tcu.sys.req_ready=%0b", 
                         dut.pcie_eth_iniu.sys_side.req_valid,
                         dut.pcie_eth_iniu.sys_side.req_ready,
                         dut.pcie_eth_iniu.top_side.req_valid,
                         dut.tcu_tniu.sys_side.req_valid,
                         dut.tcu_tniu.sys_side.req_ready);
                $display("[DTI TREE][DBG] leaf0 top.req_async stall=%0b clear=%0b full_zero=%0b idle=%0b", 
                         dut.pcie_eth_iniu.top_side.req_async_stall,
                         dut.pcie_eth_iniu.top_side.req_async_clear,
                         dut.pcie_eth_iniu.top_side.req_async_full_zero,
                         dut.pcie_eth_iniu.top_side.req_async_idle);
                $fatal(1, "[DTI TREE] root request timeout");
            end
        end
    endtask

    task automatic send_root_rsp(input dti_beat_t beat);
        bit done;
        begin
            done = 0;
            @(posedge clk_sys_tcu);
            tcu_rsp_tdata = beat.data;
            tcu_rsp_tkeep = beat.keep;
            tcu_rsp_tlast = beat.last;
            tcu_rsp_ttid = beat.tid;
            tcu_rsp_tvalid = 1'b1;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys_tcu);
                if (tcu_rsp_tvalid && tcu_rsp_tready) begin
                    done = 1;
                    tcu_rsp_tvalid = 1'b0;
                    tcu_rsp_tdata = '0;
                    tcu_rsp_tkeep = '0;
                    tcu_rsp_tlast = 1'b0;
                    tcu_rsp_ttid = '0;
                    break;
                end
            end
            if (!done) begin
                $fatal(1, "[DTI TREE] root response timeout tid=%0d", beat.tid);
            end
        end
    endtask

    task automatic expect_leaf_rsp(input int unsigned leaf_idx, input dti_beat_t exp_beat);
        bit got_rsp;
        begin
            got_rsp = 0;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys[leaf_idx]);
                if (iniu_rsp_tvalid[leaf_idx] && iniu_rsp_tready[leaf_idx]) begin
                    got_rsp = 1;
                    if (iniu_rsp_tdata[leaf_idx] !== exp_beat.data) begin
                        $fatal(1, "[DTI TREE] leaf %0d (%s) rsp data mismatch exp=%h act=%h", leaf_idx, leaf_name[leaf_idx], exp_beat.data, iniu_rsp_tdata[leaf_idx]);
                    end
                    if (iniu_rsp_tkeep[leaf_idx] !== exp_beat.keep) begin
                        $fatal(1, "[DTI TREE] leaf %0d (%s) rsp keep mismatch exp=%h act=%h", leaf_idx, leaf_name[leaf_idx], exp_beat.keep, iniu_rsp_tkeep[leaf_idx]);
                    end
                    if (iniu_rsp_tlast[leaf_idx] !== exp_beat.last) begin
                        $fatal(1, "[DTI TREE] leaf %0d (%s) rsp last mismatch exp=%0b act=%0b", leaf_idx, leaf_name[leaf_idx], exp_beat.last, iniu_rsp_tlast[leaf_idx]);
                    end
                    if ($isunknown(iniu_rsp_ttid[leaf_idx])) begin
                        $fatal(1, "[DTI TREE] leaf %0d (%s) rsp tid contains X/Z", leaf_idx, leaf_name[leaf_idx]);
                    end
                    break;
                end
            end
            if (!got_rsp) begin
                $fatal(1, "[DTI TREE] leaf response timeout leaf=%0d (%s)", leaf_idx, leaf_name[leaf_idx]);
            end
        end
    endtask

    task automatic do_roundtrip(
        input int unsigned leaf_idx,
        input dti_beat_t req_beat,
        input dti_beat_t rsp_beat_template
    );
        dti_beat_t root_req;
        dti_beat_t rsp_beat;
        begin
            fork
                send_leaf_beat(leaf_idx, req_beat);
                collect_root_req(root_req);
            join

            if (root_req.data !== req_beat.data) begin
                $fatal(1, "[DTI TREE] root data mismatch leaf=%0d exp=%h act=%h", leaf_idx, req_beat.data, root_req.data);
            end
            if (root_req.keep !== req_beat.keep) begin
                $fatal(1, "[DTI TREE] root keep mismatch leaf=%0d exp=%h act=%h", leaf_idx, req_beat.keep, root_req.keep);
            end
            if (root_req.last !== req_beat.last) begin
                $fatal(1, "[DTI TREE] root last mismatch leaf=%0d exp=%0b act=%0b", leaf_idx, req_beat.last, root_req.last);
            end
            if ($isunknown(root_req.tid)) begin
                $fatal(1, "[DTI TREE] root tid contains X/Z leaf=%0d", leaf_idx);
            end

            rsp_beat = rsp_beat_template;
            rsp_beat.tid = root_req.tid;
            fork
                send_root_rsp(rsp_beat);
                expect_leaf_rsp(leaf_idx, rsp_beat);
            join
        end
    endtask

    task automatic tc_reset;
        begin
            wait_power_on();
            check_known_outputs();
            pass_count++;
        end
    endtask

    task automatic tc_req_routing;
        dti_beat_t req_beat;
        dti_beat_t root_req;
        begin
            wait_power_on();
            for (int i = 0; i < LEAF_NUM; i++) begin
                req_beat = make_beat(80'h1000 + i, 10'h3ff - i[9:0], 1'b1, i[5:0]);
                fork
                    send_leaf_beat(i, req_beat);
                    collect_root_req(root_req);
                join
                if ((root_req.data !== req_beat.data) || (root_req.keep !== req_beat.keep) || (root_req.last !== req_beat.last)) begin
                    $fatal(1, "[DTI TREE] tc_req_routing mismatch leaf=%0d (%s)", i, leaf_name[i]);
                end
                if ($isunknown(root_req.tid)) begin
                    $fatal(1, "[DTI TREE] tc_req_routing root tid X/Z leaf=%0d (%s)", i, leaf_name[i]);
                end
            end
            pass_count++;
        end
    endtask

    task automatic tc_rsp_routing;
        dti_beat_t req_beat;
        dti_beat_t rsp_beat;
        begin
            wait_power_on();
            for (int i = 0; i < LEAF_NUM; i++) begin
                req_beat = make_beat(80'h2000 + i, 10'h155 + i[9:0], 1'b1, i[5:0]);
                rsp_beat = make_beat(80'h3000 + i, 10'h2aa - i[9:0], 1'b1, '0);
                do_roundtrip(i, req_beat, rsp_beat);
            end
            pass_count++;
        end
    endtask

    task automatic tc_boundary_ids;
        dti_beat_t req_lo;
        dti_beat_t req_hi;
        dti_beat_t rsp_lo;
        dti_beat_t rsp_hi;
        begin
            wait_power_on();
            for (int i = 0; i < LEAF_NUM; i++) begin
                req_lo = make_beat(80'h4000 + i, 10'h001 + i[9:0], 1'b1, i[5:0]);
                rsp_lo = make_beat(80'h5000 + i, 10'h200 + i[9:0], 1'b1, '0);
                do_roundtrip(i, req_lo, rsp_lo);

                req_hi = make_beat(80'h6000 + i, 10'h3c0 + i[9:0], 1'b1, i[5:0]);
                rsp_hi = make_beat(80'h7000 + i, 10'h040 + i[9:0], 1'b1, '0);
                do_roundtrip(i, req_hi, rsp_hi);
            end
            pass_count++;
        end
    endtask

    task automatic tc_concurrent_branches;
        dti_beat_t req_a;
        dti_beat_t req_b;
        dti_beat_t root_a;
        dti_beat_t root_b;
        dti_beat_t rsp_a;
        dti_beat_t rsp_b;
        int leaf_a;
        int leaf_b;
        begin
            wait_power_on();
            req_a = make_beat(80'h8000, 10'h3f0, 1'b1, 6'h00);
            req_b = make_beat(80'h9000, 10'h0f3, 1'b1, 6'h06);
            fork
                send_leaf_beat(0, req_a);
                send_leaf_beat(6, req_b);
                begin
                    collect_root_req(root_a);
                    collect_root_req(root_b);
                end
            join

            if ((root_a.data == req_a.data) && (root_b.data == req_b.data)) begin
                leaf_a = 0;
                leaf_b = 6;
            end
            else if ((root_a.data == req_b.data) && (root_b.data == req_a.data)) begin
                leaf_a = 6;
                leaf_b = 0;
            end
            else begin
                $fatal(1, "[DTI TREE] tc_concurrent_branches request set mismatch");
            end

            rsp_a = make_beat(80'ha000, 10'h123, 1'b1, root_a.tid);
            rsp_b = make_beat(80'hb000, 10'h234, 1'b1, root_b.tid);
            fork
                send_root_rsp(rsp_a);
                expect_leaf_rsp(leaf_a, rsp_a);
            join
            fork
                send_root_rsp(rsp_b);
                expect_leaf_rsp(leaf_b, rsp_b);
            join
            pass_count++;
        end
    endtask

    task automatic tc_req_sticky;
        dti_beat_t beat0;
        dti_beat_t beat1;
        dti_beat_t beat2;
        dti_beat_t root0;
        dti_beat_t root1;
        dti_beat_t root2;
        begin
            wait_power_on();
            beat0 = make_beat(80'hc000, 10'h3ff, 1'b0, 6'h00);
            beat1 = make_beat(80'hc001, 10'h3ff, 1'b1, 6'h00);
            beat2 = make_beat(80'hd000, 10'h155, 1'b1, 6'h01);
            fork
                send_leaf_packet2(0, beat0, beat1);
                send_leaf_beat(1, beat2);
                begin
                    collect_root_req(root0);
                    collect_root_req(root1);
                    collect_root_req(root2);
                end
            join
            if ((root0.data !== beat0.data) || (root1.data !== beat1.data) || (root2.data !== beat2.data)) begin
                $fatal(1, "[DTI TREE] tc_req_sticky ordering mismatch");
            end
            if (root0.last || !root1.last || !root2.last) begin
                $fatal(1, "[DTI TREE] tc_req_sticky last-field mismatch");
            end
            pass_count++;
        end
    endtask

    dti_logic_topo dut (
        .clk_noc(clk_noc),
        .rst_noc_n(rst_noc_n),
        `DTI_INIU_PORTS(pcie_eth, 0),
        `DTI_INIU_PORTS(vpu, 1),
        `DTI_INIU_PORTS(dsp2, 2),
        `DTI_INIU_PORTS(dsp1, 3),
        `DTI_INIU_PORTS(dsp0, 4),
        `DTI_INIU_PORTS(noc_tbu1, 5),
        `DTI_INIU_PORTS(usb_ufs, 6),
        `DTI_INIU_PORTS(mipi0, 7),
        `DTI_INIU_PORTS(mipi1, 8),
        `DTI_INIU_PORTS(camera, 9),
        `DTI_INIU_PORTS(noc_tbu0, 10),
        .tcu_tniu_node_clk_sys_porting_clk_sys_clk(clk_sys_tcu),
        .tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_n(rst_sys_tcu_n),
        .tcu_tniu_node_dti_req_porting_dti_req_req_tdata(tcu_req_tdata),
        .tcu_tniu_node_dti_req_porting_dti_req_req_tkeep(tcu_req_tkeep),
        .tcu_tniu_node_dti_req_porting_dti_req_req_tlast(tcu_req_tlast),
        .tcu_tniu_node_dti_req_porting_dti_req_req_tready(tcu_req_tready),
        .tcu_tniu_node_dti_req_porting_dti_req_req_ttid(tcu_req_ttid),
        .tcu_tniu_node_dti_req_porting_dti_req_req_tvalid(tcu_req_tvalid),
        .tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tdata(tcu_rsp_tdata),
        .tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep(tcu_rsp_tkeep),
        .tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tlast(tcu_rsp_tlast),
        .tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tready(tcu_rsp_tready),
        .tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_ttid(tcu_rsp_ttid),
        .tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid(tcu_rsp_tvalid),
        .tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept(tcu_paccept),
        .tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive(tcu_pactive),
        .tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny(tcu_pdeny),
        .tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq(tcu_preq),
        .tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate(tcu_pstate)
    );

    initial begin
        leaf_name[0] = "pcie_eth";
        leaf_name[1] = "vpu";
        leaf_name[2] = "dsp2";
        leaf_name[3] = "dsp1";
        leaf_name[4] = "dsp0";
        leaf_name[5] = "noc_tbu1";
        leaf_name[6] = "usb_ufs";
        leaf_name[7] = "mipi0";
        leaf_name[8] = "mipi1";
        leaf_name[9] = "camera";
        leaf_name[10] = "noc_tbu0";
    end

    initial begin
        pass_count = 0;
        if (!$value$plusargs("TESTCASE=%s", testcase)) begin
            testcase = "all";
        end
        if ($test$plusargs("DUMP_FSDB")) begin
            $fsdbDumpfile("dti_logic_topo_tree.fsdb");
            $fsdbDumpvars(0, tb_dti_logic_topo_tree, "+all");
        end

        if (testcase == "all") begin
            reset_dut(); tc_reset();
            reset_dut(); tc_req_routing();
            reset_dut(); tc_rsp_routing();
            reset_dut(); tc_boundary_ids();
            reset_dut(); tc_concurrent_branches();
            reset_dut(); tc_req_sticky();
        end
        else begin
            reset_dut();
            if (testcase == "tc_reset") tc_reset();
            else if (testcase == "tc_req_routing") tc_req_routing();
            else if (testcase == "tc_rsp_routing") tc_rsp_routing();
            else if (testcase == "tc_boundary_ids") tc_boundary_ids();
            else if (testcase == "tc_concurrent_branches") tc_concurrent_branches();
            else if (testcase == "tc_req_sticky") tc_req_sticky();
            else $fatal(1, "[DTI TREE] Unknown TESTCASE=%s", testcase);
        end

        repeat (10) @(posedge clk_noc);
        $display("[DTI TREE] PASS: %0d tests passed", pass_count);
        $finish;
    end

    initial begin
        #(TIMEOUT_CYCLES * 20);
        $fatal(1, "[DTI TREE] Global timeout");
    end

`undef DTI_INIU_PORTS
endmodule

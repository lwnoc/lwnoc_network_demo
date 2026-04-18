`timescale 1ns/1ps

module tb_soc_dti_logic_topo_tree;
    localparam int unsigned LEAF_NUM = 15;
    localparam int unsigned TIMEOUT_CYCLES = 4000;

    typedef struct packed {
        logic [79:0] data;
        logic [9:0]  keep;
        logic        last;
        logic [5:0]  tid;
    } dti_beat_t;

`define SOC_DTI_INIU_PORTS(NAME, IDX) \
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
    string testcase;

    always #1 clk_noc = ~clk_noc;
    always #1 clk_sys = ~clk_sys;
    always #1 clk_sys_tcu = ~clk_sys_tcu;

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
            repeat (120) @(posedge clk_noc);
        end
    endtask

    task automatic wait_ready;
        bit all_power_on;
        begin
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_noc);
                all_power_on = (tcu_pactive == 2'd1);
                for (int i = 0; i < LEAF_NUM; i++) begin
                    all_power_on &= (iniu_pactive[i] == 2'd1);
                end
                if (all_power_on &&
                    !dut.dsp_ss0_iniu.top_side.req_async_clear &&
                    !dut.display_ss_iniu.top_side.req_async_clear &&
                    !dut.sys_tcu_tniu.sys_side.req_async_clear) begin
                    return;
                end
            end
            $fatal(1, "[SOC DTI] power-on handshake timeout");
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
                $fatal(1, "[SOC DTI] leaf request timeout leaf=%0d (%s)", leaf_idx, leaf_name[leaf_idx]);
            end
        end
    endtask

    task automatic collect_root_req(output dti_beat_t beat);
        begin
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys_tcu);
                if (tcu_req_tvalid && tcu_req_tready) begin
                    beat.data = tcu_req_tdata;
                    beat.keep = tcu_req_tkeep;
                    beat.last = tcu_req_tlast;
                    beat.tid = tcu_req_ttid;
                    return;
                end
            end
            $fatal(1, "[SOC DTI] root request timeout");
        end
    endtask

    task automatic send_root_rsp(input dti_beat_t beat);
        begin
            @(posedge clk_sys_tcu);
            tcu_rsp_tdata = beat.data;
            tcu_rsp_tkeep = beat.keep;
            tcu_rsp_tlast = beat.last;
            tcu_rsp_ttid = beat.tid;
            tcu_rsp_tvalid = 1'b1;
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys_tcu);
                if (tcu_rsp_tvalid && tcu_rsp_tready) begin
                    tcu_rsp_tvalid = 1'b0;
                    tcu_rsp_tdata = '0;
                    tcu_rsp_tkeep = '0;
                    tcu_rsp_tlast = 1'b0;
                    tcu_rsp_ttid = '0;
                    return;
                end
            end
            $fatal(1, "[SOC DTI] root response timeout");
        end
    endtask

    task automatic collect_leaf_rsp(input int unsigned leaf_idx, output dti_beat_t beat);
        begin
            for (int cycle = 0; cycle < TIMEOUT_CYCLES; cycle++) begin
                @(posedge clk_sys[leaf_idx]);
                if (iniu_rsp_tvalid[leaf_idx] && iniu_rsp_tready[leaf_idx]) begin
                    beat.data = iniu_rsp_tdata[leaf_idx];
                    beat.keep = iniu_rsp_tkeep[leaf_idx];
                    beat.last = iniu_rsp_tlast[leaf_idx];
                    beat.tid = iniu_rsp_ttid[leaf_idx];
                    return;
                end
            end
            $fatal(1, "[SOC DTI] leaf response timeout leaf=%0d (%s)", leaf_idx, leaf_name[leaf_idx]);
        end
    endtask

    task automatic run_round_trip(
        input int unsigned leaf_idx,
        input logic [79:0] payload,
        input logic [5:0]  tid
    );
        dti_beat_t req_beat;
        dti_beat_t root_beat;
        dti_beat_t rsp_beat;
        begin
            req_beat = make_beat(payload, 10'h3ff, 1'b1, tid);
            send_leaf_beat(leaf_idx, req_beat);
            collect_root_req(root_beat);
            if (root_beat.tid !== tid) begin
                $fatal(1, "[SOC DTI] root tid mismatch exp=%0d got=%0d", tid, root_beat.tid);
            end
            send_root_rsp(root_beat);
            collect_leaf_rsp(leaf_idx, rsp_beat);
            if (rsp_beat.tid !== tid || rsp_beat.data !== payload) begin
                $fatal(1, "[SOC DTI] response mismatch leaf=%0d (%s)", leaf_idx, leaf_name[leaf_idx]);
            end
            $display("[PASS] round-trip leaf=%0d name=%s tid=%0d payload=%h", leaf_idx, leaf_name[leaf_idx], tid, payload);
        end
    endtask

    initial begin
        leaf_name[0] = "dsp_ss0";
        leaf_name[1] = "dsp_ss1";
        leaf_name[2] = "dsp_ss2";
        leaf_name[3] = "dsp_ss3";
        leaf_name[4] = "dsp_ss4";
        leaf_name[5] = "dsp_ss5";
        leaf_name[6] = "vpu_ss";
        leaf_name[7] = "pcie_rtg_ss";
        leaf_name[8] = "ufs_ss";
        leaf_name[9] = "camera_ss";
        leaf_name[10] = "mipi_ss";
        leaf_name[11] = "gpu_ss0";
        leaf_name[12] = "gpu_ss1";
        leaf_name[13] = "dp_ss";
        leaf_name[14] = "display_ss";

        if ($test$plusargs("DUMP_FSDB")) begin
            $fsdbDumpfile("soc_dti_logic_topo_tree.fsdb");
            $fsdbDumpvars(0, tb_soc_dti_logic_topo_tree, "+all");
        end

        testcase = "tc_smoke";
        if (!$value$plusargs("TESTCASE=%s", testcase)) begin
            testcase = "tc_smoke";
        end

        reset_dut();
        wait_ready();

        case (testcase)
            "tc_smoke": begin
                run_round_trip(0, 80'h0123_4567_89ab_cdef_0011, 6'd0);
            end
            "tc_boundary_ids": begin
                run_round_trip(0, 80'h1111_0000_aaaa_bbbb_cccc, 6'd0);
                run_round_trip(14, 80'h2222_3333_4444_5555_6666, 6'd14);
            end
            "tc_concurrent_branches": begin
                fork
                    run_round_trip(2, 80'h0f0f_0f0f_aaaa_5555_1111, 6'd2);
                    run_round_trip(9, 80'h1234_5678_9abc_def0_0009, 6'd9);
                    run_round_trip(12, 80'hfedc_ba98_7654_3210_000c, 6'd12);
                join
            end
            default: begin
                $fatal(1, "[SOC DTI] Unknown TESTCASE=%s", testcase);
            end
        endcase

        $display("[PASS] TESTCASE=%s completed", testcase);
        #20;
        $finish;
    end

    soc_dti_logic_topo dut (
        .clk_noc(clk_noc),
        .rst_noc_n(rst_noc_n),
        `SOC_DTI_INIU_PORTS(dsp_ss0, 0),
        `SOC_DTI_INIU_PORTS(dsp_ss1, 1),
        `SOC_DTI_INIU_PORTS(dsp_ss2, 2),
        `SOC_DTI_INIU_PORTS(dsp_ss3, 3),
        `SOC_DTI_INIU_PORTS(dsp_ss4, 4),
        `SOC_DTI_INIU_PORTS(dsp_ss5, 5),
        `SOC_DTI_INIU_PORTS(vpu_ss, 6),
        `SOC_DTI_INIU_PORTS(pcie_rtg_ss, 7),
        `SOC_DTI_INIU_PORTS(ufs_ss, 8),
        `SOC_DTI_INIU_PORTS(camera_ss, 9),
        `SOC_DTI_INIU_PORTS(mipi_ss, 10),
        `SOC_DTI_INIU_PORTS(gpu_ss0, 11),
        `SOC_DTI_INIU_PORTS(gpu_ss1, 12),
        `SOC_DTI_INIU_PORTS(dp_ss, 13),
        `SOC_DTI_INIU_PORTS(display_ss, 14),
        .sys_tcu_tniu_node_clk_sys_porting_clk_sys_clk(clk_sys_tcu),
        .sys_tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_n(rst_sys_tcu_n),
        .sys_tcu_tniu_node_dti_req_porting_dti_req_req_tdata(tcu_req_tdata),
        .sys_tcu_tniu_node_dti_req_porting_dti_req_req_tkeep(tcu_req_tkeep),
        .sys_tcu_tniu_node_dti_req_porting_dti_req_req_tlast(tcu_req_tlast),
        .sys_tcu_tniu_node_dti_req_porting_dti_req_req_tready(tcu_req_tready),
        .sys_tcu_tniu_node_dti_req_porting_dti_req_req_ttid(tcu_req_ttid),
        .sys_tcu_tniu_node_dti_req_porting_dti_req_req_tvalid(tcu_req_tvalid),
        .sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tdata(tcu_rsp_tdata),
        .sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep(tcu_rsp_tkeep),
        .sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tlast(tcu_rsp_tlast),
        .sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tready(tcu_rsp_tready),
        .sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_ttid(tcu_rsp_ttid),
        .sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid(tcu_rsp_tvalid),
        .sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept(tcu_paccept),
        .sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive(tcu_pactive),
        .sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny(tcu_pdeny),
        .sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq(tcu_preq),
        .sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate(tcu_pstate)
    );
endmodule

`timescale 1ns/1ps

module tb_dti_logic_topo_sanity;
    logic         clk_sys_npu_clk_sys_clk;
    logic         rst_n_sys_npu_rst_sys_n_rst_n;
    logic         clk_sys_vpu_clk_sys_clk;
    logic         rst_n_sys_vpu_rst_sys_n_rst_n;
    logic         clk_sys_tcu_clk_sys_clk;
    logic         rst_n_sys_tcu_rst_sys_n_rst_n;
    logic         clk_top;
    logic         rst_n_top;
    logic [79:0]  sys_npu_iniu_node_dti_req_porting_dti_req_req_tdata;
    logic [9:0]   sys_npu_iniu_node_dti_req_porting_dti_req_req_tkeep;
    logic         sys_npu_iniu_node_dti_req_porting_dti_req_req_tlast;
    logic         sys_npu_iniu_node_dti_req_porting_dti_req_req_tready;
    logic [5:0]   sys_npu_iniu_node_dti_req_porting_dti_req_req_ttid;
    logic         sys_npu_iniu_node_dti_req_porting_dti_req_req_tvalid;
    logic [79:0]  sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata;
    logic [9:0]   sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep;
    logic         sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast;
    logic         sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready;
    logic [5:0]   sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid;
    logic         sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid;
    logic [9:0]   sys_npu_iniu_node_timeout_val_porting_timeout_val_timeout_val;
    logic         sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept;
    logic [1:0]   sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive;
    logic         sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny;
    logic         sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq;
    logic [1:0]   sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate;
    logic [79:0]  sys_vpu_iniu_node_dti_req_porting_dti_req_req_tdata;
    logic [9:0]   sys_vpu_iniu_node_dti_req_porting_dti_req_req_tkeep;
    logic         sys_vpu_iniu_node_dti_req_porting_dti_req_req_tlast;
    logic         sys_vpu_iniu_node_dti_req_porting_dti_req_req_tready;
    logic [5:0]   sys_vpu_iniu_node_dti_req_porting_dti_req_req_ttid;
    logic         sys_vpu_iniu_node_dti_req_porting_dti_req_req_tvalid;
    logic [79:0]  sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata;
    logic [9:0]   sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep;
    logic         sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast;
    logic         sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready;
    logic [5:0]   sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid;
    logic         sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid;
    logic [9:0]   sys_vpu_iniu_node_timeout_val_porting_timeout_val_timeout_val;
    logic         sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept;
    logic [1:0]   sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive;
    logic         sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny;
    logic         sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq;
    logic [1:0]   sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate;
    logic [79:0]  sys_tcu_tniu_node_dti_req_porting_dti_req_req_tdata;
    logic [9:0]   sys_tcu_tniu_node_dti_req_porting_dti_req_req_tkeep;
    logic         sys_tcu_tniu_node_dti_req_porting_dti_req_req_tlast;
    logic         sys_tcu_tniu_node_dti_req_porting_dti_req_req_tready;
    logic [5:0]   sys_tcu_tniu_node_dti_req_porting_dti_req_req_ttid;
    logic         sys_tcu_tniu_node_dti_req_porting_dti_req_req_tvalid;
    logic [79:0]  sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tdata;
    logic [9:0]   sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep;
    logic         sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tlast;
    logic         sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tready;
    logic [5:0]   sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_ttid;
    logic         sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid;
    logic         sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept;
    logic [1:0]   sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive;
    logic         sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny;
    logic         sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq;
    logic [1:0]   sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate;

    initial begin
        if ($test$plusargs("dump_fsdb")) begin
            $fsdbDumpfile("sanity/tb_dti_logic_topo_sanity.fsdb");
            $fsdbDumpvars(0, tb_dti_logic_topo_sanity, "+all");
        end
    end

    dti_logic_topo dut (.*);

    always #5 clk_top                  = ~clk_top;
    always #5 clk_sys_npu_clk_sys_clk  = ~clk_sys_npu_clk_sys_clk;
    always #5 clk_sys_vpu_clk_sys_clk  = ~clk_sys_vpu_clk_sys_clk;
    always #5 clk_sys_tcu_clk_sys_clk  = ~clk_sys_tcu_clk_sys_clk;

    task automatic drive_idle_inputs;
        begin
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tdata           = '0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tkeep           = '0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tlast           = 1'b0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_ttid            = '0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tvalid          = 1'b0;
            sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready          = 1'b1;
            sys_npu_iniu_node_timeout_val_porting_timeout_val_timeout_val = '0;
            sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq          = 1'b1;
            sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate        = 2'b00;

            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tdata           = '0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tkeep           = '0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tlast           = 1'b0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_ttid            = '0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tvalid          = 1'b0;
            sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready          = 1'b1;
            sys_vpu_iniu_node_timeout_val_porting_timeout_val_timeout_val = '0;
            sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq          = 1'b1;
            sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate        = 2'b00;

            sys_tcu_tniu_node_dti_req_porting_dti_req_req_tready          = 1'b1;
            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tdata           = '0;
            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep           = '0;
            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tlast           = 1'b0;
            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_ttid            = '0;
            sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid          = 1'b0;
            sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq          = 1'b1;
            sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate        = 2'b00;
        end
    endtask

    task automatic wait_power_on;
        int cycle_count;
        begin
            cycle_count = 0;
            while (!((sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive == 2'd1) &&
                     (sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive == 2'd1) &&
                     (sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive == 2'd1))) begin
                @(posedge clk_top);
                cycle_count = cycle_count + 1;
                if (cycle_count > 200) begin
                    $error("Functional smoke failed: timed out waiting for pchannel power-on");
                    $fatal(1);
                end
            end
        end
    endtask

    task automatic check_known_outputs;
        begin
            if ($isunknown({
                sys_npu_iniu_node_dti_req_porting_dti_req_req_tready,
                sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata,
                sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep,
                sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast,
                sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid,
                sys_npu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid,
                sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept,
                sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive,
                sys_npu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny,
                sys_vpu_iniu_node_dti_req_porting_dti_req_req_tready,
                sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata,
                sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep,
                sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast,
                sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid,
                sys_vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid,
                sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept,
                sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive,
                sys_vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny,
                sys_tcu_tniu_node_dti_req_porting_dti_req_req_tdata,
                sys_tcu_tniu_node_dti_req_porting_dti_req_req_tkeep,
                sys_tcu_tniu_node_dti_req_porting_dti_req_req_tlast,
                sys_tcu_tniu_node_dti_req_porting_dti_req_req_ttid,
                sys_tcu_tniu_node_dti_req_porting_dti_req_req_tvalid,
                sys_tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tready,
                sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept,
                sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive,
                sys_tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny
            })) begin
                $error("Sanity failed: top-level outputs contain X/Z after reset release");
                $fatal(1);
            end
        end
    endtask

    task automatic drive_npu_request(
        input logic [79:0] req_data,
        input logic [9:0]  req_keep,
        input logic        req_last,
        input logic [5:0]  req_tid
    );
        begin
            @(posedge clk_sys_npu_clk_sys_clk);
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tdata  = req_data;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tkeep  = req_keep;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tlast  = req_last;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_ttid   = req_tid;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tvalid = 1'b1;

            while (!sys_npu_iniu_node_dti_req_porting_dti_req_req_tready) begin
                @(posedge clk_sys_npu_clk_sys_clk);
            end

            @(posedge clk_sys_npu_clk_sys_clk);
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tdata  = '0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tkeep  = '0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tlast  = 1'b0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_ttid   = '0;
            sys_npu_iniu_node_dti_req_porting_dti_req_req_tvalid = 1'b0;
        end
    endtask

    task automatic drive_vpu_request(
        input logic [79:0] req_data,
        input logic [9:0]  req_keep,
        input logic        req_last,
        input logic [5:0]  req_tid
    );
        begin
            @(posedge clk_sys_vpu_clk_sys_clk);
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tdata  = req_data;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tkeep  = req_keep;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tlast  = req_last;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_ttid   = req_tid;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tvalid = 1'b1;

            while (!sys_vpu_iniu_node_dti_req_porting_dti_req_req_tready) begin
                @(posedge clk_sys_vpu_clk_sys_clk);
            end

            @(posedge clk_sys_vpu_clk_sys_clk);
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tdata  = '0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tkeep  = '0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tlast  = 1'b0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_ttid   = '0;
            sys_vpu_iniu_node_dti_req_porting_dti_req_req_tvalid = 1'b0;
        end
    endtask

    task automatic expect_tcu_request(
        input logic [79:0] exp_data,
        input logic [9:0]  exp_keep,
        input logic        exp_last,
        input logic [5:0]  exp_tid
    );
        int cycle_count;
        begin
            cycle_count = 0;
            while (!(sys_tcu_tniu_node_dti_req_porting_dti_req_req_tvalid &&
                     sys_tcu_tniu_node_dti_req_porting_dti_req_req_tready)) begin
                @(posedge clk_sys_tcu_clk_sys_clk);
                cycle_count = cycle_count + 1;
                if (cycle_count > 200) begin
                    $error("Functional smoke failed: timed out waiting for TCU request handshake");
                    $fatal(1);
                end
            end

            if (sys_tcu_tniu_node_dti_req_porting_dti_req_req_tdata !== exp_data) begin
                $error("Functional smoke failed: TCU req data mismatch exp=%h got=%h", exp_data, sys_tcu_tniu_node_dti_req_porting_dti_req_req_tdata);
                $fatal(1);
            end
            if (sys_tcu_tniu_node_dti_req_porting_dti_req_req_tkeep !== exp_keep) begin
                $error("Functional smoke failed: TCU req keep mismatch exp=%h got=%h", exp_keep, sys_tcu_tniu_node_dti_req_porting_dti_req_req_tkeep);
                $fatal(1);
            end
            if (sys_tcu_tniu_node_dti_req_porting_dti_req_req_tlast !== exp_last) begin
                $error("Functional smoke failed: TCU req last mismatch exp=%b got=%b", exp_last, sys_tcu_tniu_node_dti_req_porting_dti_req_req_tlast);
                $fatal(1);
            end
            if (sys_tcu_tniu_node_dti_req_porting_dti_req_req_ttid !== exp_tid) begin
                $error("Functional smoke failed: TCU req tid mismatch exp=%0d got=%0d", exp_tid, sys_tcu_tniu_node_dti_req_porting_dti_req_req_ttid);
                $fatal(1);
            end
        end
    endtask

    initial begin
        clk_top                         = 1'b0;
        clk_sys_npu_clk_sys_clk         = 1'b0;
        clk_sys_vpu_clk_sys_clk         = 1'b0;
        clk_sys_tcu_clk_sys_clk         = 1'b0;
        rst_n_top                       = 1'b0;
        rst_n_sys_npu_rst_sys_n_rst_n   = 1'b0;
        rst_n_sys_vpu_rst_sys_n_rst_n   = 1'b0;
        rst_n_sys_tcu_rst_sys_n_rst_n   = 1'b0;

        drive_idle_inputs();

        repeat (5) @(posedge clk_top);
        rst_n_top                     = 1'b1;
        rst_n_sys_npu_rst_sys_n_rst_n = 1'b1;
        rst_n_sys_vpu_rst_sys_n_rst_n = 1'b1;
        rst_n_sys_tcu_rst_sys_n_rst_n = 1'b1;

        repeat (20) @(posedge clk_top);
        wait_power_on();
        check_known_outputs();

        fork
            drive_npu_request(80'h0123_4567_89ab_cdef_1357, 10'h3ff, 1'b1, 6'h05);
            expect_tcu_request(80'h0123_4567_89ab_cdef_1357, 10'h3ff, 1'b1, 6'h05);
        join

        repeat (8) @(posedge clk_top);

        fork
            drive_vpu_request(80'h89ab_cdef_0123_4567_2468, 10'h155, 1'b1, 6'h02);
            expect_tcu_request(80'h89ab_cdef_0123_4567_2468, 10'h155, 1'b1, 6'h04);
        join

        $display("PASSED: dti_logic_topo functional smoke");
        $finish;
    end

    initial begin
        #1000;
        $error("Sanity failed: timeout");
        $fatal(1);
    end
endmodule
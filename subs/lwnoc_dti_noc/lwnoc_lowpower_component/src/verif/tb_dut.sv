module tb_dut;
    import lwnoc_lp_define_package::*;

    // DUT接口信号
    logic                   clk_noc;
    logic                   clk_sys;
    logic                   rst_n_sys;
    logic                   rst_n_noc;  
    // async reset source and synchronizers
    logic                   rst_n_async;
    logic                   preq;
    lwnoc_pchannel_state_t  pstate;
    lwnoc_pchannel_active_t pactive;
    logic                   paccept;
    logic                   pdeny;

    // 例化DUT
    dut u_dut (
        .clk_noc(clk_noc),
        .clk_sys(clk_sys),
        .rst_n_sys(rst_n_sys),
        .rst_n_noc(rst_n_noc),
        .preq(preq),
        .pstate(pstate),
        .pactive(pactive),
        .paccept(paccept),
        .pdeny(pdeny)
    );

    // 例化P-channel Master VIP（使用 clk_noc 作为P通道时钟）
    pchn_mst_vip #(
        .TIMEOUT_CYCLES(2000),
        .VERBOSE(1)
    ) u_pchn_vip (
        .clk    (clk_sys),
        .rst_n  (rst_n_sys),
        .preq   (preq),
        .pstate (pstate),
        .pactive(pactive),
        .paccept(paccept),
        .pdeny  (pdeny)
    );

    // 时钟生成
    initial clk_noc = 0;
    initial clk_sys = 0;

    always #5 clk_noc = ~clk_noc; 
    always #6 clk_sys = ~clk_sys;
    // 异步复位源：t=0 拉低，t=20ns 释放
    initial begin
        rst_n_async = 1'b0;
        #20;
        rst_n_async = 1'b1;
    end

    // 各时钟域同步释放（两拍同步）
    logic [1:0] rst_sync_sys;
    logic [1:0] rst_sync_noc;
    always_ff @(posedge clk_sys or negedge rst_n_async) begin
        if (!rst_n_async) rst_sync_sys <= 2'b00; else rst_sync_sys <= {rst_sync_sys[0], 1'b1};
    end
    always_ff @(posedge clk_noc or negedge rst_n_async) begin
        if (!rst_n_async) rst_sync_noc <= 2'b00; else rst_sync_noc <= {rst_sync_noc[0], 1'b1};
    end
    assign rst_n_sys = rst_sync_sys[1];
    assign rst_n_noc = rst_sync_noc[1];

    // 用VIP发起P-channel请求序列
    initial begin
        int rc;
        @(posedge rst_n_sys);
        #10;
        // 上电
        u_pchn_vip.power_on(rc);
        // 下电到LEVEL1
        #40;
        u_pchn_vip.level1_off(rc);
    end

    // 观测与诊断：打印关键信号
    initial begin
        $display("%0t: TB start", $time);
    end
    always @(posedge rst_n_sys) $display("%0t: rst_n_sys released", $time);
    always @(posedge rst_n_noc) $display("%0t: rst_n_noc released", $time);

    // 波形与仿真结束
    initial begin
`ifdef VERILATOR
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_dut);
`else
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars("+all");
        $fsdbDumpon;
`endif
        #2000;
`ifndef VERILATOR
        $fsdbDumpoff;
`endif
        $finish;
    end
endmodule

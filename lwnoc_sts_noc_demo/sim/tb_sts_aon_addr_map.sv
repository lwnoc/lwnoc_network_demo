`timescale 1ns/1ps

module tb_sts_aon_addr_map;
    import Base_lwnoc_sts_pack::*;

    localparam int unsigned TNIU_NUM             = 38;
    localparam int unsigned EXPECTED_ENTRY_NUM   = 191;
    localparam logic [31:0] FUNC_STRIDE          = 32'h0002_0000;
    localparam logic [31:0] DEBUG_BASE_START     = 32'h0200_0000;
    localparam logic [31:0] DEBUG_STRIDE         = 32'h0200_0000;
    localparam logic [31:0] FUNC_SYS_SAMPLE_OFS  = 32'h0000_2000;
    localparam logic [31:0] DEBUG_SYS_SAMPLE_OFS = 32'h0000_2000;

    logic [AXI_ADDR_WIDTH-1:0] in_addr;
    logic [TGT_ID_WIDTH-1:0]   out_tgt_id;
    logic                      out_hit;

    string       resource_name [TNIU_NUM-1:0];
    int unsigned addr_idx      [TNIU_NUM-1:0];
    int unsigned tniu_id       [TNIU_NUM-1:0];
    logic        has_iniu_cti  [TNIU_NUM-1:0];
    int unsigned pass_count;
    int unsigned fail_count;

    Base_sts_iniu_addr_map #(
        .ENTRY_NUM      (`STS_INIU_ADDR_MAP_ENTRY_NUM),
        .ADDR_BASE_TABLE(`STS_INIU_ADDR_MAP_BASE_TABLE),
        .ADDR_MASK_TABLE(`STS_INIU_ADDR_MAP_MASK_TABLE),
        .TGT_ID_TABLE   (`STS_INIU_ADDR_MAP_TGT_ID_TABLE),
        .DEFAULT_TGT_ID (`STS_INIU_ADDR_MAP_DEFAULT_TGT_ID)
    ) dut (
        .in_addr    (in_addr    ),
        .out_tgt_id (out_tgt_id ),
        .out_hit    (out_hit    )
    );

    task automatic set_resource(
        input int unsigned resource_idx,
        input string       name,
        input int unsigned addr_idx_value,
        input int unsigned tniu_id_value,
        input logic        has_iniu_cti_value
    );
        resource_name[resource_idx] = name;
        addr_idx[resource_idx]      = addr_idx_value;
        tniu_id[resource_idx]       = tniu_id_value;
        has_iniu_cti[resource_idx]  = has_iniu_cti_value;
    endtask

    task automatic expect_hit(
        input string                    label,
        input logic [AXI_ADDR_WIDTH-1:0] sample_addr,
        input int unsigned              expected_tgt_id
    );
        logic [TGT_ID_WIDTH-1:0] expected_tgt_id_vec;
        expected_tgt_id_vec = expected_tgt_id;
        in_addr = sample_addr;
        #1;
        if (!out_hit || (out_tgt_id !== expected_tgt_id_vec)) begin
            fail_count++;
            $display("[FAIL] %-36s addr=0x%08h hit=%0b tgt=0x%03h expected=0x%03h",
                     label, sample_addr, out_hit, out_tgt_id, expected_tgt_id_vec);
        end
        else begin
            pass_count++;
        end
    endtask

    task automatic expect_miss(input logic [AXI_ADDR_WIDTH-1:0] sample_addr);
        logic [TGT_ID_WIDTH-1:0] expected_default_tgt_id;
        expected_default_tgt_id = `STS_INIU_ADDR_MAP_DEFAULT_TGT_ID;
        in_addr = sample_addr;
        #1;
        if (out_hit || (out_tgt_id !== expected_default_tgt_id)) begin
            fail_count++;
            $display("[FAIL] miss_default addr=0x%08h hit=%0b tgt=0x%03h expected_default=0x%03h",
                     sample_addr, out_hit, out_tgt_id, expected_default_tgt_id);
        end
        else begin
            pass_count++;
        end
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

    initial begin
        logic [AXI_ADDR_WIDTH-1:0] func_base_addr;
        logic [AXI_ADDR_WIDTH-1:0] debug_base_addr;
        string label;

        init_resources();
        in_addr    = '0;
        pass_count = 0;
        fail_count = 0;

        if (`STS_INIU_ADDR_MAP_ENTRY_NUM != EXPECTED_ENTRY_NUM) begin
            $fatal(1, "AON INIU address-map entry count mismatch: got %0d expected %0d",
                   `STS_INIU_ADDR_MAP_ENTRY_NUM, EXPECTED_ENTRY_NUM);
        end
        if (TGT_ID_WIDTH != 9) begin
            $fatal(1, "AON INIU target ID width mismatch: got %0d expected 9", TGT_ID_WIDTH);
        end

        for (int unsigned resource_idx = 0; resource_idx < TNIU_NUM; resource_idx++) begin
            func_base_addr  = addr_idx[resource_idx] * FUNC_STRIDE;
            debug_base_addr = DEBUG_BASE_START + (addr_idx[resource_idx] * DEBUG_STRIDE);

            label = {resource_name[resource_idx], ".local_regbank"};
            expect_hit(label, func_base_addr, 32'h080 | tniu_id[resource_idx]);

            label = {resource_name[resource_idx], ".sys_reg"};
            expect_hit(label, func_base_addr + 32'h0000_1000, 32'h040 | tniu_id[resource_idx]);

            label = {resource_name[resource_idx], ".func_sys_apb"};
            expect_hit(label, func_base_addr + FUNC_SYS_SAMPLE_OFS, tniu_id[resource_idx]);

            label = {resource_name[resource_idx], ".local_cti"};
            expect_hit(label, debug_base_addr, 32'h0C0 | tniu_id[resource_idx]);

            if (has_iniu_cti[resource_idx]) begin
                label = {resource_name[resource_idx], ".local_iniu_cti"};
                expect_hit(label, debug_base_addr + 32'h0000_1000, 32'h100 | tniu_id[resource_idx]);
            end

            label = {resource_name[resource_idx], ".debug_sys_apb"};
            expect_hit(label, debug_base_addr + DEBUG_SYS_SAMPLE_OFS, tniu_id[resource_idx]);
        end

        expect_miss(32'hFFFF_F000);

        if (fail_count != 0) begin
            $fatal(1, "AON INIU address-map test FAILED: pass=%0d fail=%0d", pass_count, fail_count);
        end

        $display("[PASS] AON INIU address-map test passed: %0d checks", pass_count);
        $finish;
    end
endmodule

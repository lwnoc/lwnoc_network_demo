module sts_noc_peri_ss_tniu_RegSpaceBase_cfg_reg_bank_table_sys (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [15:0] p_addr,
    input  logic        p_sel,
    input  logic        p_enable,
    input  logic        p_write,
    input  logic [31:0] p_wdata,
    input  logic [3:0]  p_strb,
    output logic        p_ready,
    output logic [31:0] p_rdata,
    output logic        p_slverr,
    output logic        parity_sw_check_err,
    output logic [31:0] sys_reg0_sys_reg0_rdat,
    output logic        sys_reg0_parity_hw_check_err,
    output logic [31:0] sys_reg1_sys_reg1_rdat,
    output logic        sys_reg1_parity_hw_check_err,
    output logic [31:0] sys_reg2_sys_reg2_rdat,
    output logic        sys_reg2_parity_hw_check_err,
    output logic [31:0] sys_reg3_sys_reg3_rdat,
    output logic        sys_reg3_parity_hw_check_err,
    output logic [31:0] sys_reg4_sys_reg4_rdat,
    output logic        sys_reg4_parity_hw_check_err,
    output logic [31:0] sys_reg5_sys_reg5_rdat,
    output logic        sys_reg5_parity_hw_check_err,
    output logic [31:0] sys_reg6_sys_reg6_rdat,
    output logic        sys_reg6_parity_hw_check_err,
    output logic [31:0] sys_reg7_sys_reg7_rdat,
    output logic        sys_reg7_parity_hw_check_err,
    output logic [31:0] sys_reg8_sys_reg8_rdat,
    output logic        sys_reg8_parity_hw_check_err,
    output logic [31:0] sys_reg9_sys_reg9_rdat,
    output logic        sys_reg9_parity_hw_check_err
);

    localparam int REG_NUM = 10;

    logic [31:0] reg_q [REG_NUM-1:0];
    logic [3:0]  reg_parity_q [REG_NUM-1:0];
    logic [REG_NUM-1:0] reg_parity_err;
    logic [3:0]  addr_idx;
    logic        addr_hit;
    logic        write_fire;
    logic [31:0] write_data_merged;

    function automatic logic [3:0] calc_parity_bits(input logic [31:0] data);
        calc_parity_bits[0] = ^data[7:0];
        calc_parity_bits[1] = ^data[15:8];
        calc_parity_bits[2] = ^data[23:16];
        calc_parity_bits[3] = ^data[31:24];
    endfunction

    function automatic logic [31:0] apply_strb(
        input logic [31:0] old_data,
        input logic [31:0] new_data,
        input logic [3:0]  strb
    );
        apply_strb = old_data;
        for (int byte_idx = 0; byte_idx < 4; byte_idx = byte_idx + 1) begin
            if (strb[byte_idx]) begin
                apply_strb[byte_idx*8 +: 8] = new_data[byte_idx*8 +: 8];
            end
        end
    endfunction

    assign addr_idx   = p_addr[5:2];
    assign addr_hit   = (p_addr[15:6] == 10'b0) && (p_addr[1:0] == 2'b00) && (addr_idx < REG_NUM);
    assign write_fire = p_sel && p_enable && p_write && addr_hit;
    assign p_ready    = 1'b1;
    assign p_slverr   = p_sel && p_enable && !addr_hit;

    always_comb begin
        write_data_merged = '0;
        if (addr_hit) begin
            write_data_merged = apply_strb(reg_q[addr_idx], p_wdata, p_strb);
        end
    end

    always_comb begin
        p_rdata = 32'hffff_fffe;
        parity_sw_check_err = 1'b0;
        if (addr_hit) begin
            p_rdata = reg_q[addr_idx];
            parity_sw_check_err = reg_parity_err[addr_idx];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int reg_idx = 0; reg_idx < REG_NUM; reg_idx = reg_idx + 1) begin
                reg_q[reg_idx] <= '0;
                reg_parity_q[reg_idx] <= '0;
            end
        end
        else if (write_fire) begin
            reg_q[addr_idx] <= write_data_merged;
            reg_parity_q[addr_idx] <= calc_parity_bits(write_data_merged);
        end
    end

    assign reg_parity_err[0] = (calc_parity_bits(reg_q[0]) != reg_parity_q[0]);
    assign reg_parity_err[1] = (calc_parity_bits(reg_q[1]) != reg_parity_q[1]);
    assign reg_parity_err[2] = (calc_parity_bits(reg_q[2]) != reg_parity_q[2]);
    assign reg_parity_err[3] = (calc_parity_bits(reg_q[3]) != reg_parity_q[3]);
    assign reg_parity_err[4] = (calc_parity_bits(reg_q[4]) != reg_parity_q[4]);
    assign reg_parity_err[5] = (calc_parity_bits(reg_q[5]) != reg_parity_q[5]);
    assign reg_parity_err[6] = (calc_parity_bits(reg_q[6]) != reg_parity_q[6]);
    assign reg_parity_err[7] = (calc_parity_bits(reg_q[7]) != reg_parity_q[7]);
    assign reg_parity_err[8] = (calc_parity_bits(reg_q[8]) != reg_parity_q[8]);
    assign reg_parity_err[9] = (calc_parity_bits(reg_q[9]) != reg_parity_q[9]);

    assign sys_reg0_sys_reg0_rdat = reg_q[0];
    assign sys_reg1_sys_reg1_rdat = reg_q[1];
    assign sys_reg2_sys_reg2_rdat = reg_q[2];
    assign sys_reg3_sys_reg3_rdat = reg_q[3];
    assign sys_reg4_sys_reg4_rdat = reg_q[4];
    assign sys_reg5_sys_reg5_rdat = reg_q[5];
    assign sys_reg6_sys_reg6_rdat = reg_q[6];
    assign sys_reg7_sys_reg7_rdat = reg_q[7];
    assign sys_reg8_sys_reg8_rdat = reg_q[8];
    assign sys_reg9_sys_reg9_rdat = reg_q[9];

    assign sys_reg0_parity_hw_check_err = reg_parity_err[0];
    assign sys_reg1_parity_hw_check_err = reg_parity_err[1];
    assign sys_reg2_parity_hw_check_err = reg_parity_err[2];
    assign sys_reg3_parity_hw_check_err = reg_parity_err[3];
    assign sys_reg4_parity_hw_check_err = reg_parity_err[4];
    assign sys_reg5_parity_hw_check_err = reg_parity_err[5];
    assign sys_reg6_parity_hw_check_err = reg_parity_err[6];
    assign sys_reg7_parity_hw_check_err = reg_parity_err[7];
    assign sys_reg8_parity_hw_check_err = reg_parity_err[8];
    assign sys_reg9_parity_hw_check_err = reg_parity_err[9];

endmodule

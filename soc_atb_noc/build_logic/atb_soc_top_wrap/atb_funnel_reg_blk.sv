module atb_funnel_reg_blk #(
    parameter integer unsigned ATB_DATA_WIDTH      = 64,
    parameter integer unsigned ATB_BYTES_WIDTH     =
        (ATB_DATA_WIDTH == 32)  ? 2 :
        (ATB_DATA_WIDTH == 64)  ? 3 :
        (ATB_DATA_WIDTH == 128) ? 4 : 3,
    parameter integer unsigned ATB_ID_WIDTH        = 7,
    parameter integer unsigned N_ATB               = 2,
    parameter integer unsigned PRI_WIDTH           = (N_ATB <= 2) ? 1 : $clog2(N_ATB),
    parameter integer unsigned HOLD_WIDTH          = 4,
    parameter integer unsigned DATA0_WIDTH         = 9,
    parameter logic            FIXED_CONFIGURATION = 1'b0,
    parameter logic [3:0]      FIXED_HOLD_TIME     = 4'b0011
) (
    input  logic                                    clk,
    input  logic                                    resetn,
    input  logic                                    paddrdbg31,
    input  logic                                    reg_write,
    input  logic                                    reg_read,
    input  logic [9:0]                              reg_addr,
    input  logic [31:0]                             write_data,
    input  logic [DATA0_WIDTH-1:0]                  it_atb_data_0_rd_reg,
    input  logic [1:0]                              it_atb_ctr_2_rd_reg,
    input  logic [ATB_ID_WIDTH-1:0]                 it_atb_ctr_1_rd_reg,
    input  logic [ATB_BYTES_WIDTH+1:0]              it_atb_ctr_0_rd_reg,
    input  logic [N_ATB-1:0]                        atvalids,
    input  logic [N_ATB-1:0]                        atreadys,
    input  logic [N_ATB-1:0]                        afvalids,
    output logic [DATA0_WIDTH-1:0]                  it_atb_data_0_wr_reg,
    output logic [1:0]                              it_atb_ctr_2_wr_reg,
    output logic [ATB_ID_WIDTH-1:0]                 it_atb_ctr_1_wr_reg,
    output logic [ATB_BYTES_WIDTH+1:0]              it_atb_ctr_0_wr_reg,
    output logic [N_ATB-1:0]                        en_ports,
    output logic [N_ATB-1:0][PRI_WIDTH-1:0]         pri_ports,
    output logic                                    itc_reg,
    output logic [HOLD_WIDTH-1:0]                   min_hold_time,
    output logic [31:0]                             read_data
);
    localparam logic [9:0] REG_DATA0_ADDR = 10'h000;
    localparam logic [9:0] REG_CTR2_ADDR  = 10'h001;
    localparam logic [9:0] REG_CTR1_ADDR  = 10'h002;
    localparam logic [9:0] REG_CTR0_ADDR  = 10'h003;

    logic [HOLD_WIDTH-1:0] hold_time_reg;

    assign min_hold_time = FIXED_CONFIGURATION ? FIXED_HOLD_TIME[HOLD_WIDTH-1:0] : hold_time_reg;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            it_atb_data_0_wr_reg <= '0;
            it_atb_ctr_2_wr_reg  <= '0;
            it_atb_ctr_1_wr_reg  <= '0;
            it_atb_ctr_0_wr_reg  <= '0;
            en_ports             <= {N_ATB{1'b1}};
            pri_ports            <= '0;
            hold_time_reg        <= '0;
            itc_reg              <= 1'b0;
        end
        else if (reg_write && !paddrdbg31) begin
            case (reg_addr)
                REG_DATA0_ADDR: begin
                    it_atb_data_0_wr_reg <= write_data[DATA0_WIDTH-1:0];
                end
                REG_CTR2_ADDR: begin
                    it_atb_ctr_2_wr_reg <= write_data[1:0];
                    for (integer i = 0; i < N_ATB; i = i + 1) begin
                        if ((2 + i) < 32) begin
                            en_ports[i] <= write_data[2 + i];
                        end
                    end
                end
                REG_CTR1_ADDR: begin
                    if ((8 + ATB_ID_WIDTH) <= 31) begin
                        it_atb_ctr_1_wr_reg <= write_data[8 +: ATB_ID_WIDTH];
                    end
                    for (integer i = 0; i < N_ATB; i = i + 1) begin
                        if (((i + 1) * PRI_WIDTH) <= 31) begin
                            pri_ports[i] <= write_data[(i * PRI_WIDTH) +: PRI_WIDTH];
                        end
                    end
                    itc_reg <= write_data[31];
                end
                REG_CTR0_ADDR: begin
                    hold_time_reg <= write_data[HOLD_WIDTH-1:0];
                    if ((8 + ATB_BYTES_WIDTH + 2) <= 32) begin
                        it_atb_ctr_0_wr_reg <= write_data[8 +: (ATB_BYTES_WIDTH + 2)];
                    end
                end
                default: begin
                    it_atb_data_0_wr_reg <= it_atb_data_0_wr_reg;
                    it_atb_ctr_2_wr_reg  <= it_atb_ctr_2_wr_reg;
                    it_atb_ctr_1_wr_reg  <= it_atb_ctr_1_wr_reg;
                    it_atb_ctr_0_wr_reg  <= it_atb_ctr_0_wr_reg;
                    en_ports             <= en_ports;
                    pri_ports            <= pri_ports;
                    hold_time_reg        <= hold_time_reg;
                    itc_reg              <= itc_reg;
                end
            endcase
        end
    end

    always_comb begin
        read_data = 32'h0;
        if (reg_read && !paddrdbg31) begin
            case (reg_addr)
                REG_DATA0_ADDR: begin
                    read_data[DATA0_WIDTH-1:0] = it_atb_data_0_rd_reg;
                end
                REG_CTR2_ADDR: begin
                    read_data[1:0] = it_atb_ctr_2_rd_reg;
                    for (integer i = 0; i < N_ATB; i = i + 1) begin
                        if ((2 + i) < 32) begin
                            read_data[2 + i] = en_ports[i];
                        end
                        if ((2 + N_ATB + i) < 32) begin
                            read_data[2 + N_ATB + i] = atvalids[i];
                        end
                        if ((2 + (2 * N_ATB) + i) < 32) begin
                            read_data[2 + (2 * N_ATB) + i] = atreadys[i];
                        end
                        if ((2 + (3 * N_ATB) + i) < 32) begin
                            read_data[2 + (3 * N_ATB) + i] = afvalids[i];
                        end
                    end
                end
                REG_CTR1_ADDR: begin
                    for (integer i = 0; i < N_ATB; i = i + 1) begin
                        if (((i + 1) * PRI_WIDTH) <= 16) begin
                            read_data[(i * PRI_WIDTH) +: PRI_WIDTH] = pri_ports[i];
                        end
                    end
                    if ((8 + ATB_ID_WIDTH) <= 31) begin
                        read_data[8 +: ATB_ID_WIDTH] = it_atb_ctr_1_rd_reg;
                    end
                    read_data[31] = itc_reg;
                end
                REG_CTR0_ADDR: begin
                    read_data[HOLD_WIDTH-1:0] = min_hold_time;
                    if ((8 + ATB_BYTES_WIDTH + 2) <= 32) begin
                        read_data[8 +: (ATB_BYTES_WIDTH + 2)] = it_atb_ctr_0_rd_reg;
                    end
                end
                default: begin
                    read_data = 32'h0;
                end
            endcase
        end
    end
endmodule

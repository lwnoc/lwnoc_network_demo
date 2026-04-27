module atb_funnel #(
  parameter integer unsigned ATB_DATA_WIDTH       = 64,
  parameter integer unsigned ATB_BYTES_WIDTH      =
    (ATB_DATA_WIDTH == 32)  ? 2 :
    (ATB_DATA_WIDTH == 64)  ? 3 :
    (ATB_DATA_WIDTH == 128) ? 4 : 3,
  parameter integer unsigned ATB_ID_WIDTH         = 7,
  parameter integer unsigned N_ATB                = 2,
  parameter logic            FIXED_CONFIGURATION  = 1'b0,
  parameter logic [3:0]      FIXED_HOLD_TIME      = 4'b0011
) (
  input  logic                                    clk,
  input  logic                                    resetn,

  input  logic                                    pclkendbg,
  input  logic                                    pseldbg,
  input  logic                                    penabledbg,
  input  logic                                    pwritedbg,
  input  logic                                    paddrdbg31,
  input  logic [11:2]                             paddrdbg,
  input  logic [31:0]                             pwdatadbg,

  input  logic [N_ATB-1:0]                        atvalids,
  input  logic [N_ATB-1:0]                        afreadys,
  input  logic [N_ATB-1:0][ATB_ID_WIDTH-1:0]      atids,
  input  logic [N_ATB-1:0][ATB_DATA_WIDTH-1:0]    atdatas,
  input  logic [N_ATB-1:0][ATB_BYTES_WIDTH-1:0]   atbytess,

  input  logic                                    atreadym,
  input  logic                                    afvalidm,
  input  logic                                    syncreqm,

  output logic                                    preadydbg,
  output logic                                    pslverrdbg,
  output logic [31:0]                             prdatadbg,
  output logic                                    atvalidm,
  output logic                                    afreadym,
  output logic [ATB_ID_WIDTH-1:0]                 atidm,
  output logic [ATB_DATA_WIDTH-1:0]               atdatam,
  output logic [ATB_BYTES_WIDTH-1:0]              atbytesm,
  output logic [N_ATB-1:0]                        atreadys,
  output logic [N_ATB-1:0]                        afvalids,
  output logic [N_ATB-1:0]                        syncreqs
);
  localparam integer unsigned SEL_WIDTH = (N_ATB <= 1) ? 1 : $clog2(N_ATB);
  localparam integer unsigned PRI_WIDTH = (N_ATB <= 2) ? 1 : $clog2(N_ATB);

  logic [0:0][31:0] if_read_data_groups;
  logic [0:0]       if_reg_write;
  logic [0:0]       if_reg_read;
  logic [0:0][9:0]  if_reg_addr;
  logic [0:0][31:0] if_write_data;

  logic [8:0]                              it_atb_data_0_wr_reg;
  logic [1:0]                              it_atb_ctr_2_wr_reg;
  logic [ATB_ID_WIDTH-1:0]                 it_atb_ctr_1_wr_reg;
  logic [ATB_BYTES_WIDTH+1:0]              it_atb_ctr_0_wr_reg;
  logic [8:0]                              it_atb_data_0_rd_reg;
  logic [1:0]                              it_atb_ctr_2_rd_reg;
  logic [ATB_ID_WIDTH-1:0]                 it_atb_ctr_1_rd_reg;
  logic [ATB_BYTES_WIDTH+1:0]              it_atb_ctr_0_rd_reg;
  logic [N_ATB-1:0]                        en_port_reg;
  logic [N_ATB-1:0][PRI_WIDTH-1:0]         pri_port_reg;
  logic                                    itc_reg;
  logic [31:0]                             read_data;
  logic [3:0]                              min_hold_time;

  assign pslverrdbg = 1'b0;
  assign if_read_data_groups[0] = read_data;

  always_comb begin
    it_atb_data_0_rd_reg = '0;
    if (ATB_DATA_WIDTH >= 64) begin
      it_atb_data_0_rd_reg[8] = atdatam[63];
      it_atb_data_0_rd_reg[7] = atdatam[55];
      it_atb_data_0_rd_reg[6] = atdatam[47];
      it_atb_data_0_rd_reg[5] = atdatam[39];
      it_atb_data_0_rd_reg[4] = atdatam[31];
      it_atb_data_0_rd_reg[3] = atdatam[23];
      it_atb_data_0_rd_reg[2] = atdatam[15];
      it_atb_data_0_rd_reg[1] = atdatam[7];
      it_atb_data_0_rd_reg[0] = atdatam[0];
    end
  end

  assign it_atb_ctr_2_rd_reg = {afvalidm, atreadym};
  assign it_atb_ctr_1_rd_reg = atidm;
  assign it_atb_ctr_0_rd_reg = {atbytesm, afreadym, atvalidm};

  atb_if #(
    .ADDR_WIDTH (10),
    .DATA_WIDTH (32),
    .N_GROUPS   (1)
  ) u_atb_if (
    .clk              (clk),
    .pclkendbg        (pclkendbg),
    .resetn           (resetn),
    .pseldbg          (pseldbg),
    .penabledbg       (penabledbg),
    .pwritedbg        (pwritedbg),
    .paddrdbg         (paddrdbg),
    .pwdatadbg        (pwdatadbg),
    .read_data_groups (if_read_data_groups),
    .preadydbg        (preadydbg),
    .prdatadbg        (prdatadbg),
    .reg_write        (if_reg_write),
    .reg_read         (if_reg_read),
    .reg_addr         (if_reg_addr),
    .write_data       (if_write_data)
  );

  atb_funnel_reg_blk #(
    .ATB_DATA_WIDTH      (ATB_DATA_WIDTH),
    .ATB_BYTES_WIDTH     (ATB_BYTES_WIDTH),
    .ATB_ID_WIDTH        (ATB_ID_WIDTH),
    .N_ATB               (N_ATB),
    .PRI_WIDTH           (PRI_WIDTH),
    .HOLD_WIDTH          (4),
    .DATA0_WIDTH         (9),
    .FIXED_CONFIGURATION (FIXED_CONFIGURATION),
    .FIXED_HOLD_TIME     (FIXED_HOLD_TIME)
  ) u_atb_funnel_reg_blk (
    .clk                  (clk),
    .resetn               (resetn),
    .paddrdbg31           (paddrdbg31),
    .reg_write            (if_reg_write[0]),
    .reg_read             (if_reg_read[0]),
    .reg_addr             (if_reg_addr[0]),
    .write_data           (if_write_data[0]),
    .it_atb_data_0_rd_reg (it_atb_data_0_rd_reg),
    .it_atb_ctr_2_rd_reg  (it_atb_ctr_2_rd_reg),
    .it_atb_ctr_1_rd_reg  (it_atb_ctr_1_rd_reg),
    .it_atb_ctr_0_rd_reg  (it_atb_ctr_0_rd_reg),
    .atvalids             (atvalids),
    .atreadys             (atreadys),
    .afvalids             (afvalids),
    .it_atb_data_0_wr_reg (it_atb_data_0_wr_reg),
    .it_atb_ctr_2_wr_reg  (it_atb_ctr_2_wr_reg),
    .it_atb_ctr_1_wr_reg  (it_atb_ctr_1_wr_reg),
    .it_atb_ctr_0_wr_reg  (it_atb_ctr_0_wr_reg),
    .en_ports             (en_port_reg),
    .pri_ports            (pri_port_reg),
    .itc_reg              (itc_reg),
    .min_hold_time        (min_hold_time),
    .read_data            (read_data)
  );

  atb_funnel_arbiter #(
    .ATB_DATA_WIDTH  (ATB_DATA_WIDTH),
    .ATB_BYTES_WIDTH (ATB_BYTES_WIDTH),
    .ATB_ID_WIDTH    (ATB_ID_WIDTH),
    .N_ATB           (N_ATB),
    .HOLD_WIDTH      (4),
    .SEL_WIDTH       (SEL_WIDTH),
    .PRI_WIDTH       (PRI_WIDTH)
  ) u_atb_funnel_arbiter (
    .clk              (clk),
    .resetn           (resetn),
    .itc_reg          (itc_reg),
    .it_atb_data_0_reg(it_atb_data_0_wr_reg),
    .min_hold_time    (min_hold_time),
    .en_ports         (en_port_reg),
    .pri_ports        (pri_port_reg),
    .atvalids         (atvalids),
    .afreadys         (afreadys),
    .atids            (atids),
    .atdatas          (atdatas),
    .atbytess         (atbytess),
    .atreadym         (atreadym),
    .afvalidm         (afvalidm),
    .syncreqm         (syncreqm),
    .atvalidm         (atvalidm),
    .afreadym         (afreadym),
    .atidm            (atidm),
    .atdatam          (atdatam),
    .atbytesm         (atbytesm),
    .atreadys         (atreadys),
    .afvalids         (afvalids),
    .syncreqs         (syncreqs)
  );
endmodule

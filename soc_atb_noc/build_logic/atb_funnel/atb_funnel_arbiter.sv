module atb_funnel_arbiter #(
  parameter integer unsigned ATB_DATA_WIDTH  = 64,
  parameter integer unsigned ATB_BYTES_WIDTH =
    (ATB_DATA_WIDTH == 32)  ? 2 :
    (ATB_DATA_WIDTH == 64)  ? 3 :
    (ATB_DATA_WIDTH == 128) ? 4 : 3,
  parameter integer unsigned ATB_ID_WIDTH    = 7,
  parameter integer unsigned N_ATB           = `ATB_FUNNEL_N_ATB,
  parameter integer unsigned HOLD_WIDTH      = `ATB_FUNNEL_HOLD_WIDTH,
  parameter integer unsigned SEL_WIDTH       = (N_ATB <= 1) ? 1 : $clog2(N_ATB),
  parameter integer unsigned PRI_WIDTH       = (N_ATB <= 2) ? 1 : $clog2(N_ATB)
) (
  input  logic                                  clk,
  input  logic                                  resetn,
  input  logic                                  itc_reg,
  input  logic [8:0]                            it_atb_data_0_reg,
  input  logic [HOLD_WIDTH-1:0]                 min_hold_time,
  input  logic [N_ATB-1:0]                      en_ports,
  input  logic [N_ATB-1:0][PRI_WIDTH-1:0]       pri_ports,
  input  logic [N_ATB-1:0]                      atvalids,
  input  logic [N_ATB-1:0]                      afreadys,
  input  logic [N_ATB-1:0][ATB_ID_WIDTH-1:0]    atids,
  input  logic [N_ATB-1:0][ATB_DATA_WIDTH-1:0]  atdatas,
  input  logic [N_ATB-1:0][ATB_BYTES_WIDTH-1:0] atbytess,
  input  logic                                  atreadym,
  input  logic                                  afvalidm,
  input  logic                                  syncreqm,
  output logic                                  atvalidm,
  output logic                                  afreadym,
  output logic [ATB_ID_WIDTH-1:0]               atidm,
  output logic [ATB_DATA_WIDTH-1:0]             atdatam,
  output logic [ATB_BYTES_WIDTH-1:0]            atbytesm,
  output logic [N_ATB-1:0]                      atreadys,
  output logic [N_ATB-1:0]                      afvalids,
  output logic [N_ATB-1:0]                      syncreqs
);
  logic [N_ATB-1:0]                candidate_valid;
  logic [SEL_WIDTH-1:0]            current_sel;
  logic [SEL_WIDTH-1:0]            sel_next;
  logic [PRI_WIDTH-1:0]            best_pri;
  logic [SEL_WIDTH-1:0]            best_idx;
  logic                            best_valid;
  logic                            selected_valid;
  logic [HOLD_WIDTH-1:0]           hold_cnt;
  logic [ATB_DATA_WIDTH-1:0]       data_with_itm;
  integer                          i;

  always_comb begin
    candidate_valid = atvalids & en_ports;
    best_pri = {PRI_WIDTH{1'b1}};
    best_idx = '0;
    best_valid = 1'b0;
    for (i = 0; i < N_ATB; i = i + 1) begin
      if (candidate_valid[i] && (!best_valid || (pri_ports[i] < best_pri))) begin
        best_valid = 1'b1;
        best_pri = pri_ports[i];
        best_idx = i[SEL_WIDTH-1:0];
      end
    end

    sel_next = current_sel;
    if (!en_ports[current_sel] || !atvalids[current_sel]) begin
      sel_next = best_idx;
    end else if (!candidate_valid[current_sel] && best_valid) begin
      sel_next = best_idx;
    end
  end

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_sel <= '0;
      hold_cnt    <= '0;
    end else if (hold_cnt == '0) begin
      current_sel <= sel_next;
      hold_cnt    <= min_hold_time;
    end else if (!atvalids[current_sel] || !en_ports[current_sel]) begin
      current_sel <= sel_next;
      hold_cnt    <= min_hold_time;
    end else if (atreadym && atvalids[current_sel] && en_ports[current_sel]) begin
      hold_cnt <= hold_cnt - {{(HOLD_WIDTH-1){1'b0}}, 1'b1};
    end
  end

  always_comb begin
    data_with_itm = atdatas[current_sel];
    if (ATB_DATA_WIDTH >= 64) begin
      data_with_itm[63] = it_atb_data_0_reg[8];
      data_with_itm[55] = it_atb_data_0_reg[7];
      data_with_itm[47] = it_atb_data_0_reg[6];
      data_with_itm[39] = it_atb_data_0_reg[5];
      data_with_itm[31] = it_atb_data_0_reg[4];
      data_with_itm[23] = it_atb_data_0_reg[3];
      data_with_itm[15] = it_atb_data_0_reg[2];
      data_with_itm[7]  = it_atb_data_0_reg[1];
      data_with_itm[0]  = it_atb_data_0_reg[0];
    end
  end

  always_comb begin
    atvalidm = 1'b0;
    atidm    = '0;
    atdatam  = '0;
    atbytesm = '0;
    afreadym = 1'b0;
    atreadys = ~en_ports;
    afvalids = '0;
    syncreqs = syncreqm ? en_ports : '0;

    selected_valid = en_ports[current_sel] && atvalids[current_sel];
    if (selected_valid) begin
      atvalidm = 1'b1;
      atidm    = atids[current_sel];
      atdatam  = itc_reg ? data_with_itm : atdatas[current_sel];
      atbytesm = atbytess[current_sel];

      atreadys[current_sel] = atreadym;
      afvalids[current_sel] = afvalidm;
      afreadym              = afreadys[current_sel];
    end
  end
endmodule

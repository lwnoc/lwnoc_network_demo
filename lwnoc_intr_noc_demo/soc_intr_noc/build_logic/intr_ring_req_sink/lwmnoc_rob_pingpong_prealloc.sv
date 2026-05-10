module lwmnoc_rob_pingpong_prealloc #(
    parameter  integer unsigned ROB_ENTRY_NUM     = `INTR_NETWORK_ROB_ENTRY_NUM,
    localparam integer unsigned ROB_ENTRY_WIDTH   = $clog2(ROB_ENTRY_NUM)
) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic [ROB_ENTRY_NUM-1:0]     v_in_vld,
    output logic [ROB_ENTRY_NUM-1:0]     v_in_rdy,
    output logic                         out_vld,
    input  logic                         out_rdy,
    output logic [ROB_ENTRY_WIDTH-1:0]   out_pld,
    output logic [ROB_ENTRY_NUM-1:0]     out_pld_oh
);

localparam EVN_ENTRY_NUM = (ROB_ENTRY_NUM >> 1) + ROB_ENTRY_NUM[0];
localparam ODD_ENTRY_NUM = ROB_ENTRY_NUM >> 1;

logic [ODD_ENTRY_NUM-1:0]       odd_in_vld;
logic [ODD_ENTRY_NUM-1:0]       odd_in_rdy;
logic [EVN_ENTRY_NUM-1:0]       evn_in_vld;
logic [EVN_ENTRY_NUM-1:0]       evn_in_rdy;

logic [ODD_ENTRY_NUM-1:0]       odd_grt_oh;
logic [EVN_ENTRY_NUM-1:0]       evn_grt_oh;

logic [ROB_ENTRY_NUM-1:0]       out_grt_oh;

logic last_grant;
logic odd_vld   ;
logic evn_vld   ;
logic odd_rdy_en;
logic evn_rdy_en;

genvar i;
generate for (i=0; i<ODD_ENTRY_NUM; i++) begin: GEN_ODD_IN_VLD
    assign odd_in_vld[i]     = v_in_vld[i*2+1];
    assign odd_in_rdy[i]     = odd_grt_oh[i] & odd_rdy_en & out_rdy;
    assign v_in_rdy  [i*2+1] = odd_in_rdy[i];
    assign out_grt_oh[i*2+1] = odd_grt_oh[i] && odd_rdy_en;
end
endgenerate

genvar j;
generate for (j=0; j<EVN_ENTRY_NUM; j++) begin: GEN_EVN_IN_VLD
    assign evn_in_vld[j]     = v_in_vld[j*2];
    assign evn_in_rdy[j]     = evn_grt_oh[j] & evn_rdy_en & out_rdy;
    assign v_in_rdy  [j*2]   = evn_in_rdy[j];
    assign out_grt_oh[j*2]   = evn_grt_oh[j] && evn_rdy_en;
end
endgenerate

assign odd_grt_oh = odd_in_vld & ~(odd_in_vld - 1'b1);
assign evn_grt_oh = evn_in_vld & ~(evn_in_vld - 1'b1);

assign odd_vld = |odd_grt_oh;
assign evn_vld = |evn_grt_oh;

assign odd_rdy_en = (odd_vld && evn_vld) ? ~last_grant : odd_vld;
assign evn_rdy_en = (odd_vld && evn_vld) ?  last_grant : evn_vld;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        last_grant <= 1'b1;
    end else if (out_vld && out_rdy) begin
        case({odd_vld, evn_vld})
            2'b11: last_grant <= ~last_grant;
            2'b10: last_grant <= 1'b1;
            2'b01: last_grant <= 1'b0;
        endcase
    end
end

assign out_vld = odd_vld | evn_vld;
assign out_pld_oh = out_grt_oh;

fcip_onehot2bin #(
    .ONEHOT_WIDTH   (ROB_ENTRY_NUM)
) u_onehot2bin (
    .onehot_in      (out_grt_oh),
    .bin_out        (out_pld)
);
endmodule

module atb_iniu_noc_side #(
  parameter int DATA_W = 128
) (
  input  logic              clk,
  input  logic              rst_n,
  input  logic              in_valid,
  input  logic [DATA_W-1:0] in_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_valid <= 1'b0;
      out_data <= '0;
    end else begin
      out_valid <= in_valid;
      out_data <= in_data;
    end
  end
endmodule

module atb_iniu_sys_side #(
  parameter int DATA_W = 128
) (
  input  logic              clk,
  input  logic              rst_n,
  input  logic              sys_valid,
  input  logic [DATA_W-1:0] sys_data,
  output logic              fabric_valid,
  output logic [DATA_W-1:0] fabric_data
);
  // Keep one pipeline stage at the delivery boundary so sys payload timing is explicit.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      fabric_valid <= 1'b0;
      fabric_data <= '0;
    end else begin
      fabric_valid <= sys_valid;
      fabric_data <= sys_data;
    end
  end
endmodule

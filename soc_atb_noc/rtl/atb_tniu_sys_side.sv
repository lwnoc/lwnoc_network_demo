module atb_tniu_sys_side #(
  parameter int DATA_W = 128
) (
  input  logic              clk,
  input  logic              rst_n,
  input  logic              fabric_valid,
  input  logic [DATA_W-1:0] fabric_data,
  output logic              sys_valid,
  output logic [DATA_W-1:0] sys_data
);
  // Symmetric boundary stage for the sink-side delivery role.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sys_valid <= 1'b0;
      sys_data <= '0;
    end else begin
      sys_valid <= fabric_valid;
      sys_data <= fabric_data;
    end
  end
endmodule

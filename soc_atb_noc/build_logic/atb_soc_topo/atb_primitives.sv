module atb_buffer_stub #(
  parameter int DATA_W = 128,
  parameter bit TIE_OFF = 1'b0
) (
  input  logic              clk,
  input  logic              rst_n,
  input  logic              in_valid,
  input  logic [DATA_W-1:0] in_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  always_comb begin
    if (TIE_OFF) begin
      out_valid = 1'b0;
      out_data = '0;
    end else begin
      out_valid = in_valid;
      out_data = in_data;
    end
  end
endmodule

module atb_upsizer_stub #(
  parameter int IN_W = 32,
  parameter int OUT_W = 128
) (
  input  logic             clk,
  input  logic             rst_n,
  input  logic             in_valid,
  input  logic [IN_W-1:0]  in_data,
  output logic             out_valid,
  output logic [OUT_W-1:0] out_data
);
  // Placeholder policy: tie-off while real upsizer protocol is not available.
  always_comb begin
    out_valid = 1'b0;
    out_data = '0;
  end
endmodule

module atb_node_stub #(
  parameter int DATA_W = 128
) (
  input  logic              clk,
  input  logic              rst_n,
  input  logic              in_valid,
  input  logic [DATA_W-1:0] in_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  // Placeholder policy: tie-off while real async/node logic is not available.
  always_comb begin
    out_valid = 1'b0;
    out_data = '0;
  end
endmodule

module atb_async_bridge #(
  parameter int DATA_W = 128,
  parameter int DEPTH = 4
) (
  input  logic              src_clk,
  input  logic              dst_clk,
  input  logic              rst_n,
  input  logic              in_valid,
  input  logic [DATA_W-1:0] in_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  localparam int PTR_W = $clog2(DEPTH);

  logic [DATA_W-1:0] mem [0:DEPTH-1];

  logic [PTR_W:0] wr_bin;
  logic [PTR_W:0] wr_gray;
  logic [PTR_W:0] rd_bin;
  logic [PTR_W:0] rd_gray;

  logic [PTR_W:0] rd_gray_src_sync_1;
  logic [PTR_W:0] rd_gray_src_sync_2;
  logic [PTR_W:0] wr_gray_dst_sync_1;
  logic [PTR_W:0] wr_gray_dst_sync_2;

  logic [PTR_W:0] wr_bin_next;
  logic [PTR_W:0] wr_gray_next;
  logic [PTR_W:0] rd_bin_next;
  logic [PTR_W:0] rd_gray_next;

  logic fifo_full;
  logic fifo_empty;

  assign wr_bin_next = wr_bin + {{PTR_W{1'b0}}, 1'b1};
  assign wr_gray_next = (wr_bin_next >> 1) ^ wr_bin_next;
  assign rd_bin_next = rd_bin + {{PTR_W{1'b0}}, 1'b1};
  assign rd_gray_next = (rd_bin_next >> 1) ^ rd_bin_next;

  // Full when next write pointer reaches synchronized read pointer with wrapped MSBs.
  assign fifo_full = (wr_gray_next == {~rd_gray_src_sync_2[PTR_W:PTR_W-1], rd_gray_src_sync_2[PTR_W-2:0]});
  assign fifo_empty = (rd_gray == wr_gray_dst_sync_2);

  always_ff @(posedge src_clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_bin <= '0;
      wr_gray <= '0;
      rd_gray_src_sync_1 <= '0;
      rd_gray_src_sync_2 <= '0;
    end else begin
      rd_gray_src_sync_1 <= rd_gray;
      rd_gray_src_sync_2 <= rd_gray_src_sync_1;

      if (in_valid && !fifo_full) begin
        mem[wr_bin[PTR_W-1:0]] <= in_data;
        wr_bin <= wr_bin_next;
        wr_gray <= wr_gray_next;
      end
    end
  end

  always_ff @(posedge dst_clk or negedge rst_n) begin
    if (!rst_n) begin
      rd_bin <= '0;
      rd_gray <= '0;
      wr_gray_dst_sync_1 <= '0;
      wr_gray_dst_sync_2 <= '0;
      out_valid <= 1'b0;
      out_data <= '0;
    end else begin
      wr_gray_dst_sync_1 <= wr_gray;
      wr_gray_dst_sync_2 <= wr_gray_dst_sync_1;

      if (!fifo_empty) begin
        out_valid <= 1'b1;
        out_data <= mem[rd_bin[PTR_W-1:0]];
        rd_bin <= rd_bin_next;
        rd_gray <= rd_gray_next;
      end else begin
        out_valid <= 1'b0;
      end
    end
  end
endmodule

module atb_async_bridge_slv #(
  parameter int DATA_W = 128,
  parameter int DEPTH = 4
) (
  input  logic              clk,
  input  logic              clk_async,
  input  logic              rst_n,
  input  logic              in_valid,
  input  logic [DATA_W-1:0] in_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  atb_async_bridge #(
    .DATA_W(DATA_W),
    .DEPTH(DEPTH)
  ) u_atb_async_bridge_slv (
    .src_clk(clk),
    .dst_clk(clk_async),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_valid(out_valid),
    .out_data(out_data)
  );
endmodule

module atb_async_bridge_mst #(
  parameter int DATA_W = 128,
  parameter int DEPTH = 4
) (
  input  logic              clk,
  input  logic              clk_async,
  input  logic              rst_n,
  input  logic              in_valid,
  input  logic [DATA_W-1:0] in_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  atb_async_bridge #(
    .DATA_W(DATA_W),
    .DEPTH(DEPTH)
  ) u_atb_async_bridge_mst (
    .src_clk(clk_async),
    .dst_clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_valid(out_valid),
    .out_data(out_data)
  );
endmodule

module atb_funnel3 #(
  parameter int DATA_W = 128
) (
  input  logic              in0_valid,
  input  logic [DATA_W-1:0] in0_data,
  input  logic              in1_valid,
  input  logic [DATA_W-1:0] in1_data,
  input  logic              in2_valid,
  input  logic [DATA_W-1:0] in2_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  always_comb begin
    out_valid = 1'b0;
    out_data = '0;
    if (in0_valid) begin
      out_valid = 1'b1;
      out_data = in0_data;
    end else if (in1_valid) begin
      out_valid = 1'b1;
      out_data = in1_data;
    end else if (in2_valid) begin
      out_valid = 1'b1;
      out_data = in2_data;
    end
  end
endmodule

module atb_funnel6 #(
  parameter int DATA_W = 128
) (
  input  logic              in0_valid,
  input  logic [DATA_W-1:0] in0_data,
  input  logic              in1_valid,
  input  logic [DATA_W-1:0] in1_data,
  input  logic              in2_valid,
  input  logic [DATA_W-1:0] in2_data,
  input  logic              in3_valid,
  input  logic [DATA_W-1:0] in3_data,
  input  logic              in4_valid,
  input  logic [DATA_W-1:0] in4_data,
  input  logic              in5_valid,
  input  logic [DATA_W-1:0] in5_data,
  output logic              out_valid,
  output logic [DATA_W-1:0] out_data
);
  always_comb begin
    out_valid = 1'b0;
    out_data = '0;
    if (in0_valid) begin
      out_valid = 1'b1;
      out_data = in0_data;
    end else if (in1_valid) begin
      out_valid = 1'b1;
      out_data = in1_data;
    end else if (in2_valid) begin
      out_valid = 1'b1;
      out_data = in2_data;
    end else if (in3_valid) begin
      out_valid = 1'b1;
      out_data = in3_data;
    end else if (in4_valid) begin
      out_valid = 1'b1;
      out_data = in4_data;
    end else if (in5_valid) begin
      out_valid = 1'b1;
      out_data = in5_data;
    end
  end
endmodule

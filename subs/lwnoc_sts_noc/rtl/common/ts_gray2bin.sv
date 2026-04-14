module ts_gray2bin #(
    parameter int unsigned N = 8,
    parameter int unsigned REG_OUT = 0
) (
    input  logic         clk,
    input  logic         rst_n,
    input  logic [N-1:0] gray,
    output logic [N-1:0] bin
);
    logic [N-1:0] bin_temp;

    // simple combinational conversion: MSB same, lower bits = XOR of higher binary bit and gray bit
    // safe for synthesis; requires N>0
    always_comb begin
        bin_temp = 0;
        if (N > 0) begin
            bin_temp[N-1] = gray[N-1];
            for (int i = N-2; i >= 0; i--) begin
                bin_temp[i] = bin_temp[i+1] ^ gray[i];
            end
        end
    end

    generate
        if (REG_OUT == 0) begin
            assign bin = bin_temp;
        end else begin
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    bin <= '0;
                else
                    bin <= bin_temp;
            end
        end
    endgenerate


endmodule
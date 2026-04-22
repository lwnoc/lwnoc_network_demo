module ts_bin2gray #(
    parameter int unsigned N = 8,
    parameter int unsigned REG_OUT = 0
) (
    input  logic         clk,
    input  logic         rst_n,
    input  logic [N-1:0] bin,
    output logic [N-1:0] gray
);

    logic [N-1:0] gray_temp;
    // binary -> gray: MSB same, lower bits = bin[i+1] ^ bin[i]
    always_comb begin
        gray_temp = '0;
        if (N > 0) begin
            gray_temp[N-1] = bin[N-1];
            for (int i = N-2; i >= 0; i--) begin
                gray_temp[i] = bin[i+1] ^ bin[i];
            end
        end
    end

    generate
        if (REG_OUT == 0) begin
            assign gray = gray_temp;
        end else begin
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    gray <= '0;
                else
                    gray <= gray_temp;
            end
        end
    endgenerate


endmodule

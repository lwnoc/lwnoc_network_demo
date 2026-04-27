module lwnoc_sync_cell #(
    parameter  integer unsigned INIT_VALUE = 0,
    parameter  integer unsigned WIDTH      = 4,
    parameter  integer unsigned SYNC_LEVEL = 3
) (
    input logic [WIDTH-1:0] din,
    input logic             clk,
    input logic             rst_n,
    output logic [WIDTH-1:0] dout
);

genvar i;
generate for (i=0; i<WIDTH; i=i+1) begin: GEN_SYNC
    if(INIT_VALUE[i] == 1'b0) begin: INIT_0
        fcip_sync_arst #(
            .SYN_NUM ( SYNC_LEVEL ),
            .VT_TYPE ( 0          )
        ) u_sync_cell (
            .D          (din[i]     ),
            .SI         (1'b0       ),
            .SE         (1'b0       ),
            .CP         (clk        ),
            .CDN        (rst_n      ),
            .Q          (dout[i]    )
        );
    end else begin : INIT_1
        fcip_sync_aset #(
            .SYN_NUM ( SYNC_LEVEL ),
            .VT_TYPE ( 0          )
        ) u_sync_cell (
            .D   (din[i] ),
            .SI  (1'b0   ),
            .SE  (1'b0   ),
            .CP  (clk    ),
            .SDN (rst_n  ),
            .Q   (dout[i])
        );
    end
end
endgenerate
endmodule

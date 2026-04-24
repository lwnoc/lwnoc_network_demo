module `_PREFIX_(sts_apb_stub_slave)
#(
    parameter integer unsigned ADDR_WIDTH = 32,
    parameter integer unsigned WORD_NUM   = 16,
    parameter logic [31:0] INIT_PATTERN   = 32'h1357_0000
)(
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic                   psel,
    input   logic                   penable,
    input   logic [ADDR_WIDTH-1:0]  paddr,
    input   logic                   pwrite,
    input   logic [31:0]            pwdata,
    input   logic [3:0]             pstrb,
    output  logic                   pready,
    output  logic [31:0]            prdata,
    output  logic                   pslverr
);

    localparam integer unsigned WORD_ADDR_LSB = 2;
    localparam integer unsigned WORD_ADDR_MSB = WORD_ADDR_LSB + $clog2(WORD_NUM) - 1;

    logic [31:0] mem [0:WORD_NUM-1];
    logic [ADDR_WIDTH-WORD_ADDR_LSB-1:0] word_idx_full;
    logic [$clog2(WORD_NUM)-1:0] word_idx;
    logic access_hit;
    integer stall_cycles_cfg;
    integer stall_cycles_left;
    logic access_setup;
    logic access_pending;

    assign word_idx_full = paddr[ADDR_WIDTH-1:WORD_ADDR_LSB];
    assign word_idx      = paddr[WORD_ADDR_MSB:WORD_ADDR_LSB];
    assign access_hit    = (word_idx_full < WORD_NUM);
    assign access_setup = psel && !penable;
    assign pready     = (stall_cycles_left == 0);
    assign pslverr    = psel && penable && !access_hit;
    assign prdata     = access_hit ? mem[word_idx] : 32'hDEAD_BEEF;

    initial begin
        if (!$value$plusargs("APB_STALL_CYCLES=%d", stall_cycles_cfg)) begin
            stall_cycles_cfg = 0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        int idx;

        if (!rst_n) begin
            stall_cycles_left <= 0;
            access_pending    <= 1'b0;
            for (idx = 0; idx < WORD_NUM; idx++) begin
                mem[idx] <= INIT_PATTERN + idx;
            end
        end else begin
            if (access_setup && !access_pending) begin
                access_pending    <= 1'b1;
                stall_cycles_left <= stall_cycles_cfg;
            end else if (access_pending && (stall_cycles_left > 0)) begin
                stall_cycles_left <= stall_cycles_left - 1;
            end

            if (psel && penable && pready) begin
                access_pending <= 1'b0;
            end

            if (psel && penable && pwrite && access_hit) begin
                if (pstrb[0]) mem[word_idx][7:0]   <= pwdata[7:0];
                if (pstrb[1]) mem[word_idx][15:8]  <= pwdata[15:8];
                if (pstrb[2]) mem[word_idx][23:16] <= pwdata[23:16];
                if (pstrb[3]) mem[word_idx][31:24] <= pwdata[31:24];
            end
        end
    end

endmodule
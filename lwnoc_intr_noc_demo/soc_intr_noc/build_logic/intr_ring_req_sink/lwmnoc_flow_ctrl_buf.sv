module  lwmnoc_flow_ctrl_buf #(
    parameter  integer unsigned THREHOLD             = `INTR_NETWORK_FLOW_CTRL_THRESHOLD,
    parameter  type             PLD_TYPE             = logic  ,
    parameter  integer unsigned ADDR_WIDTH           = `INTR_NETWORK_FLOW_CTRL_ADDR_WIDTH,
    localparam integer unsigned FIFO_DEPTH           = 2 ** ADDR_WIDTH,
    localparam integer unsigned PTR_WIDTH            = ADDR_WIDTH + 1,
    localparam integer unsigned DATA_WIDTH           = $bits(PLD_TYPE)
)(
    input  logic                     clk,
    input  logic                     rst_n,

    input  logic                     in_vld,
    input  PLD_TYPE                  in_pld,
    output logic                     in_rdy,

    output logic                     in_afull,

    output logic                     out_vld,
    output PLD_TYPE                  out_pld,
    input  logic                     out_rdy,

    // Bank 0 SRAM interface
    output logic [ADDR_WIDTH-1:0]    sram_0_addr,
    output logic [DATA_WIDTH-1:0]    sram_0_din,
    input  logic [DATA_WIDTH-1:0]    sram_0_dout,
    output logic                     sram_0_en,
    output logic                     sram_0_wren,
    output logic [DATA_WIDTH-1:0]    sram_0_bit_en,

    // Bank 1 SRAM interface
    output logic [ADDR_WIDTH-1:0]    sram_1_addr,
    output logic [DATA_WIDTH-1:0]    sram_1_din,
    input  logic [DATA_WIDTH-1:0]    sram_1_dout,
    output logic                     sram_1_en,
    output logic                     sram_1_wren,
    output logic [DATA_WIDTH-1:0]    sram_1_bit_en
);

// Array intermediaries for fcip_sync_fifo_spram
logic [ADDR_WIDTH-1:0]   int_spram_addr  [1:0];
logic [DATA_WIDTH-1:0]   int_spram_din   [1:0];
logic [DATA_WIDTH-1:0]   int_spram_dout  [1:0];
logic [1:0]              int_spram_en;
logic [1:0]              int_spram_wren;
logic [DATA_WIDTH-1:0]   int_spram_bit_en[1:0];

// Bridge: arrays <-> flat SRAM ports
assign sram_0_addr       = int_spram_addr  [0];
assign sram_0_din        = int_spram_din   [0];
assign int_spram_dout[0] = sram_0_dout;
assign sram_0_en         = int_spram_en    [0];
assign sram_0_wren       = int_spram_wren  [0];
assign sram_0_bit_en     = int_spram_bit_en[0];

assign sram_1_addr       = int_spram_addr  [1];
assign sram_1_din        = int_spram_din   [1];
assign int_spram_dout[1] = sram_1_dout;
assign sram_1_en         = int_spram_en    [1];
assign sram_1_wren       = int_spram_wren  [1];
assign sram_1_bit_en     = int_spram_bit_en[1];

fcip_sync_fifo_spram #(
    .FIFO_DEPTH_PER_GROUP  (FIFO_DEPTH     ),
    .SRAM_GROUP_NUM        (2              ),
    .DATA_WIDTH            ($bits(PLD_TYPE)),
    .ALMOST_FULL_THRESHOLD (2              ),
    .ALMOST_EMPTY_THRESHOLD(2              ),
    .FORWARD_EN            (0              ),
    .ROB_DEPTH             (16             ),
    .SRAM_ACCESS_LATENCY   (1              ),
    .SRAM_REQ_PIPE_STAGE   (0              ),
    .SRAM_RSP_PIPE_STAGE   (0              ),
    .MCP_CYCLE             (1              )
) u_fifo_wrap (
    .clk            (clk                ),
    .rst_n          (rst_n              ),
    .stall          (1'b0               ),
    .clear          (1'b0               ),
    .idle           (/*unused*/         ),
    .write_req_vld  (in_vld             ),
    .write_req_pld  (in_pld             ),
    .write_req_rdy  (in_rdy             ),
    .read_resp_vld  (out_vld            ),
    .read_resp_pld  (out_pld            ),
    .read_resp_rdy  (out_rdy            ),
    .almost_full    (in_afull           ),
    .almost_empty   (/*unused*/         ),
    .empty          (/*unused*/         ),
    .full           (/*unused*/         ),
    .spram_addr     (int_spram_addr     ),
    .spram_din      (int_spram_din      ),
    .spram_dout     (int_spram_dout     ),
    .spram_en       (int_spram_en       ),
    .spram_wren     (int_spram_wren     ),
    .spram_bit_en   (int_spram_bit_en   )
);
endmodule

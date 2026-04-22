module lwnoc_station_buffer #(
    parameter  integer unsigned  VC_BUF_DEPTH     = 32,
    parameter  integer unsigned  VC_AFULL_LEVEL   = 4 ,
    parameter  integer unsigned  PLD_WIDTH        = 128,
    localparam integer unsigned  SRAM_ADDR_WIDTH  = $clog2(VC_BUF_DEPTH) + 2
)(

    input  logic                   clk     ,
    input  logic                   rst_n   ,

    input  logic                   wr_en   ,
    input  logic [PLD_WIDTH-1:0]   wr_data ,
    input  logic [1:0]             wr_vcid ,
    output logic [2:0]             wr_rdy  ,

    output logic                   rd_vld   ,
    output logic [PLD_WIDTH-1:0]   rd_data  ,
    output logic                   rd_is_dn ,
    input  logic                   rd_rdy   ,

    // SRAM interface (external)
    output logic [SRAM_ADDR_WIDTH-1:0]  sram_addr,
    output logic [PLD_WIDTH-1:0]        sram_din,
    input  logic [PLD_WIDTH-1:0]        sram_dout,
    output logic                        sram_en,
    output logic                        sram_wren,
    output logic [PLD_WIDTH-1:0]        sram_bit_en
);

// vc_id = 0 for vc 0, vc_id  = 1 for vc 1, vc_id = 2 for niu station

localparam integer unsigned VC_BUF_ADDR_WIDTH  = $clog2(VC_BUF_DEPTH);
localparam integer unsigned VC_FIFO_PTR_WIDTH  = VC_BUF_ADDR_WIDTH + 1;

logic [VC_FIFO_PTR_WIDTH-1:0]  wr_ptr       [2:0];
logic [VC_FIFO_PTR_WIDTH-1:0]  rd_ptr       [2:0];
logic [2:0]                    wr_ptr_incr       ;
logic [2:0]                    rd_ptr_incr       ;

logic [2:0]                    wr_afull          ;
logic [2:0]                    wr_full           ;
logic [2:0]                    vc_rd_vld         ;
logic [2:0]                    vc_rd_rdy         ;
logic [SRAM_ADDR_WIDTH-1:0]    vc_rd_addr   [2:0];

logic                          ring_rd_vld       ;
logic                          ring_rd_rdy       ;
logic [SRAM_ADDR_WIDTH-1:0]    ring_rd_addr      ;

logic [SRAM_ADDR_WIDTH-1:0]    sram_wr_addr      ;
logic [SRAM_ADDR_WIDTH-1:0]    sram_rdreq_addr   ;
logic                          sram_rdreq_vld    ;
logic                          sram_rdreq_rdy    ;

logic                          read_req_vld      ;
logic                          read_req_rdy      ;
logic [SRAM_ADDR_WIDTH-1:0]    read_req_addr     ;

logic                          read_rsp_vld      ;
logic [PLD_WIDTH-1:0]          read_rsp_data     ;
logic                          read_rsp_rdy      ;
logic                          read_rsp_sideband ;
logic                          unused_write_req_rdy;
logic                          unused_idle       ;

logic                          entry_alloc_en    ;
logic [1:0]                    v_entry_alloc     ;
logic [1:0]                    v_arb_vld         ;
logic [1:0]                    v_arb_rdy         ;
logic [SRAM_ADDR_WIDTH-1:0]    v_arb_pld   [1:0] ;
logic [1:0]                    vv_entry_matrix   [1:0];

assign sram_wr_addr = {wr_vcid, wr_ptr[wr_vcid][VC_BUF_ADDR_WIDTH-1:0]};

genvar i;
generate for (i=0; i<3; i=i+1) begin: GEN_PTR

    assign wr_ptr_incr[i] = wr_en && (wr_vcid == i[1:0]);

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            wr_ptr[i] <= '0;
        end else if(wr_ptr_incr[i]) begin
            wr_ptr[i] <= wr_ptr[i] + 1'b1;
        end
    end

    assign wr_afull[i] = (wr_ptr[i][VC_FIFO_PTR_WIDTH-1] != rd_ptr[i][VC_FIFO_PTR_WIDTH-1]) &&
                         (wr_ptr[i][VC_BUF_ADDR_WIDTH-1:0] + VC_AFULL_LEVEL >= rd_ptr[i][VC_BUF_ADDR_WIDTH-1:0])  ;
    assign wr_full [i] = (wr_ptr[i][VC_FIFO_PTR_WIDTH-1] != rd_ptr[i][VC_FIFO_PTR_WIDTH-1]) &&
                         (wr_ptr[i][VC_BUF_ADDR_WIDTH-1:0] == rd_ptr[i][VC_BUF_ADDR_WIDTH-1:0]);
    assign wr_rdy  [i] = ~wr_afull[i];

    assign rd_ptr_incr[i] = vc_rd_rdy[i] && vc_rd_vld[i];
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            rd_ptr[i] <= '0;
        end else if(rd_ptr_incr[i]) begin
            rd_ptr[i] <= rd_ptr[i] + 1'b1;
        end
    end
    // vc_rd_vld is not empty
    assign vc_rd_vld [i] = (wr_ptr[i] != rd_ptr[i]);
    assign vc_rd_addr[i] = {i[1:0], rd_ptr[i][VC_BUF_ADDR_WIDTH-1:0]};
end
endgenerate

// synthesis translate_off
assert property (@(posedge clk) disable iff (!rst_n)
    wr_en |-> !wr_full[wr_vcid]
) else $error("[lwmoc_station_buffer] write-when-full: wr_vcid=%0d", wr_vcid);
// synthesis translate_on

fcip_mem_fake_2p_mem  #(
    .SRAM_ACCESS_LATENCY (1              ),
    .SRAM_REQ_PIPE_STAGE (0              ),
    .SRAM_RSP_PIPE_STAGE (0              ),
    .SIDEBAND_WIDTH      (1              ),
    .DATA_WIDTH          (PLD_WIDTH      ),
    .ADDR_WIDTH          (SRAM_ADDR_WIDTH),
    .MCP_CYCLE           (1              ),
    .WRITE_BUFFER_SIZE   (4              ),
    .RW_ARBITER_TYPE     (1              ),
    .READ_FORWARD_EN     (0              ),
    .READ_BUFFER_SIZE    (4              ),
    .WRITE_BIT_MASK_EN   (0              )
) u_rb_mem (
    .clk                 (clk                               ),
    .rst_n               (rst_n                             ),
    .write_req_vld       (wr_en                             ),
    .write_req_data      (wr_data                           ),
    .write_req_addr      (sram_wr_addr                      ),
    .write_req_rdy       (unused_write_req_rdy              ),
    .write_req_bit_en    ({PLD_WIDTH{wr_en}}                ),
    .read_req_vld        (read_req_vld                      ),
    .read_req_addr       (read_req_addr                     ),
    .read_req_sideband   (read_req_addr[SRAM_ADDR_WIDTH-1]  ),
    .read_req_rdy        (read_req_rdy                      ),
    .read_resp_vld       (read_rsp_vld                      ),
    .read_resp_data      (read_rsp_data                     ),
    .read_resp_sideband  (read_rsp_sideband                 ),
    .read_resp_rdy       (read_rsp_rdy                      ),

    .spram_addr          (sram_addr                 ),
    .spram_dout          (sram_dout                 ),
    .spram_din           (sram_din                  ),
    .spram_en            (sram_en                   ),
    .spram_wren          (sram_wren                 ),
    .spram_bit_en        (sram_bit_en               ),

    .stall               (1'b0                      ),
    .clear               (1'b0                      ),
    .idle                (unused_idle               )
);

fcip_fix_arb #(
    .PLD_TYPE (logic [SRAM_ADDR_WIDTH-1:0])
) u_ring_vc_arb (
    .clk                (clk             ),
    .rst_n              (rst_n           ),
    .s_vld_priority     (vc_rd_vld   [1] ),
    .s_rdy_priority     (vc_rd_rdy   [1] ),
    .s_pld_priority     (vc_rd_addr  [1] ),
    .s_vld              (vc_rd_vld   [0] ),
    .s_rdy              (vc_rd_rdy   [0] ),
    .s_pld              (vc_rd_addr  [0] ),
    .m_vld              (ring_rd_vld     ),
    .m_rdy              (ring_rd_rdy     ),
    .m_pld              (ring_rd_addr    )
);

assign entry_alloc_en = read_req_vld && read_req_rdy;
assign v_entry_alloc  = v_arb_rdy;

assign v_arb_vld [0] = ring_rd_vld   ;
assign v_arb_vld [1] = vc_rd_vld  [2];

assign v_arb_pld [0] = ring_rd_addr    ;
assign v_arb_pld [1] = vc_rd_addr   [2];

assign ring_rd_rdy   = v_arb_rdy [0];
assign vc_rd_rdy [2] = v_arb_rdy [1];

fcip_age_matrix #(
    .WIDTH (2)
) u_arb_age (
    .clk       (clk             ),
    .rst_n     (rst_n           ),
    .alloc_en  (entry_alloc_en  ),
    .v_alloc   (v_entry_alloc   ),
    .vv_matrix (vv_entry_matrix )
);

fcip_arb_vrp_matrix #(
    .WIDTH (2),
    .PLD_WIDTH (SRAM_ADDR_WIDTH)
) u_vrp_arb (
    .clk       (clk             ),
    .rst_n     (rst_n           ),
    .vv_matrix (vv_entry_matrix ),
    .v_vld_s   (v_arb_vld       ),
    .v_rdy_s   (v_arb_rdy       ),
    .v_pld_s   (v_arb_pld       ),
    .vld_m     (read_req_vld    ),
    .rdy_m     (read_req_rdy    ),
    .pld_m     (read_req_addr   )
);

assign rd_vld       = read_rsp_vld ;
assign rd_data      = read_rsp_data;
assign rd_is_dn     = read_rsp_sideband;
assign read_rsp_rdy = rd_rdy       ;

endmodule

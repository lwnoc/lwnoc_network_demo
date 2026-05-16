// Translate vld/rdy protocol to APB

module sts_noc_ddr_ss_tniu_sts_tniu_apb
import sts_noc_ddr_ss_tniu_lwnoc_sts_pack::*;
#(
    parameter integer unsigned APB_ADDR_WIDTH  = 32
)
(
    input   logic                       clk      ,
    input   logic                       rst_n    ,
    input   logic                       in_req_vld,
    input   sts_req_typ                 in_req_pld,
    output  logic                       in_req_rdy,
    output  logic                       out_rsp_vld,
    output  sts_rsp_typ                 out_rsp_pld,
    input   logic                       out_rsp_rdy,

    output  logic                       psel   ,
    output  logic                       penable,
    output  logic [APB_ADDR_WIDTH-1:0]  paddr  ,
    output  logic [TGT_ID_WIDTH-1:0]    ptgt_id,
    output  logic                       pwrite ,
    output  logic [31:0]                pwdata ,
    input   logic [31:0]                prdata ,
    input   logic                       pready ,
    output  logic [3:0]                 pstrb  ,
    output  logic [2:0]                 pprot  ,
    input   logic                       pslverr
);

logic                       fifo_out_req_vld;
sts_req_typ                 fifo_out_req_pld;
logic                       fifo_out_req_rdy;
logic                       fifo_in_req_vld;
logic                       fifo_in_req_rdy;
logic                       fifo_in_rsp_vld;
logic                       fifo_in_rsp_rdy;
logic                       rsp_pending;

typedef enum logic [1:0] {
    APB_IDLE,
    APB_SETUP,
    APB_ACCESS,
    APB_RESP
} apb_state_t;

apb_state_t                 apb_state;
sts_req_typ                 req_active_pld;
sts_rsp_typ                 rsp_pld_r;

logic req_accept;

//====================== Request Channel ====================//

assign in_req_rdy       = (apb_state == APB_IDLE) && !rsp_pending;
assign req_accept       = in_req_vld && in_req_rdy;
assign fifo_in_req_vld  = in_req_vld;
assign fifo_in_req_rdy  = in_req_rdy;
assign fifo_out_req_vld = in_req_vld;
assign fifo_out_req_pld = in_req_pld;

assign psel            = (apb_state == APB_SETUP) || (apb_state == APB_ACCESS);
assign penable         = (apb_state == APB_ACCESS);
assign fifo_out_req_rdy = in_req_rdy;

assign ptgt_id = req_active_pld.cmn.tgt_id;
assign pwrite  = (req_active_pld.cmn.opcode == cfgOpcode_WrReq) ? 1'b1:1'b0;
assign pwdata  = req_active_pld.req.data;
assign pstrb   = req_active_pld.req.strb;

assign pprot  = req_active_pld.req.user[2:0];

generate
    if (APB_ADDR_WIDTH == AXI_ADDR_WIDTH) begin : g_paddr_same_width
        assign paddr = req_active_pld.req.addr;
    end else if (APB_ADDR_WIDTH > AXI_ADDR_WIDTH) begin : g_paddr_extend
        assign paddr = {{(APB_ADDR_WIDTH-AXI_ADDR_WIDTH){1'b0}}, req_active_pld.req.addr};
    end else begin : g_paddr_truncate
        assign paddr = req_active_pld.req.addr[APB_ADDR_WIDTH-1:0];
    end
endgenerate

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        apb_state <= APB_IDLE;
        req_active_pld <= '0;
        rsp_pld_r   <= '0;
        rsp_pending <= 1'b0;
    end else begin
        if (rsp_pending && out_rsp_rdy) begin
            rsp_pending <= 1'b0;
        end

        case (apb_state)
            APB_IDLE: begin
                if(req_accept) begin
                    apb_state <= APB_SETUP;
                    req_active_pld <= in_req_pld;
                end
            end

            APB_SETUP: begin
                apb_state <= APB_ACCESS;
            end

            APB_ACCESS: begin
                if(pready) begin
                    apb_state <= APB_IDLE;
                    rsp_pld_r.cmn.src_id <= req_active_pld.cmn.src_id;
                    rsp_pld_r.cmn.txn_id <= req_active_pld.cmn.txn_id;
                    rsp_pld_r.cmn.tgt_id <= req_active_pld.cmn.tgt_id;
                    rsp_pld_r.cmn.opcode <= (req_active_pld.cmn.opcode == cfgOpcode_RdReq) ? cfgOpcode_RdRsp :
                                            (req_active_pld.cmn.opcode == cfgOpcode_WrReq) ? cfgOpcode_WrRsp : 2'b00;
                    rsp_pld_r.cmn.qos    <= req_active_pld.cmn.qos;
                    rsp_pld_r.rsp.resp   <= pslverr ? 2'b10 : 2'b00;
                    rsp_pld_r.rsp.data   <= prdata;
                    rsp_pld_r.rsp.last   <= req_active_pld.req.last;
                    rsp_pending          <= 1'b1;
                end
            end

            APB_RESP: begin
                apb_state <= APB_IDLE;
            end

            default: begin
                apb_state <= APB_IDLE;
            end
        endcase
    end
end

assign fifo_in_rsp_vld = rsp_pending;
assign fifo_in_rsp_rdy = out_rsp_rdy;
assign out_rsp_vld = rsp_pending;
assign out_rsp_pld = rsp_pld_r;


endmodule

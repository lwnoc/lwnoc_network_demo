module `_PREFIX_(sts_noc_req_router_1to3)
import `_PREFIX_(lwnoc_sts_pack)::*;
#(
    parameter logic [TGT_ID_WIDTH-1:0] T0_ID0 = 8'h40,
    parameter logic [TGT_ID_WIDTH-1:0] T0_ID1 = 8'h41,
    parameter logic [TGT_ID_WIDTH-1:0] T0_ID2 = 8'h50,
    parameter logic [TGT_ID_WIDTH-1:0] T0_ID3 = 8'h51,
    parameter logic [TGT_ID_WIDTH-1:0] T1_ID0 = 8'h42,
    parameter logic [TGT_ID_WIDTH-1:0] T1_ID1 = 8'h43,
    parameter logic [TGT_ID_WIDTH-1:0] T1_ID2 = 8'h52,
    parameter logic [TGT_ID_WIDTH-1:0] T1_ID3 = 8'h53,
    parameter logic [TGT_ID_WIDTH-1:0] T2_ID0 = 8'h44,
    parameter logic [TGT_ID_WIDTH-1:0] T2_ID1 = 8'h45,
    parameter logic [TGT_ID_WIDTH-1:0] T2_ID2 = 8'h54,
    parameter logic [TGT_ID_WIDTH-1:0] T2_ID3 = 8'h55
)(
    input   logic       in_req_vld,
    output  logic       in_req_rdy,
    input   sts_req_typ in_req_pld,

    output  logic       tniu0_req_vld,
    input   logic       tniu0_req_rdy,
    output  sts_req_typ tniu0_req_pld,

    output  logic       tniu1_req_vld,
    input   logic       tniu1_req_rdy,
    output  sts_req_typ tniu1_req_pld,

    output  logic       tniu2_req_vld,
    input   logic       tniu2_req_rdy,
    output  sts_req_typ tniu2_req_pld,

    output  logic       decerr_rsp_vld,
    input   logic       decerr_rsp_rdy,
    output  sts_rsp_typ decerr_rsp_pld
);

    logic hit_tniu0;
    logic hit_tniu1;
    logic hit_tniu2;
    logic hit_any;

    assign hit_tniu0 = in_req_vld && (
        (in_req_pld.cmn.tgt_id == T0_ID0) ||
        (in_req_pld.cmn.tgt_id == T0_ID1) ||
        (in_req_pld.cmn.tgt_id == T0_ID2) ||
        (in_req_pld.cmn.tgt_id == T0_ID3)
    );
    assign hit_tniu1 = in_req_vld && (
        (in_req_pld.cmn.tgt_id == T1_ID0) ||
        (in_req_pld.cmn.tgt_id == T1_ID1) ||
        (in_req_pld.cmn.tgt_id == T1_ID2) ||
        (in_req_pld.cmn.tgt_id == T1_ID3)
    );
    assign hit_tniu2 = in_req_vld && (
        (in_req_pld.cmn.tgt_id == T2_ID0) ||
        (in_req_pld.cmn.tgt_id == T2_ID1) ||
        (in_req_pld.cmn.tgt_id == T2_ID2) ||
        (in_req_pld.cmn.tgt_id == T2_ID3)
    );
    assign hit_any   = hit_tniu0 || hit_tniu1 || hit_tniu2;

    assign tniu0_req_vld = hit_tniu0;
    assign tniu1_req_vld = hit_tniu1;
    assign tniu2_req_vld = hit_tniu2;
    assign tniu0_req_pld = in_req_pld;
    assign tniu1_req_pld = in_req_pld;
    assign tniu2_req_pld = in_req_pld;

    assign decerr_rsp_vld             = in_req_vld && !hit_any;
    assign decerr_rsp_pld.cmn.src_id  = in_req_pld.cmn.src_id;
    assign decerr_rsp_pld.cmn.txn_id  = in_req_pld.cmn.txn_id;
    assign decerr_rsp_pld.cmn.tgt_id  = in_req_pld.cmn.tgt_id;
    assign decerr_rsp_pld.cmn.opcode  = (in_req_pld.cmn.opcode == cfgOpcode_RdReq) ? cfgOpcode_RdRsp : cfgOpcode_WrRsp;
    assign decerr_rsp_pld.cmn.qos     = in_req_pld.cmn.qos;
    assign decerr_rsp_pld.rsp.resp    = 2'b11;
    assign decerr_rsp_pld.rsp.data    = 32'hDEAD_BEEF;
    assign decerr_rsp_pld.rsp.last    = 1'b1;

    assign in_req_rdy = hit_tniu0 ? tniu0_req_rdy :
                        hit_tniu1 ? tniu1_req_rdy :
                        hit_tniu2 ? tniu2_req_rdy :
                                    decerr_rsp_rdy;

endmodule
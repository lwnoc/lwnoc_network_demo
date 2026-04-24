module `_PREFIX_(sts_noc_rsp_mux_3to1)
import `_PREFIX_(lwnoc_sts_pack)::*;
(
    input   logic       in0_rsp_vld,
    output  logic       in0_rsp_rdy,
    input   sts_rsp_typ in0_rsp_pld,

    input   logic       in1_rsp_vld,
    output  logic       in1_rsp_rdy,
    input   sts_rsp_typ in1_rsp_pld,

    input   logic       in2_rsp_vld,
    output  logic       in2_rsp_rdy,
    input   sts_rsp_typ in2_rsp_pld,

    input   logic       decerr_rsp_vld,
    output  logic       decerr_rsp_rdy,
    input   sts_rsp_typ decerr_rsp_pld,

    output  logic       out_rsp_vld,
    input   logic       out_rsp_rdy,
    output  sts_rsp_typ out_rsp_pld
);

    always_comb begin
        out_rsp_vld    = 1'b0;
        out_rsp_pld    = '0;
        in0_rsp_rdy    = 1'b0;
        in1_rsp_rdy    = 1'b0;
        in2_rsp_rdy    = 1'b0;
        decerr_rsp_rdy = 1'b0;

        if (decerr_rsp_vld) begin
            out_rsp_vld    = decerr_rsp_vld;
            out_rsp_pld    = decerr_rsp_pld;
            decerr_rsp_rdy = out_rsp_rdy;
        end else if (in0_rsp_vld) begin
            out_rsp_vld = in0_rsp_vld;
            out_rsp_pld = in0_rsp_pld;
            in0_rsp_rdy = out_rsp_rdy;
        end else if (in1_rsp_vld) begin
            out_rsp_vld = in1_rsp_vld;
            out_rsp_pld = in1_rsp_pld;
            in1_rsp_rdy = out_rsp_rdy;
        end else if (in2_rsp_vld) begin
            out_rsp_vld = in2_rsp_vld;
            out_rsp_pld = in2_rsp_pld;
            in2_rsp_rdy = out_rsp_rdy;
        end
    end

endmodule
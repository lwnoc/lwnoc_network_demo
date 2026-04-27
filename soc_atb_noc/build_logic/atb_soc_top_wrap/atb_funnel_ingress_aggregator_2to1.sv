// atb_funnel_ingress_aggregator_2to1.sv — 2-to-1 per-channel ATB aggregator.

module atb_funnel_ingress_aggregator_2to1 #(
    parameter int unsigned ATB_DATA_WIDTH = 128,
    parameter int unsigned ATB_ID_WIDTH = 7
) (
    input  logic ch0_m_atvalid,
    output logic ch0_m_atready,
    input  logic [3:0] ch0_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch0_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch0_m_atid,
    output logic ch0_m_afvalid,
    input  logic ch0_m_afready,
    output logic ch0_m_syncreq,
    input  logic ch0_m_atwakeup,
    input  logic ch1_m_atvalid,
    output logic ch1_m_atready,
    input  logic [3:0] ch1_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch1_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch1_m_atid,
    output logic ch1_m_afvalid,
    input  logic ch1_m_afready,
    output logic ch1_m_syncreq,
    input  logic ch1_m_atwakeup,
    output logic [2-1:0] atvalids,
    output logic [2-1:0] afreadys,
    output logic [2-1:0][ATB_ID_WIDTH-1:0] atids,
    output logic [2-1:0][ATB_DATA_WIDTH-1:0] atdatas,
    output logic [2-1:0][3:0] atbytess,
    input  logic [2-1:0] atreadys,
    input  logic [2-1:0] afvalids,
    input  logic [2-1:0] syncreqs
);
    genvar i;
    generate for(i=0;i<2;i++) begin:g
        if(i==0)begin assign atvalids[i]=ch0_m_atvalid;assign afreadys[i]=ch0_m_afready;assign atids[i]=ch0_m_atid;assign atdatas[i]=ch0_m_atdata;assign atbytess[i]=ch0_m_atbytes;end
        else if(i==1)begin assign atvalids[i]=ch1_m_atvalid;assign afreadys[i]=ch1_m_afready;assign atids[i]=ch1_m_atid;assign atdatas[i]=ch1_m_atdata;assign atbytess[i]=ch1_m_atbytes;end
    end endgenerate
    generate for(i=0;i<2;i++) begin:u
        if(i==0)begin assign ch0_m_atready=atreadys[0];assign ch0_m_afvalid=afvalids[0];assign ch0_m_syncreq=syncreqs[0];end
        else if(i==1)begin assign ch1_m_atready=atreadys[1];assign ch1_m_afvalid=afvalids[1];assign ch1_m_syncreq=syncreqs[1];end
    end endgenerate
endmodule

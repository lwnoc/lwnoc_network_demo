// atb_funnel_ingress_aggregator_5to1.sv — 5-to-1 per-channel ATB aggregator.

module atb_funnel_ingress_aggregator_5to1 #(
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
    input  logic ch2_m_atvalid,
    output logic ch2_m_atready,
    input  logic [3:0] ch2_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch2_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch2_m_atid,
    output logic ch2_m_afvalid,
    input  logic ch2_m_afready,
    output logic ch2_m_syncreq,
    input  logic ch2_m_atwakeup,
    input  logic ch3_m_atvalid,
    output logic ch3_m_atready,
    input  logic [3:0] ch3_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch3_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch3_m_atid,
    output logic ch3_m_afvalid,
    input  logic ch3_m_afready,
    output logic ch3_m_syncreq,
    input  logic ch3_m_atwakeup,
    input  logic ch4_m_atvalid,
    output logic ch4_m_atready,
    input  logic [3:0] ch4_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch4_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch4_m_atid,
    output logic ch4_m_afvalid,
    input  logic ch4_m_afready,
    output logic ch4_m_syncreq,
    input  logic ch4_m_atwakeup,
    output logic [5-1:0] atvalids,
    output logic [5-1:0] afreadys,
    output logic [5-1:0][ATB_ID_WIDTH-1:0] atids,
    output logic [5-1:0][ATB_DATA_WIDTH-1:0] atdatas,
    output logic [5-1:0][3:0] atbytess,
    input  logic [5-1:0] atreadys,
    input  logic [5-1:0] afvalids,
    input  logic [5-1:0] syncreqs
);
    genvar i;
    generate for(i=0;i<5;i++) begin:g
        if(i==0)begin assign atvalids[i]=ch0_m_atvalid;assign afreadys[i]=ch0_m_afready;assign atids[i]=ch0_m_atid;assign atdatas[i]=ch0_m_atdata;assign atbytess[i]=ch0_m_atbytes;end
        else if(i==1)begin assign atvalids[i]=ch1_m_atvalid;assign afreadys[i]=ch1_m_afready;assign atids[i]=ch1_m_atid;assign atdatas[i]=ch1_m_atdata;assign atbytess[i]=ch1_m_atbytes;end
        else if(i==2)begin assign atvalids[i]=ch2_m_atvalid;assign afreadys[i]=ch2_m_afready;assign atids[i]=ch2_m_atid;assign atdatas[i]=ch2_m_atdata;assign atbytess[i]=ch2_m_atbytes;end
        else if(i==3)begin assign atvalids[i]=ch3_m_atvalid;assign afreadys[i]=ch3_m_afready;assign atids[i]=ch3_m_atid;assign atdatas[i]=ch3_m_atdata;assign atbytess[i]=ch3_m_atbytes;end
        else if(i==4)begin assign atvalids[i]=ch4_m_atvalid;assign afreadys[i]=ch4_m_afready;assign atids[i]=ch4_m_atid;assign atdatas[i]=ch4_m_atdata;assign atbytess[i]=ch4_m_atbytes;end
    end endgenerate
    generate for(i=0;i<5;i++) begin:u
        if(i==0)begin assign ch0_m_atready=atreadys[0];assign ch0_m_afvalid=afvalids[0];assign ch0_m_syncreq=syncreqs[0];end
        else if(i==1)begin assign ch1_m_atready=atreadys[1];assign ch1_m_afvalid=afvalids[1];assign ch1_m_syncreq=syncreqs[1];end
        else if(i==2)begin assign ch2_m_atready=atreadys[2];assign ch2_m_afvalid=afvalids[2];assign ch2_m_syncreq=syncreqs[2];end
        else if(i==3)begin assign ch3_m_atready=atreadys[3];assign ch3_m_afvalid=afvalids[3];assign ch3_m_syncreq=syncreqs[3];end
        else if(i==4)begin assign ch4_m_atready=atreadys[4];assign ch4_m_afvalid=afvalids[4];assign ch4_m_syncreq=syncreqs[4];end
    end endgenerate
endmodule

// atb_funnel_ingress_aggregator_12to1.sv — 12-to-1 per-channel ATB aggregator.

module atb_funnel_ingress_aggregator_12to1 #(
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
    input  logic ch5_m_atvalid,
    output logic ch5_m_atready,
    input  logic [3:0] ch5_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch5_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch5_m_atid,
    output logic ch5_m_afvalid,
    input  logic ch5_m_afready,
    output logic ch5_m_syncreq,
    input  logic ch5_m_atwakeup,
    input  logic ch6_m_atvalid,
    output logic ch6_m_atready,
    input  logic [3:0] ch6_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch6_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch6_m_atid,
    output logic ch6_m_afvalid,
    input  logic ch6_m_afready,
    output logic ch6_m_syncreq,
    input  logic ch6_m_atwakeup,
    input  logic ch7_m_atvalid,
    output logic ch7_m_atready,
    input  logic [3:0] ch7_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch7_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch7_m_atid,
    output logic ch7_m_afvalid,
    input  logic ch7_m_afready,
    output logic ch7_m_syncreq,
    input  logic ch7_m_atwakeup,
    input  logic ch8_m_atvalid,
    output logic ch8_m_atready,
    input  logic [3:0] ch8_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch8_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch8_m_atid,
    output logic ch8_m_afvalid,
    input  logic ch8_m_afready,
    output logic ch8_m_syncreq,
    input  logic ch8_m_atwakeup,
    input  logic ch9_m_atvalid,
    output logic ch9_m_atready,
    input  logic [3:0] ch9_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch9_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch9_m_atid,
    output logic ch9_m_afvalid,
    input  logic ch9_m_afready,
    output logic ch9_m_syncreq,
    input  logic ch9_m_atwakeup,
    input  logic ch10_m_atvalid,
    output logic ch10_m_atready,
    input  logic [3:0] ch10_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch10_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch10_m_atid,
    output logic ch10_m_afvalid,
    input  logic ch10_m_afready,
    output logic ch10_m_syncreq,
    input  logic ch10_m_atwakeup,
    input  logic ch11_m_atvalid,
    output logic ch11_m_atready,
    input  logic [3:0] ch11_m_atbytes,
    input  logic [ATB_DATA_WIDTH-1:0] ch11_m_atdata,
    input  logic [ATB_ID_WIDTH-1:0] ch11_m_atid,
    output logic ch11_m_afvalid,
    input  logic ch11_m_afready,
    output logic ch11_m_syncreq,
    input  logic ch11_m_atwakeup,
    output logic [12-1:0] atvalids,
    output logic [12-1:0] afreadys,
    output logic [12-1:0][ATB_ID_WIDTH-1:0] atids,
    output logic [12-1:0][ATB_DATA_WIDTH-1:0] atdatas,
    output logic [12-1:0][3:0] atbytess,
    input  logic [12-1:0] atreadys,
    input  logic [12-1:0] afvalids,
    input  logic [12-1:0] syncreqs
);
    genvar i;
    generate for(i=0;i<12;i++) begin:g
        if(i==0)begin assign atvalids[i]=ch0_m_atvalid;assign afreadys[i]=ch0_m_afready;assign atids[i]=ch0_m_atid;assign atdatas[i]=ch0_m_atdata;assign atbytess[i]=ch0_m_atbytes;end
        else if(i==1)begin assign atvalids[i]=ch1_m_atvalid;assign afreadys[i]=ch1_m_afready;assign atids[i]=ch1_m_atid;assign atdatas[i]=ch1_m_atdata;assign atbytess[i]=ch1_m_atbytes;end
        else if(i==2)begin assign atvalids[i]=ch2_m_atvalid;assign afreadys[i]=ch2_m_afready;assign atids[i]=ch2_m_atid;assign atdatas[i]=ch2_m_atdata;assign atbytess[i]=ch2_m_atbytes;end
        else if(i==3)begin assign atvalids[i]=ch3_m_atvalid;assign afreadys[i]=ch3_m_afready;assign atids[i]=ch3_m_atid;assign atdatas[i]=ch3_m_atdata;assign atbytess[i]=ch3_m_atbytes;end
        else if(i==4)begin assign atvalids[i]=ch4_m_atvalid;assign afreadys[i]=ch4_m_afready;assign atids[i]=ch4_m_atid;assign atdatas[i]=ch4_m_atdata;assign atbytess[i]=ch4_m_atbytes;end
        else if(i==5)begin assign atvalids[i]=ch5_m_atvalid;assign afreadys[i]=ch5_m_afready;assign atids[i]=ch5_m_atid;assign atdatas[i]=ch5_m_atdata;assign atbytess[i]=ch5_m_atbytes;end
        else if(i==6)begin assign atvalids[i]=ch6_m_atvalid;assign afreadys[i]=ch6_m_afready;assign atids[i]=ch6_m_atid;assign atdatas[i]=ch6_m_atdata;assign atbytess[i]=ch6_m_atbytes;end
        else if(i==7)begin assign atvalids[i]=ch7_m_atvalid;assign afreadys[i]=ch7_m_afready;assign atids[i]=ch7_m_atid;assign atdatas[i]=ch7_m_atdata;assign atbytess[i]=ch7_m_atbytes;end
        else if(i==8)begin assign atvalids[i]=ch8_m_atvalid;assign afreadys[i]=ch8_m_afready;assign atids[i]=ch8_m_atid;assign atdatas[i]=ch8_m_atdata;assign atbytess[i]=ch8_m_atbytes;end
        else if(i==9)begin assign atvalids[i]=ch9_m_atvalid;assign afreadys[i]=ch9_m_afready;assign atids[i]=ch9_m_atid;assign atdatas[i]=ch9_m_atdata;assign atbytess[i]=ch9_m_atbytes;end
        else if(i==10)begin assign atvalids[i]=ch10_m_atvalid;assign afreadys[i]=ch10_m_afready;assign atids[i]=ch10_m_atid;assign atdatas[i]=ch10_m_atdata;assign atbytess[i]=ch10_m_atbytes;end
        else if(i==11)begin assign atvalids[i]=ch11_m_atvalid;assign afreadys[i]=ch11_m_afready;assign atids[i]=ch11_m_atid;assign atdatas[i]=ch11_m_atdata;assign atbytess[i]=ch11_m_atbytes;end
    end endgenerate
    generate for(i=0;i<12;i++) begin:u
        if(i==0)begin assign ch0_m_atready=atreadys[0];assign ch0_m_afvalid=afvalids[0];assign ch0_m_syncreq=syncreqs[0];end
        else if(i==1)begin assign ch1_m_atready=atreadys[1];assign ch1_m_afvalid=afvalids[1];assign ch1_m_syncreq=syncreqs[1];end
        else if(i==2)begin assign ch2_m_atready=atreadys[2];assign ch2_m_afvalid=afvalids[2];assign ch2_m_syncreq=syncreqs[2];end
        else if(i==3)begin assign ch3_m_atready=atreadys[3];assign ch3_m_afvalid=afvalids[3];assign ch3_m_syncreq=syncreqs[3];end
        else if(i==4)begin assign ch4_m_atready=atreadys[4];assign ch4_m_afvalid=afvalids[4];assign ch4_m_syncreq=syncreqs[4];end
        else if(i==5)begin assign ch5_m_atready=atreadys[5];assign ch5_m_afvalid=afvalids[5];assign ch5_m_syncreq=syncreqs[5];end
        else if(i==6)begin assign ch6_m_atready=atreadys[6];assign ch6_m_afvalid=afvalids[6];assign ch6_m_syncreq=syncreqs[6];end
        else if(i==7)begin assign ch7_m_atready=atreadys[7];assign ch7_m_afvalid=afvalids[7];assign ch7_m_syncreq=syncreqs[7];end
        else if(i==8)begin assign ch8_m_atready=atreadys[8];assign ch8_m_afvalid=afvalids[8];assign ch8_m_syncreq=syncreqs[8];end
        else if(i==9)begin assign ch9_m_atready=atreadys[9];assign ch9_m_afvalid=afvalids[9];assign ch9_m_syncreq=syncreqs[9];end
        else if(i==10)begin assign ch10_m_atready=atreadys[10];assign ch10_m_afvalid=afvalids[10];assign ch10_m_syncreq=syncreqs[10];end
        else if(i==11)begin assign ch11_m_atready=atreadys[11];assign ch11_m_afvalid=afvalids[11];assign ch11_m_syncreq=syncreqs[11];end
    end endgenerate
endmodule

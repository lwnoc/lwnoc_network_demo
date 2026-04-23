package mipi_ss_lw_atb_noc_pack;
    localparam integer unsigned ATB_DATA_WIDTH = 128;
    localparam integer unsigned ATB_ID_WIDTH   = 7;
    localparam integer unsigned ATB_BYTES_WIDTH = $clog2(ATB_DATA_WIDTH/8);//3
    localparam integer unsigned ATB_PLD_WIDTH   = ATB_DATA_WIDTH+ATB_ID_WIDTH+ATB_BYTES_WIDTH+1+1+1;

    typedef struct packed {
        logic [ATB_DATA_WIDTH-1:0]  atdata;
        logic [ATB_ID_WIDTH-1:0]    atid;
        logic [ATB_BYTES_WIDTH-1:0] atbytes;
        logic                       atwakeup;
        logic                       flush_done;
        logic                       sync_req;
    } atb_trans_typ;
endpackage : mipi_ss_lw_atb_noc_pack;
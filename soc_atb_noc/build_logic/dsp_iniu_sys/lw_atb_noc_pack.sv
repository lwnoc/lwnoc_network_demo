package lw_atb_noc_pack;
    localparam integer unsigned ATB_DATA_WIDTH  = `ATB_DATA_WIDTH;
    localparam integer unsigned ATB_ID_WIDTH    = `ATB_ID_WIDTH;
    localparam integer unsigned ATB_BYTES_WIDTH = `ATB_BYTES_WIDTH;
    localparam integer unsigned ATB_PLD_WIDTH   = `ATB_PLD_WIDTH;

    typedef struct packed {
        logic [ATB_DATA_WIDTH-1:0]  atdata;
        logic [ATB_ID_WIDTH-1:0]    atid;
        logic [ATB_BYTES_WIDTH-1:0] atbytes;
        logic                       atwakeup;
        logic                       flush_done;
        logic                       sync_req;
    } atb_trans_typ;
endpackage : lw_atb_noc_pack;

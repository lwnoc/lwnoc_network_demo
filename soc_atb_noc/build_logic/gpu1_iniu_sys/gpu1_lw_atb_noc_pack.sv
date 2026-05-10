package gpu1_lw_atb_noc_pack;
    import lwnoc_lp_struct_package::*;
    import lwnoc_lp_define_package::*;

    localparam integer unsigned ATB_DATA_WIDTH  = `gpu1_ATB_DATA_WIDTH;
    localparam integer unsigned ATB_ID_WIDTH    = `gpu1_ATB_ID_WIDTH;
    localparam integer unsigned ATB_BYTES_WIDTH = `gpu1_ATB_BYTES_WIDTH;
    localparam integer unsigned ATB_PLD_WIDTH   = `gpu1_ATB_PLD_WIDTH;
    localparam int ATB_ECC_OH = ($clog2(ATB_PLD_WIDTH) + ATB_PLD_WIDTH + 1 <= 2**$clog2(ATB_PLD_WIDTH)) ? 8 : 9;
    localparam int ATB_AFIFO_W = ATB_PLD_WIDTH + ATB_ECC_OH + 1;

    // Package-level width constants for module use.
    localparam int ATB_LP_REQ_WIDTH = $bits(lwnoc_lp_req_signal_t);

    typedef struct packed {
        logic [ATB_DATA_WIDTH-1:0]  atdata;
        logic [ATB_ID_WIDTH-1:0]    atid;
        logic [ATB_BYTES_WIDTH-1:0] atbytes;
        logic                       atwakeup;
        logic                       flush_done;
        logic                       sync_req;
    } atb_trans_typ;

    // Width derived from trans type, defined after the typedef for
    // VCS L-2016.06 compatibility (no forward references in packages).
    localparam int ATB_TRANS_WIDTH  = $bits(atb_trans_typ);
endpackage : gpu1_lw_atb_noc_pack;

package dti_iniu_top_display_ss_dti_iniu_pack;

    localparam integer unsigned TBU_NUM_WIDTH             = `dti_iniu_top_display_ss_INIU_TBU_NUM_WIDTH;
    localparam integer unsigned AXIS_MAX_DATA_WIDTH       = `dti_iniu_top_display_ss_INIU_AXIS_MAX_DATA_WIDTH;
    localparam integer unsigned AXIS_DATA_WIDTH           = `dti_iniu_top_display_ss_INIU_AXIS_DATA_WIDTH;
    localparam integer unsigned AXIS_KEEP_WIDTH           = `dti_iniu_top_display_ss_INIU_AXIS_KEEP_WIDTH;
    localparam integer unsigned CUSTOM_DATA_WIDTH         = `dti_iniu_top_display_ss_INIU_CUSTOM_DATA_WIDTH;
    localparam integer unsigned CUSTOM_KEEP_WIDTH         = `dti_iniu_top_display_ss_INIU_CUSTOM_KEEP_WIDTH;

    typedef enum logic [3:0] {
                              DTI_TBU_CONDIS_REQ = 4'h0,
                              DTI_TBU_TRANS_REQ  = 4'h2
                             } m_msg_type_t;

    typedef enum logic [3:0] {
                              DTI_TBU_CONDIS_ACK   = 4'h0,
                              DTI_TBU_TRANS_FAULT  = 4'h1,
                              DTI_TBU_TRANS_RESP   = 4'h2,
                              DTI_TBU_TRANS_RESPEX = 4'h3
                             } s_msg_type_t;

endpackage

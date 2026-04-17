`ifndef tniu1_sys_LWNOC_LP_STRUCT_PACKAGE_SV
`define tniu1_sys_LWNOC_LP_STRUCT_PACKAGE_SV


package lwnoc_lp_struct_package;

    import lwnoc_lp_define_package::*;

    typedef struct packed {
        logic                            stg1_req_or;
        logic                            stg1_req_and;
        logic                            stg1_ack_or;
        logic                            stg1_ack_and;
        logic                            stg2_req_or;
        logic                            stg2_req_and;
        logic                            stg2_ack_or;
        logic                            stg2_ack_and;
        lwnoc_lp_state_t                 state;
        logic                            stg1_dack_and;
        logic                            stg1_dack_or;
    } lwnoc_lp_req_signal_t;




endpackage
`endif // LWNOC_LP_STRUCT_PACKAGE_SV

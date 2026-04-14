`ifndef sys_tcu_LWNOC_LP_STRUCT_PACKAGE_SV
`define sys_tcu_LWNOC_LP_STRUCT_PACKAGE_SV


package lwnoc_lp_struct_package;

    import lwnoc_lp_define_package::*;

    typedef struct packed {
        logic                            stg1_req_or;
        logic                            stg1_req_and;
        logic                            stg2_req_or;
        logic                            stg2_req_and;
        lwnoc_lp_state_t                 state;
        logic                            deny_and;
        logic                            deny_or;
    } lwnoc_lp_req_signal_t;




endpackage
`endif // LWNOC_LP_STRUCT_PACKAGE_SV

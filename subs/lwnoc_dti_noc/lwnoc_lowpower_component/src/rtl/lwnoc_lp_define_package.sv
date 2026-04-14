`ifndef LWNOC_LP_DEFINE_PACKAGE_SV
`define LWNOC_LP_DEFINE_PACKAGE_SV


package lwnoc_lp_define_package;

    // LP MAIN FSM state
    typedef enum logic [2:0] {
        LP_MAIN_STOP ,
        LP_MAIN_ACT_STG1  ,
        LP_MAIN_ACT_STG2  ,
        LP_MAIN_RUN  ,
        LP_MAIN_DEACT_STG1  ,
        LP_MAIN_DEACT_STG2
    } lwnoc_lp_main_fsm_state_t;

    // LP slve adapter cmd
    typedef enum logic [2:0] {
        LP_SLV_CMD_ON        ,
        LP_SLV_CMD_LEVEL1_OFF,
        LP_SLV_CMD_LEVEL2_OFF,
        LP_SLV_CMD_LEVEL3_OFF
    } lwnoc_lp_slv_cmd_t;

    // LP network state
    typedef enum logic [2:0] {
        LP_LEVEL0_NOP     = 3'b000,
        LP_LEVEL1_OFF     = 3'b001,
        LP_LEVEL2_OFF     = 3'b010,
        LP_LEVEL3_OFF     = 3'b100
    } lwnoc_lp_state_t;
    
    // P channel state
    typedef enum logic [1:0] {
        P_POWER_ON       = 2'd0,
        P_LEVEL1_OFF     = 2'd1,
        P_LEVEL2_OFF     = 2'd2,
        P_LEVEL3_OFF     = 2'd3
    } lwnoc_pchannel_state_t;

    // P channel active
    typedef enum logic [1:0] {
        P_OFF      = 2'd0,
        P_ON       = 2'd1
    } lwnoc_pchannel_active_t;
endpackage
`endif // LWNOC_LP_DEFINE_PACKAGE_SV

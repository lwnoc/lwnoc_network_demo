source $env(FDE_HOME)/demo/lint/lint.tcl

fde_add -obj lint.user_config -name user_config -position on {
    set design(top_name)    "dut"
    set design(filelist)    "$env(LWNOC_LOWPOWER_COMPONENT)/src/vc/dut.f"
    set lint(waiver)        "$env(LWNOC_LOWPOWER_COMPONENT)/qc/lint.awl"
    set check(goal)         "fde_lint"

    fde_add_rtl_define -name ASIC_SIM -value 1
}
    
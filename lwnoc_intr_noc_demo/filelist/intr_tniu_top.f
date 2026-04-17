$INTR_NOC_DIR/rtl/interrupt_tniu_define.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_pkg.sv
// LP type packages — needed for slang type resolution; excluded from release build
`ifndef EXCLUDE_FOUNDATION_IP
$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_define_package.sv
$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_struct_package.sv
`endif
$INTR_NOC_DIR/rtl/interrupt_tniu_async_top_side.sv

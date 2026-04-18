// LP type packages — needed for slang type resolution; excluded from release build
`ifndef EXCLUDE_FOUNDATION_IP
$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_define_package.sv
$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_struct_package.sv
`endif
$INTR_NOC_DIR/rtl/interrupt_iniu_define.sv
$INTR_NOC_DIR/rtl/iniu/interrupt_iniu_pkg.sv
$INTR_NOC_DIR/rtl/iniu/interrupt_iniu_event_recorder.sv
$INTR_NOC_DIR/rtl/iniu/interrupt_iniu_lut.sv
$INTR_NOC_DIR/rtl/iniu/interrupt_iniu_reg_bank.sv
$INTR_NOC_DIR/rtl/iniu/interrupt_iniu_arb.sv
$INTR_NOC_DIR/rtl/iniu/interrupt_iniu.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_4096x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_2048x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_1024x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_512x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_256x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_128x20.sv
$INTR_NOC_DIR/rtl/interrupt_iniu_async_sys_side.sv

// LP type packages — needed for slang type resolution; excluded from release build
`ifndef EXCLUDE_FOUNDATION_IP
$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_define_package.sv
$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_struct_package.sv
`endif
$INTR_NOC_DIR/rtl/interrupt_tniu_define.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_pkg.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_mem_reg_bank.sv
$INTR_NOC_DIR/rtl/tniu/Regbank_regbank_tniu_internal_intr.v
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_generate_reg_bank.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_event_conflict_check.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_context.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_context_entry.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_event_repeater.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_event_merge.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu_xbar_internal.sv
$INTR_NOC_DIR/rtl/tniu/interrupt_tniu.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_4096x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_2048x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_1024x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_512x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_256x20.sv
$INTR_NOC_DIR/rtl/mem_wrapper/spram_128x20.sv
$INTR_NOC_DIR/rtl/interrupt_tniu_async_sys_side.sv

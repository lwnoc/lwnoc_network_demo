// Verilator 4.x lint override filelist.
// Lists blackbox stubs and suppression flags for submodule files that
// Verilator 4.x cannot elaborate (large generate-for loops, unsupported
// timing constructs, etc.).
//
// Full invocation:
//   export INTR_NOC_DEMO_DIR=<path-to-soc_intr_noc>
//   verilator --lint-only -sv --bbox-unsup \
//     -Wno-MODDUP -Wno-MULTITOP -Wno-INFINITELOOP -Wno-UNSIGNED -Wno-IMPLICIT \
//     -f $INTR_NOC_DEMO_DIR/build_logic/verilator_patches/verilator_stubs.f \
//     -f $INTR_NOC_DEMO_DIR/build_logic/soc_intr_noc_wrap/filelist.f
//
// Warning suppression rationale:
//   -Wno-MODDUP      : fcip_bin2onehot stub intentionally shadows submodule original
//   -Wno-MULTITOP    : library IP files not connected at top (expected)
//   -Wno-INFINITELOOP: forever loops in mem_model behavioral files (simulation only)
//   -Wno-UNSIGNED    : integer comparison in submodule fcip IP (not RTL functional bug)
//   -Wno-IMPLICIT    : pld_sync_marker* wires in fcip_afifo_slv_doub.sv (submodule, unmodifiable)

$INTR_NOC_DEMO_DIR/build_logic/verilator_patches/fcip_bin2onehot.sv

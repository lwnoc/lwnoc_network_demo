// Common dependencies: FCIP + LP collateral from IP source.
// Included once at top-level compile (Makefile DTI_COMMON_DEP_F).
// Per-block build_logic filelists do NOT duplicate these.
-f $FCIP_DIR/vc/basic.f
-f $FCIP_DIR/vc/async_fifo.f
-f $FCIP_DIR/vc/arbiter.f
-f $LWNOC_LOWPOWER_COMPONENT/src/vc/lwnoc_lp_all.f
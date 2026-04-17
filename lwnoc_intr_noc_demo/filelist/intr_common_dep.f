// Common dependencies: FCIP + LP collateral from IP source.
// Included once at the top level (Makefile COMMON_DEPS_F).
// Per-block filelists do NOT duplicate these — they reference only block RTL.
-f $FCIP_DIR/vc/basic.f
-f $FCIP_DIR/vc/async_fifo.f
-f $FCIP_DIR/vc/arbiter.f
-f $FCIP_DIR/vc/regslice.f
-f $FCIP_DIR/vc/sync_fifo.f
-f $FCIP_DIR/vc/handshake.f
-f $FCIP_DIR/vc/memory.f
-f $FCIP_DIR/vc/mem_model.f
-f $FCIP_DIR/vc/stdcell_wrap.f
-f $LWNOC_LOWPOWER_COMPONENT/src/vc/lwnoc_lp_core.f

// Demo-local INIU top ingress: include SRAM wrappers so prefixed top-side
// memory module names are generated with the INIU top prefix.
`ifndef EXCLUDE_FOUNDATION_IP
    -f $FCIP_DIR/vc/fcip.f
    -f $LWNOC_LOWPOWER_COMPONENT/src/vc/lwnoc_lp_core.f
`endif
-f $INTERRUPT_INIU/vc/iniu_filelist.f
-f $INTERRUPT_TNIU/vc/mem_filelist.f

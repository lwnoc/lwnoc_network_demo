// Local sys-side wrapper: includes LP packages for VComponent type resolution
// (memnoc pattern: sys-side filelist is self-contained with struct packages)
`ifndef EXCLUDE_FOUNDATION_IP
-f $LWNOC_LOWPOWER_COMPONENT/src/vc/lwnoc_lp_core.f
`endif
-f $INTERRUPT_INIU/vc/tniu_filelist.f

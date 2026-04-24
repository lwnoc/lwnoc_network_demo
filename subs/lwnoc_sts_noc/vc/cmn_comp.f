// Shared macro definitions for STS NIU AXI dimensioning
$RTL_PATH/rtl/iniu/sts_iniu_define.sv
`ifndef EXCLUDE_FOUNDATION_IP
    -f $FCIP_DIR/vc/fcip.f
    $FCIP_DIR/bak/fifo/bak/cmn_vrp_reg_fifo.sv
`endif
// Wrapper ingress for common compilation
-f $RTL_PATH/vc/cmn_filelist.f

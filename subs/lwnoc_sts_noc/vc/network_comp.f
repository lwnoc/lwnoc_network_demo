`ifndef EXCLUDE_FOUNDATION_IP
    -f $FCIP_DIR/vc/fcip.f
    $FCIP_DIR/bak/fifo/bak/cmn_vrp_reg_fifo.sv
`endif
// Wrapper ingress for network-only compilation
-f $RTL_PATH/vc/network_filelist.f

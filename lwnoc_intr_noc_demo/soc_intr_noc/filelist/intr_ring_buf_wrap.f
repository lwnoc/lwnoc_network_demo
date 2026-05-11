// Demo-local composite for network wrappers: common + ALL leaf wrappers.
// Common primitives enter compile once via this single release directory.
// soc_intr_ring_req_sink_config uses a separate leaf-only filelist (no overlap).
`ifndef EXCLUDE_FOUNDATION_IP
    -f $FCIP_DIR/vc/fcip.f
    -f $LWNOC_LOWPOWER_COMPONENT/src/vc/lwnoc_lp_core.f
`endif
-f $INTERRUPT_INIU/vc/network_common_pub.f
-f $INTERRUPT_INIU/vc/network_ring_buf_wrap_pub.f
-f $INTERRUPT_INIU/vc/network_ring_sp_wrap_pub.f
-f $INTERRUPT_INIU/vc/network_endpoint_wrap_pub.f
-f $INTERRUPT_INIU/vc/network_async_bridge_pub.f

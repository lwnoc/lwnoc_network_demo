// lwnoc_sync_cell, lwnoc_sfifo, lwnoc_vcbuf, lwnoc_ring_buf are shared with
// intr_ring_network_wrap.f and must NOT be listed here — include them only once
// from the network layer to avoid OPD duplicate-module errors.
//
// fcip_fix_arb and fcip_sync_fifo_reg are provided by intr_common_dep.f and
// must NOT be listed here.
$INTR_NOC_DIR/rtl/intr_ring_buf_wrap.sv
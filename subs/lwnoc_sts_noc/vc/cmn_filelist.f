`ifndef EXCLUDE_FOUNDATION_IP
    -f $FCIP_DIR/vc/fcip.f
    $FCIP_DIR/bak/fifo/bak/cmn_vrp_reg_fifo.sv
`endif

$RTL_PATH/rtl/common/lwnoc_sts_pack.sv
$RTL_PATH/rtl/common/sts_iniu_addr_map.sv
$RTL_PATH/rtl/common/apb2apb_async_bridge_qual.sv
$RTL_PATH/rtl/common/cti_handle.sv
$RTL_PATH/rtl/common/pulse_async_bridge_receiver_qactive.sv
$RTL_PATH/rtl/common/pulse_async_bridge_transmitter_qactive.sv
$RTL_PATH/rtl/common/ts_bin2gray.sv
$RTL_PATH/rtl/common/ts_gray2bin.sv


$RTL_PATH/rtl/common/lwring_id_remap_entry.sv
$RTL_PATH/rtl/common/lwring_id_remap.sv

$RTL_PATH/rtl/common/sts_ctm.sv
$RTL_PATH/rtl/common/sts_noc_dec_node.sv
$RTL_PATH/rtl/common/sts_tniu_apb_dec.sv
// Publish filelist for STS TNIU top — self-contained, no FCIP/LP
// sts_tniu_top instantiates sts_tniu_noc and sts_tniu_sys hierarchically.
// All sub-modules must be included for the unity wrapper to compile.
$RTL_PATH/rtl/tniu/sts_tniu_define.sv
$RTL_PATH/rtl/common/lwnoc_sts_pack.sv
$RTL_PATH/rtl/common/pulse_async_bridge_receiver_qactive.sv
$RTL_PATH/rtl/common/pulse_async_bridge_transmitter_qactive.sv
$RTL_PATH/rtl/common/cti_handle.sv
$RTL_PATH/rtl/reg/build/reg_bank_table/rtl/RegSpaceBase_cfg_reg_bank_table/RegSpaceBase_cfg_reg_bank_table.v
$STS_TNIU/rtl/common/apb2apb_async_bridge_qual.sv
$STS_TNIU/rtl/tniu/sts_tniu_apb.sv
$STS_TNIU/rtl/tniu/sts_tniu_noc_dec2.sv
$STS_TNIU/rtl/tniu/sts_tniu_sys.sv
$STS_TNIU/rtl/tniu/sts_tniu_noc.sv
$STS_TNIU/rtl/tniu/sts_tniu_top.sv
$STS_TNIU/rtl/tniu/sts_tniu_undefine.sv

// Publish filelist for STS TNIU sys — self-contained, no FCIP/LP
// Only includes modules needed by sts_tniu_sys (sys-side endpoint).
// noc/top modules NOT included — those belong in tniu_top or network filelists.
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
$STS_TNIU/rtl/tniu/sts_tniu_undefine.sv

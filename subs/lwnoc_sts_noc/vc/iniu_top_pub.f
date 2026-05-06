// Publish filelist for STS INIU top — self-contained, no FCIP/LP
// sts_iniu_top instantiates sts_iniu_noc and sts_iniu_sys hierarchically.
// All sub-modules must be included for the unity wrapper to compile.
$RTL_PATH/rtl/iniu/sts_iniu_define.sv
$RTL_PATH/rtl/common/lwnoc_sts_pack.sv
$RTL_PATH/rtl/iniu/sts_iniu_axi_bundle.sv
$RTL_PATH/rtl/iniu/sts_iniu_wr_channel.sv
$RTL_PATH/rtl/iniu/sts_iniu_rd_channel.sv
$RTL_PATH/rtl/iniu/sts_iniu_axi_iniu.sv
$RTL_PATH/rtl/iniu/sts_iniu_sys.sv
$RTL_PATH/rtl/iniu/sts_iniu_noc.sv
$RTL_PATH/rtl/iniu/sts_iniu_top.sv
$RTL_PATH/rtl/iniu/sts_iniu_undefine.sv

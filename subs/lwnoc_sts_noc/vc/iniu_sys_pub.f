// Publish filelist for STS INIU sys — self-contained, no FCIP/LP
// Only includes modules needed by sts_iniu_sys (sys-side endpoint).
// noc/top/dec modules NOT included — those belong in iniu_top or network filelists.
$RTL_PATH/rtl/iniu/sts_iniu_define.sv
$RTL_PATH/rtl/common/lwnoc_sts_pack.sv
$RTL_PATH/rtl/iniu/sts_iniu_axi_bundle.sv
$RTL_PATH/rtl/iniu/sts_iniu_wr_channel.sv
$RTL_PATH/rtl/iniu/sts_iniu_rd_channel.sv
$RTL_PATH/rtl/iniu/sts_iniu_axi_iniu.sv
$RTL_PATH/rtl/iniu/sts_iniu_sys.sv
$RTL_PATH/rtl/iniu/sts_iniu_undefine.sv

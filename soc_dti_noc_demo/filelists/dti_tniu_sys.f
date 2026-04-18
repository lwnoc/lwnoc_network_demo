// FCIP/LP dependencies — excluded from release build
`ifndef EXCLUDE_FOUNDATION_IP
-f $DTI_TEST_DIR/filelists/dti_common_dep.f
`endif
$DTI_PR/rtl/dti_tniu_define.sv
$DTI_PR/rtl/tniu/dti_tniu_pack.sv
$DTI_PR/rtl/tniu/gnpd_to_dti_conv.sv
$DTI_PR/rtl/dti_tniu_async_sys_side.sv
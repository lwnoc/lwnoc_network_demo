// FCIP/LP dependencies — excluded from release build
`ifndef EXCLUDE_FOUNDATION_IP
-f $DTI_TEST_DIR/filelists/dti_common_dep.f
`endif
$DTI_PR/rtl/dti_pr_iniu_define.sv
$DTI_PR/rtl/iniu/dti_iniu_pack.sv
$DTI_PR/rtl/dti_pr_iniu_async_top_side.sv
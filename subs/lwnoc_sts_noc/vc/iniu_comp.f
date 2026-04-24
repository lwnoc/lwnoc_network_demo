// Wrapper ingress for INIU compile
// Compile dependencies are layered in wrapper, core list stays standalone.
$RTL_PATH/rtl/iniu/sts_iniu_define.sv
-f $RTL_PATH/vc/cmn_comp.f
// Optional low-power component filelist can be added here if needed.
// -f $LWNOC_LOWPOWER_COMPONENT
-f $RTL_PATH/vc/iniu_filelist.f

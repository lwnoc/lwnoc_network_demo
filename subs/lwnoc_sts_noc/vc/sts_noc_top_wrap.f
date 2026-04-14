// STS NoC top_wrap filelist
// Instantiates: 1x sts_iniu_sys + 1x sts_iniu_noc + 1x sts_tniu_noc + 1x sts_tniu_sys
// Does NOT modify the original per-unit filelists.
//
// Note: sts_iniu_define.sv (from iniu_filelist.f) provides _PREFIX_ for iniu modules.
//       sts_tniu_define.sv (from tniu_filelist.f) provides additional tniu defines.
//       lwnoc_sts_pack.sv is included via tniu_filelist.f.

// INIU side defines and dependencies
-f $STS_INIU/vc/iniu_filelist.f

// TNIU side defines and dependencies
// (includes sts_tniu_define.sv, lwnoc_sts_pack.sv, and tniu RTL modules)
-f $STS_TNIU/vc/tniu_filelist.f

// Foundation IPs (guarded to avoid double-include; iniu_filelist.f already includes cmn)
// If compiling standalone, set EXCLUDE_FOUNDATION_IP=0 or rely on cmn_filelist.f above.

// Top wrapper (depends on both iniu and tniu sub-modules already included above)
$RTL_PATH/rtl/sts_noc_top_wrap.sv

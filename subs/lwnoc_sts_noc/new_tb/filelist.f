// new_tb filelist — RTL + DUT wrapper + new top
$RTL_PATH/rtl/iniu/sts_iniu_define.sv
$RTL_PATH/rtl/common/lwnoc_sts_pack.sv
$RTL_PATH/rtl/network/sts_noc_dec_node.sv

-f $RTL_PATH/vc/cmn_filelist.f

$RTL_PATH/rtl/common/sts_ctm.sv

$STS_INIU/rtl/iniu/sts_iniu_axi_bundle.sv
$STS_INIU/rtl/iniu/sts_iniu_wr_channel.sv
$STS_INIU/rtl/iniu/sts_iniu_rd_channel.sv
$STS_INIU/rtl/iniu/sts_iniu_axi_iniu.sv
$STS_INIU/rtl/iniu/sts_iniu_noc.sv
$STS_INIU/rtl/iniu/sts_iniu_sys.sv
$STS_INIU/rtl/iniu/sts_iniu_top.sv

$RTL_PATH/rtl/reg/build/reg_bank_table/rtl/RegSpaceBase_cfg_reg_bank_table/RegSpaceBase_cfg_reg_bank_table.v
$STS_TNIU/rtl/tniu/sts_tniu_apb.sv
$STS_TNIU/rtl/tniu/sts_tniu_noc_dec2.sv
$STS_TNIU/rtl/tniu/sts_tniu_noc.sv
$STS_TNIU/rtl/tniu/sts_tniu_sys.sv
$STS_TNIU/rtl/tniu/sts_tniu_top.sv

$RTL_PATH/testbench/dut/sts_apb_stub_slave.sv
$RTL_PATH/testbench/dut/sts_noc_req_router_1to3.sv
$RTL_PATH/testbench/dut/sts_noc_rsp_mux_3to1.sv
$RTL_PATH/testbench/dut/sts_noc_1iniu_3tniu_dut.sv

$RTL_PATH/new_tb/top.sv
$STS_INIU/rtl/iniu/sts_iniu_undefine.sv
-f $FCIP_DIR/vc/fcip.f
// stub_cmn_vrp_reg_fifo.sv removed — all instances migrated to fcip_sync_fifo_reg

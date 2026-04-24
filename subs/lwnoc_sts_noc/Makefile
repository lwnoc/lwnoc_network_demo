
RTL_PATH ?= $(CURDIR)
PRJ_ENV := RTL_PATH=$(RTL_PATH) STS_INIU=$(RTL_PATH) STS_TNIU=$(RTL_PATH) COMMON_IP_PATH=$(RTL_PATH)/fcip FCIP_DIR=$(RTL_PATH)/fcip

TVIP_AXI_HOME := $(RTL_PATH)/testbench/vendor/tvip-axi
TUE_HOME := $(TVIP_AXI_HOME)/tue
TVIP_COMMON_HOME := $(TVIP_AXI_HOME)/tvip-common
VCS_TOOLCHAIN_FLAGS := -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -LDFLAGS -fno-lto
COV_METRICS ?= line+tgl+cond+fsm+branch
URG_BIN ?= /home/lgzhu/software/vcs2016/bin/urg
SIM_ARGS ?=
NOUVM_TESTCASES ?= tc001_reset_smoke tc002_regbank_rw_tniu0 tc003_rsc_rw_tniu0 tc004_regbank_rw_tniu1 tc005_rsc_rw_tniu1 tc006_regbank_rw_tniu2 tc007_rsc_rw_tniu2 tc008_decode_miss tc009_mixed_read_write tc010_backpressure_rsp tc011_cti_connectivity tc012_debug_timestamp_path tc013_random_addr_constrained tc014_random_illegal_addr tc015_reset_during_idle tc016_apb_local_slverr_mapped_window tc017_aw_w_skewed_arrival tc018_apb_waitstate_backpressure tc019_toggle_data_patterns tc020_toggle_id_ctrl tc021_cti_bitwalking tc022_simultaneous_rd_wr tc023_regbank_full_toggle tc024_apb_stall_sweep tc025_strobe_walk tc026_backpressure_pattern tc027_addr_offset_sweep tc028_decerr_data_toggle tc029_axi_sideband_toggle tc030_upper_addr_toggle tc031_stub_full_offset tc032_cti_sys_drive tc033_regbank_unmapped tc034_rapid_fire tc035_rd_entry_toggle tc036_tniu_apb_toggle tc037_pipeline_entry_toggle

iniu_comp:
	mkdir -p $(RTL_PATH)/work/iniu_comp
	$(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand -i $(RTL_PATH)/vc/iniu_comp.f -o $(RTL_PATH)/work/iniu_comp/filelist.f -l 111.log
	cd $(RTL_PATH)/work; $(PRJ_ENV) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog -f $(RTL_PATH)/work/iniu_comp/filelist.f +lint=PCWM +lint=TFIPC-L

tniu_comp:
	mkdir -p $(RTL_PATH)/work/tniu_comp
	$(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand -i $(RTL_PATH)/vc/tniu_comp.f -o $(RTL_PATH)/work/tniu_comp/filelist.f
	cd $(RTL_PATH)/work; $(PRJ_ENV) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog -f $(RTL_PATH)/work/tniu_comp/filelist.f +lint=PCWM +lint=TFIPC-L

# ── Pre-baked filelists for topology generation ────────────────────────
# Used by lwnoc_network_demo's gen_sts_soc_topo.py. Run `make prebake_all`
# before topology generation so TemplateIPConfig.filelist can point to a
# flat, absolute-path filelist instead of a raw $ENV vc/*.f.

cmn_comp:
	mkdir -p $(RTL_PATH)/work/cmn_comp
	$(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand \
		-i $(RTL_PATH)/vc/cmn_comp.f \
		-o $(RTL_PATH)/work/cmn_comp/filelist.f \
		-l $(RTL_PATH)/work/cmn_comp/fexpand.log

network_comp:
	mkdir -p $(RTL_PATH)/work/network_comp
	$(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand \
		-i $(RTL_PATH)/vc/network_comp.f \
		-o $(RTL_PATH)/work/network_comp/filelist.f \
		-l $(RTL_PATH)/work/network_comp/fexpand.log

prebake_all: iniu_comp tniu_comp cmn_comp network_comp

tb_compile:
	mkdir -p $(RTL_PATH)/log
	mkdir -p $(RTL_PATH)/work/tb_compile
	cd $(RTL_PATH); $(PRJ_ENV) TVIP_AXI_HOME=$(TVIP_AXI_HOME) TUE_HOME=$(TUE_HOME) TVIP_COMMON_HOME=$(TVIP_COMMON_HOME) $(RTL_PATH)/fexpand/fexpand -i $(RTL_PATH)/filelist/tb.f -o $(RTL_PATH)/work/tb_compile/filelist.f
	cd $(RTL_PATH); $(PRJ_ENV) TVIP_AXI_HOME=$(TVIP_AXI_HOME) TUE_HOME=$(TUE_HOME) TVIP_COMMON_HOME=$(TVIP_COMMON_HOME) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog -ntb_opts uvm-1.2 -timescale=1ns/1ps -f $(RTL_PATH)/work/tb_compile/filelist.f -f $(RTL_PATH)/filelist/tb_uvm.f -l $(RTL_PATH)/log/tb_compile.log +lint=PCWM +lint=TFIPC-L +define+ASIC_SIM

tb_nouvm_compile:
	mkdir -p $(RTL_PATH)/log
	mkdir -p $(RTL_PATH)/work/tb_nouvm_compile
	cd $(RTL_PATH); $(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand -i $(RTL_PATH)/filelist/tb.f -o $(RTL_PATH)/work/tb_nouvm_compile/filelist.f
	cd $(RTL_PATH); $(PRJ_ENV) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog -timescale=1ns/1ps -o $(RTL_PATH)/simv_nouvm -f $(RTL_PATH)/work/tb_nouvm_compile/filelist.f -f $(RTL_PATH)/filelist/tb_nouvm.f -l $(RTL_PATH)/log/tb_nouvm_compile.log +lint=PCWM +lint=TFIPC-L +define+ASIC_SIM

tb_nouvm_cov_compile:
	mkdir -p $(RTL_PATH)/log
	mkdir -p $(RTL_PATH)/work/tb_nouvm_cov_compile
	cd $(RTL_PATH); $(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand -i $(RTL_PATH)/filelist/tb.f -o $(RTL_PATH)/work/tb_nouvm_cov_compile/filelist.f
	cd $(RTL_PATH); $(PRJ_ENV) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog -timescale=1ns/1ps -cm $(COV_METRICS) -o $(RTL_PATH)/simv_nouvm_cov -f $(RTL_PATH)/work/tb_nouvm_cov_compile/filelist.f -f $(RTL_PATH)/filelist/tb_nouvm.f -l $(RTL_PATH)/log/tb_nouvm_cov_compile.log +lint=PCWM +lint=TFIPC-L +define+ASIC_SIM

tb_cov_compile:
	mkdir -p $(RTL_PATH)/log
	mkdir -p $(RTL_PATH)/work/tb_compile
	cd $(RTL_PATH); $(PRJ_ENV) TVIP_AXI_HOME=$(TVIP_AXI_HOME) TUE_HOME=$(TUE_HOME) TVIP_COMMON_HOME=$(TVIP_COMMON_HOME) $(RTL_PATH)/fexpand/fexpand -i $(RTL_PATH)/filelist/tb.f -o $(RTL_PATH)/work/tb_compile/filelist.f
	cd $(RTL_PATH); $(PRJ_ENV) TVIP_AXI_HOME=$(TVIP_AXI_HOME) TUE_HOME=$(TUE_HOME) TVIP_COMMON_HOME=$(TVIP_COMMON_HOME) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog -ntb_opts uvm-1.2 -timescale=1ns/1ps -cm $(COV_METRICS) -f $(RTL_PATH)/work/tb_compile/filelist.f -f $(RTL_PATH)/filelist/tb_uvm.f -l $(RTL_PATH)/log/tb_cov_compile.log +lint=PCWM +lint=TFIPC-L +define+ASIC_SIM

tb_smoke: tb_compile
	cd $(RTL_PATH); ./simv $(SIM_ARGS) -l $(RTL_PATH)/log/tb_smoke.log

tb_run_test: tb_compile
	@if [ -z "$(TESTNAME)" ]; then echo "TESTNAME is required"; exit 1; fi
	cd $(RTL_PATH); ./simv +UVM_TESTNAME=$(TESTNAME) $(SIM_ARGS) -l $(RTL_PATH)/log/$(TESTNAME).log

tb_nouvm_run_test: tb_nouvm_compile
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	cd $(RTL_PATH); ./simv_nouvm +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l $(RTL_PATH)/log/nouvm_$(TESTCASE).log

tb_nouvm_regression: tb_nouvm_compile
	@for testcase in $(NOUVM_TESTCASES); do \
		echo "[NOUVM] Running $$testcase"; \
		cd $(RTL_PATH) && ./simv_nouvm +TESTCASE=$$testcase $(SIM_ARGS) -l $(RTL_PATH)/log/nouvm_$$testcase.log || exit $$?; \
	done

tb_nouvm_cov_run_test: tb_nouvm_cov_compile
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	@RUN_NAME=$${RUN_NAME:-$(TESTCASE)}; \
	cd $(RTL_PATH); ./simv_nouvm_cov -cm $(COV_METRICS) -cm_name $$RUN_NAME -cm_dir $(RTL_PATH)/cov_nouvm/$$RUN_NAME.vdb +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l $(RTL_PATH)/log/nouvm_cov_$$RUN_NAME.log

tb_nouvm_cov_regression: tb_nouvm_cov_compile
	rm -rf $(RTL_PATH)/cov_nouvm
	mkdir -p $(RTL_PATH)/cov_nouvm $(RTL_PATH)/log/urg_nouvm
	@for testcase in $(NOUVM_TESTCASES); do \
		echo "[NOUVM COV] Running $$testcase"; \
		cd $(RTL_PATH) && ./simv_nouvm_cov -cm $(COV_METRICS) -cm_name $$testcase -cm_dir $(RTL_PATH)/cov_nouvm/$$testcase.vdb +TESTCASE=$$testcase $(SIM_ARGS) -l $(RTL_PATH)/log/nouvm_cov_$$testcase.log || exit $$?; \
	done
	$(MAKE) tb_nouvm_cov_report

tb_nouvm_cov_report:
	mkdir -p $(RTL_PATH)/log/urg_nouvm $(RTL_PATH)/log/urg_nouvm/cov_text
	cd $(RTL_PATH); $(URG_BIN) -dir $(RTL_PATH)/simv_nouvm_cov.vdb -dir $(RTL_PATH)/cov_nouvm/*.vdb -report $(RTL_PATH)/log/urg_nouvm -show fullhier
	cd $(RTL_PATH); $(URG_BIN) -dir $(RTL_PATH)/simv_nouvm_cov.vdb -dir $(RTL_PATH)/cov_nouvm/*.vdb -format text -report $(RTL_PATH)/log/urg_nouvm/cov_text -show fullhier

tb_regression: tb_compile
	cd $(RTL_PATH); ./simv $(SIM_ARGS) +UVM_TESTNAME=sts_noc_smoke_test -l $(RTL_PATH)/log/sts_noc_smoke_test.log
	cd $(RTL_PATH); ./simv $(SIM_ARGS) +UVM_TESTNAME=sts_noc_addr_map_test -l $(RTL_PATH)/log/sts_noc_addr_map_test.log
	cd $(RTL_PATH); ./simv $(SIM_ARGS) +UVM_TESTNAME=sts_noc_decerr_test -l $(RTL_PATH)/log/sts_noc_decerr_test.log
	cd $(RTL_PATH); ./simv $(SIM_ARGS) +UVM_TESTNAME=sts_noc_sideband_test +EXPECT_SIDEBAND +EXPECT_CTI -l $(RTL_PATH)/log/sts_noc_sideband_test.log

tb_cov_run_test: tb_cov_compile
	@if [ -z "$(TESTNAME)" ]; then echo "TESTNAME is required"; exit 1; fi
	@RUN_NAME=$${RUN_NAME:-$(TESTNAME)}; \
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name $$RUN_NAME -cm_dir $(RTL_PATH)/cov/$$RUN_NAME.vdb +UVM_TESTNAME=$(TESTNAME) $(SIM_ARGS) -l $(RTL_PATH)/log/$$RUN_NAME.log

tb_cov_regression: tb_cov_compile
	rm -rf $(RTL_PATH)/cov
	mkdir -p $(RTL_PATH)/cov $(RTL_PATH)/log/urg
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name smoke -cm_dir $(RTL_PATH)/cov/smoke.vdb +UVM_TESTNAME=sts_noc_smoke_test -l $(RTL_PATH)/log/cov_smoke.log
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name addr_map -cm_dir $(RTL_PATH)/cov/addr_map.vdb +UVM_TESTNAME=sts_noc_addr_map_test -l $(RTL_PATH)/log/cov_addr_map.log
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name decerr -cm_dir $(RTL_PATH)/cov/decerr.vdb +UVM_TESTNAME=sts_noc_decerr_test -l $(RTL_PATH)/log/cov_decerr.log
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name sideband -cm_dir $(RTL_PATH)/cov/sideband.vdb +UVM_TESTNAME=sts_noc_sideband_test +EXPECT_SIDEBAND +EXPECT_CTI -l $(RTL_PATH)/log/cov_sideband.log
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name outstanding -cm_dir $(RTL_PATH)/cov/outstanding.vdb +UVM_TESTNAME=sts_noc_outstanding_test -l $(RTL_PATH)/log/cov_outstanding.log
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name cov_boost -cm_dir $(RTL_PATH)/cov/cov_boost.vdb +UVM_TESTNAME=sts_noc_cov_boost_test +EXPECT_SIDEBAND -l $(RTL_PATH)/log/cov_cov_boost.log
	cd $(RTL_PATH); ./simv -cm $(COV_METRICS) -cm_name cov_boost_stall -cm_dir $(RTL_PATH)/cov/cov_boost_stall.vdb +UVM_TESTNAME=sts_noc_cov_boost_test +EXPECT_SIDEBAND +APB_STALL_CYCLES=3 -l $(RTL_PATH)/log/cov_cov_boost_stall.log
	$(MAKE) tb_cov_report

tb_cov_report:
	mkdir -p $(RTL_PATH)/log/urg $(RTL_PATH)/log/urg/cov_text
	cd $(RTL_PATH); $(URG_BIN) -dir $(RTL_PATH)/simv.vdb -dir $(RTL_PATH)/cov/*.vdb -report $(RTL_PATH)/log/urg -show fullhier
	cd $(RTL_PATH); $(URG_BIN) -dir $(RTL_PATH)/simv.vdb -dir $(RTL_PATH)/cov/*.vdb -format text -report $(RTL_PATH)/log/urg/cov_text -show fullhier

hygiene:
	cd $(RTL_PATH); bash $(RTL_PATH)/scripts/eda_workspace_hygiene.sh

clean_generated:
	rm -rf $(RTL_PATH)/cov $(RTL_PATH)/cov_nouvm $(RTL_PATH)/csrc $(RTL_PATH)/simv.daidir $(RTL_PATH)/work
	rm -rf $(RTL_PATH)/simv_nouvm.daidir
	rm -rf $(RTL_PATH)/simv_nouvm_cov.daidir
	rm -f $(RTL_PATH)/simv $(RTL_PATH)/simv_nouvm $(RTL_PATH)/simv_nouvm_cov $(RTL_PATH)/debug.vcd $(RTL_PATH)/debug_nouvm.vcd $(RTL_PATH)/cm.log $(RTL_PATH)/tr_db.log $(RTL_PATH)/ucli.key $(RTL_PATH)/UHDL.log $(RTL_PATH)/elab.log
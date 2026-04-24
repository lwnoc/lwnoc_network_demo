# new_tb/Makefile — Build & run for new verification environment
RTL_PATH ?= $(realpath $(CURDIR)/..)
PRJ_ENV := RTL_PATH=$(RTL_PATH) STS_INIU=$(RTL_PATH) STS_TNIU=$(RTL_PATH) COMMON_IP_PATH=$(RTL_PATH)/fcip FCIP_DIR=$(RTL_PATH)/fcip

VCS_TOOLCHAIN_FLAGS := -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -LDFLAGS -fno-lto
COV_METRICS ?= line+tgl+cond+fsm+branch
URG_BIN ?= /home/lgzhu/software/vcs2016/bin/urg
SIM_ARGS ?=

WORK_DIR := $(CURDIR)/work
LOG_DIR  := $(CURDIR)/log
COV_DIR  := $(CURDIR)/cov
SIMV     := $(CURDIR)/simv_newtb
SIMV_COV := $(CURDIR)/simv_newtb_cov

TESTCASES := tc_reset tc_regbank_rw tc_rsc_rw tc_sys_rw tc_decode_err \
	tc_mixed_rw tc_strobe_walk tc_apb_stall tc_slverr tc_aw_w_skewed \
	tc_toggle_data tc_toggle_id_ctrl tc_cti tc_debug_path tc_backpressure \
	tc_rapid_fire tc_addr_offset_sweep tc_node_id_toggle tc_reset_stress \
	tc_apb_stall_with_data tc_all_windows_rw tc_burst_size_toggle \
	tc_stall_all_windows tc_addr_byte_toggle tc_pipeline_backpressure \
	tc_dbg_timestamp_long tc_dbg_data_gate tc_outstanding_pressure \
	tc_toggle_all_tniu tc_sideband_toggle tc_equal_all_tniu \
	tc_pmc_full_exercise tc_max_toggle_tniu \
	tc_cti_ctm_verify tc_timestamp_fanout tc_debug_data_mux

.PHONY: compile cov_compile run_test run_all cov_run_test cov_regression cov_report clean

compile:
	mkdir -p $(WORK_DIR) $(LOG_DIR)
	$(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand -i $(CURDIR)/filelist.f -o $(WORK_DIR)/filelist_expanded.f
	cd $(CURDIR); $(PRJ_ENV) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog \
		-timescale=1ns/1ps -o $(SIMV) \
		-f $(WORK_DIR)/filelist_expanded.f \
		-l $(LOG_DIR)/compile.log +define+ASIC_SIM

cov_compile:
	mkdir -p $(WORK_DIR) $(LOG_DIR)
	$(PRJ_ENV) $(RTL_PATH)/fexpand/fexpand -i $(CURDIR)/filelist.f -o $(WORK_DIR)/filelist_expanded.f
	cd $(CURDIR); $(PRJ_ENV) vcs -lca -full64 $(VCS_TOOLCHAIN_FLAGS) -debug_access -sverilog \
		-timescale=1ns/1ps -cm $(COV_METRICS) -o $(SIMV_COV) \
		-f $(WORK_DIR)/filelist_expanded.f \
		-l $(LOG_DIR)/cov_compile.log +define+ASIC_SIM

run_test: compile
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	cd $(CURDIR); $(SIMV) +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l $(LOG_DIR)/$(TESTCASE).log

run_all: compile
	cd $(CURDIR); $(SIMV) +TESTCASE=all $(SIM_ARGS) -l $(LOG_DIR)/run_all.log

cov_run_test: cov_compile
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	mkdir -p $(COV_DIR)
	cd $(CURDIR); $(SIMV_COV) -cm $(COV_METRICS) -cm_name $(TESTCASE) \
		-cm_dir $(COV_DIR)/$(TESTCASE).vdb \
		+TESTCASE=$(TESTCASE) $(SIM_ARGS) -l $(LOG_DIR)/cov_$(TESTCASE).log

cov_regression: cov_compile
	mkdir -p $(COV_DIR) $(LOG_DIR)
	@for tc in $(TESTCASES); do \
		echo "[NEWTB COV] Running $$tc"; \
		EXTRA_ARGS=""; \
		case $$tc in tc_stall_all_windows|tc_outstanding_pressure) EXTRA_ARGS="+APB_STALL_CYCLES=4";; esac; \
		cd $(CURDIR) && $(SIMV_COV) -cm $(COV_METRICS) -cm_name $$tc \
			-cm_dir $(COV_DIR)/$$tc.vdb \
			+TESTCASE=$$tc $$EXTRA_ARGS $(SIM_ARGS) -l $(LOG_DIR)/cov_$$tc.log || exit $$?; \
	done
	$(MAKE) cov_report

cov_report:
	mkdir -p $(LOG_DIR)/urg $(LOG_DIR)/urg/cov_text
	cd $(CURDIR); $(URG_BIN) -dir $(SIMV_COV).vdb -dir $(COV_DIR)/*.vdb \
		-report $(LOG_DIR)/urg -show fullhier
	cd $(CURDIR); $(URG_BIN) -dir $(SIMV_COV).vdb -dir $(COV_DIR)/*.vdb \
		-format text -report $(LOG_DIR)/urg/cov_text -show fullhier
	cd $(CURDIR); $(URG_BIN) -dir $(SIMV_COV).vdb -dir $(COV_DIR)/*.vdb \
		-elfile $(CURDIR)/waiver.el -excl_bypass_checks \
		-hier $(CURDIR)/cm_hier.cfg \
		-format text -report $(LOG_DIR)/urg/cov_text_waived -show fullhier

clean:
	@echo "Use Python shutil for cleanup to comply with workspace policy"

SIM_DIR       := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DEMO_DIR      := $(realpath $(SIM_DIR)/..)
STS_NOC_DIR   := $(realpath $(DEMO_DIR)/../subs/lwnoc_sts_noc)
STS_NOC_DEMO_DIR := $(DEMO_DIR)
RTL_PATH      := $(STS_NOC_DIR)
STS_INIU      := $(STS_NOC_DIR)
STS_TNIU      := $(STS_NOC_DIR)
VCS           := /home/lgzhu/software/vcs2016/bin/vcs
VERDI         := /home/lgzhu/software/verdi2016/bin/verdi
VERDI_PLI_TAB := /home/lgzhu/software/verdi2016/share/PLI/VCS/linux64/novas.tab
VERDI_PLI_LIB := /home/lgzhu/software/verdi2016/share/PLI/VCS/linux64/pli.a
FCIP_DIR      := $(STS_NOC_DIR)/fcip
COMMON_FCIP_DIR := $(realpath $(DEMO_DIR)/../subs/fcip)
STS_SOC_PUBLISH_ENV_MK := $(DEMO_DIR)/filelists/sts_soc_publish_env.mk

ifneq ($(wildcard $(STS_SOC_PUBLISH_ENV_MK)),)
include $(STS_SOC_PUBLISH_ENV_MK)
endif

export STS_NOC_DIR
export STS_NOC_DEMO_DIR
export RTL_PATH
export STS_INIU
export STS_TNIU
export STS_INIU0_SYS_OUT_DIR          := $(DEMO_DIR)/build_logic/iniu0_sys
export STS_LOGIC_TOPO_DIR             := $(DEMO_DIR)/build_logic/sts_logic_topo_1i4t
export STS_TNIU0_SYS_OUT_DIR          := $(DEMO_DIR)/build_logic/tniu0_sys
export STS_TNIU1_SYS_OUT_DIR          := $(DEMO_DIR)/build_logic/tniu1_sys
export STS_TNIU2_SYS_OUT_DIR          := $(DEMO_DIR)/build_logic/tniu2_sys
export STS_TNIU3_SYS_OUT_DIR          := $(DEMO_DIR)/build_logic/tniu3_sys
export STS_SOC_AON_SS_INIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_VPU_SS_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_CAMERA_SS_TNIU_OUT_DIR := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_DSPSS0_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_DSPSS1_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_DSPSS2_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_DSPSS3_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_DSPSS4_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_DSPSS5_TNIU_OUT_DIR    := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_STS_DEC4_OUT_DIR       := $(DEMO_DIR)/build_logic/soc_sts_noc
export STS_SOC_STS_NOC_OUT_DIR        := $(DEMO_DIR)/build_logic/soc_sts_noc
export FCIP_DIR

BUILD_DIR    := $(SIM_DIR)/build
SIMV         := $(BUILD_DIR)/simv
COMPILE_LOG  := $(BUILD_DIR)/compile.log
TB_SV        := $(SIM_DIR)/tb_sts_logic_topo_1i4t.sv
AON_ADDR_MAP_TB_SV := $(SIM_DIR)/tb_sts_aon_addr_map.sv
AON_ADDR_MAP_BUILD_DIR := $(BUILD_DIR)/aon_addr_map
AON_ADDR_MAP_SIMV := $(AON_ADDR_MAP_BUILD_DIR)/simv
AON_ADDR_MAP_COMPILE_LOG := $(AON_ADDR_MAP_BUILD_DIR)/compile.log
AON_ADDR_MAP_RUN_LOG := $(AON_ADDR_MAP_BUILD_DIR)/run.log
AON_INIU_MACROS := $(firstword $(wildcard $(AON_SS_INIU_SYS_OUT_DIR)/aon_ss_iniu_sys_macros_*.sv))
AON_AXI_ACCESS_TB_SV := $(SIM_DIR)/tb_sts_aon_axi_access.sv
AON_AXI_ACCESS_BUILD_DIR := $(BUILD_DIR)/aon_axi_access
AON_AXI_ACCESS_SIMV := $(AON_AXI_ACCESS_BUILD_DIR)/simv
AON_AXI_ACCESS_COMPILE_LOG := $(AON_AXI_ACCESS_BUILD_DIR)/compile.log
AON_AXI_ACCESS_RUN_LOG := $(AON_AXI_ACCESS_BUILD_DIR)/run.log
COMMON_DEPS_F := $(DEMO_DIR)/filelists/sts_common_dep.f
CHECK_COMPILE_LOG := $(SIM_DIR)/check_compile_log.py
# Top-level DUT filelist published under filelists/
DUT_FILELIST := $(DEMO_DIR)/filelists/filelist.f

TESTCASES := tc_reset tc_regbank_rw tc_all_windows_rw tc_decode_err tc_slverr tc_strobe_walk tc_apb_stall
SIM_ARGS ?=

VCS_FLAGS := -full64 \
             -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
             -sverilog \
             -timescale=1ns/1ps \
             +v2k \
             +notimingcheck \
			 +lint=TFIPC-L \
             +define+ASIC_SIM \
             -P $(VERDI_PLI_TAB) $(VERDI_PLI_LIB)

.PHONY: all compile run_test regression compile_aon_addr_map run_aon_addr_map compile_aon_axi_access run_aon_axi_access sim_wave wave clean

all: compile regression

compile:
	mkdir -p $(BUILD_DIR)
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    -f $(FCIP_DIR)/vc/arbiter.f \
	    -f $(FCIP_DIR)/vc/async_fifo.f \
	    -f $(FCIP_DIR)/vc/basic.f \
	    -f $(FCIP_DIR)/vc/memory.f \
	    -f $(FCIP_DIR)/vc/regslice.f \
	    -f $(FCIP_DIR)/vc/stdcell_wrap.f \
	    -f $(FCIP_DIR)/vc/sync_fifo.f \
	    -f $(FCIP_DIR)/vc/handshake.f \
	    $(FCIP_DIR)/bak/fifo/bak/cmn_vrp_reg_fifo.sv \
	    -f $(DUT_FILELIST) \
	    $(TB_SV) \
	    -top tb_sts_logic_topo_1i4t \
	    -Mdir=$(BUILD_DIR)/csrc \
	    -o $(SIMV) \
	    -l $(COMPILE_LOG)
	python3 $(CHECK_COMPILE_LOG) $(COMPILE_LOG)

run_test: $(SIMV)
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l logs/$(TESTCASE).log

compile_aon_addr_map:
	@if [ -z "$(AON_INIU_MACROS)" ]; then \
	    echo "AON INIU generated macro file is missing. Run python3 $(DEMO_DIR)/gen_sts_soc_topo.py first."; \
	    exit 1; \
	fi
	mkdir -p $(AON_ADDR_MAP_BUILD_DIR)
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    $(AON_INIU_MACROS) \
	    $(STS_INIU)/rtl/iniu/sts_iniu_define.sv \
	    $(STS_INIU)/rtl/common/lwnoc_sts_pack.sv \
	    $(STS_INIU)/rtl/common/sts_iniu_addr_map.sv \
	    $(AON_ADDR_MAP_TB_SV) \
	    -top tb_sts_aon_addr_map \
	    -Mdir=$(AON_ADDR_MAP_BUILD_DIR)/csrc \
	    -o $(AON_ADDR_MAP_SIMV) \
	    -l $(AON_ADDR_MAP_COMPILE_LOG)

run_aon_addr_map: compile_aon_addr_map
	cd $(AON_ADDR_MAP_BUILD_DIR) && $(AON_ADDR_MAP_SIMV) -l $(AON_ADDR_MAP_RUN_LOG)

compile_aon_axi_access:
	@if [ -z "$(AON_INIU_MACROS)" ]; then \
	    echo "AON INIU generated macro file is missing. Run python3 $(DEMO_DIR)/gen_sts_soc_topo.py first."; \
	    exit 1; \
	fi
	@if [ ! -d "$(COMMON_FCIP_DIR)" ]; then \
	    echo "Common FCIP directory is missing: $(COMMON_FCIP_DIR)"; \
	    exit 1; \
	fi
	mkdir -p $(AON_AXI_ACCESS_BUILD_DIR)
	cd $(SIM_DIR) && FCIP_DIR=$(COMMON_FCIP_DIR) $(VCS) $(VCS_FLAGS) \
	    -f $(COMMON_FCIP_DIR)/vc/arbiter.f \
	    -f $(COMMON_FCIP_DIR)/vc/basic.f \
	    -f $(COMMON_FCIP_DIR)/vc/regslice.f \
	    -f $(COMMON_FCIP_DIR)/vc/sync_fifo.f \
	    $(AON_INIU_MACROS) \
	    $(STS_INIU)/rtl/iniu/sts_iniu_define.sv \
	    $(STS_INIU)/rtl/common/lwnoc_sts_pack.sv \
	    $(STS_INIU)/rtl/common/sts_iniu_addr_map.sv \
	    $(STS_INIU)/rtl/common/lwring_id_remap_entry.sv \
	    $(STS_INIU)/rtl/common/lwring_id_remap.sv \
	    $(STS_INIU)/rtl/iniu/sts_iniu_axi_bundle.sv \
	    $(STS_INIU)/rtl/iniu/sts_iniu_wr_channel.sv \
	    $(STS_INIU)/rtl/iniu/sts_iniu_rd_channel.sv \
	    $(STS_INIU)/rtl/iniu/sts_iniu_axi_iniu.sv \
	    $(AON_AXI_ACCESS_TB_SV) \
	    -top tb_sts_aon_axi_access \
	    -Mdir=$(AON_AXI_ACCESS_BUILD_DIR)/csrc \
	    -o $(AON_AXI_ACCESS_SIMV) \
	    -l $(AON_AXI_ACCESS_COMPILE_LOG)

run_aon_axi_access: compile_aon_axi_access
	cd $(AON_AXI_ACCESS_BUILD_DIR) && $(AON_AXI_ACCESS_SIMV) -l $(AON_AXI_ACCESS_RUN_LOG)

regression: $(SIMV)
	mkdir -p $(BUILD_DIR)/logs
	@for tc in $(TESTCASES); do \
	    echo "[STS DEMO] Running $$tc"; \
	    EXTRA_ARGS=""; \
	    if [ "$$tc" = "tc_apb_stall" ]; then EXTRA_ARGS="+APB_STALL_CYCLES=3"; fi; \
	    cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$$tc $$EXTRA_ARGS $(SIM_ARGS) -l logs/$$tc.log || exit $$?; \
	    grep -E "PASS|FAILED|fatal|ERROR" logs/$$tc.log || true; \
	 done

sim_wave: $(SIMV)
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=all +DUMP_FSDB $(SIM_ARGS) -l logs/wave.log

wave:
	$(VERDI) -sv -f $(DUT_FILELIST) $(TB_SV) -ssf $(BUILD_DIR)/sts_logic_topo_1i4t.fsdb -dbdir $(BUILD_DIR)/simv.daidir &

clean:
	rm -rf $(BUILD_DIR)
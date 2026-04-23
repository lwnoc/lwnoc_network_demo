SIM_DIR       := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DEMO_DIR      := $(realpath $(SIM_DIR)/..)
DTI_PR        := $(realpath $(DEMO_DIR)/../subs/lwnoc_dti_noc)
DTI_TEST_DIR  := $(DEMO_DIR)
RTL_PATH      := $(DTI_PR)
FCIP_DIR      := $(DTI_PR)/fcip
LWNOC_LOWPOWER_COMPONENT := $(DTI_PR)/lwnoc_lowpower_component
VCS           := /home/lgzhu/software/vcs2016/bin/vcs
VERDI         := /home/lgzhu/software/verdi2016/bin/verdi
VERDI_PLI_TAB := /home/lgzhu/software/verdi2016/share/PLI/VCS/linux64/novas.tab
VERDI_PLI_LIB := /home/lgzhu/software/verdi2016/share/PLI/VCS/linux64/pli.a

export DTI_PR
export DTI_TEST_DIR
export RTL_PATH
export FCIP_DIR
export LWNOC_LOWPOWER_COMPONENT
export SOC_DTI_LOGIC_TOPO_DIR        := $(DEMO_DIR)/build_logic/soc_dti_top_wrap
export DTI_INIU_TOP_DIR              := $(DEMO_DIR)/build_logic/dti_iniu_top_side
export DTI_TNIU_TOP_DIR              := $(DEMO_DIR)/build_logic/dti_tniu_top_side
export SOC_DTI_DSP_SS0_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/dsp_ss0_iniu_sys
export SOC_DTI_DSP_SS1_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/dsp_ss1_iniu_sys
export SOC_DTI_DSP_SS2_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/dsp_ss2_iniu_sys
export SOC_DTI_DSP_SS3_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/dsp_ss3_iniu_sys
export SOC_DTI_DSP_SS4_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/dsp_ss4_iniu_sys
export SOC_DTI_DSP_SS5_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/dsp_ss5_iniu_sys
export SOC_DTI_VPU_SS_INIU_SYS_DIR   := $(DEMO_DIR)/build_logic/vpu_ss_iniu_sys
export SOC_DTI_PCIE_RTG_SS_INIU_SYS_DIR := $(DEMO_DIR)/build_logic/pcie_rtg_ss_iniu_sys
export SOC_DTI_UFS_SS_INIU_SYS_DIR   := $(DEMO_DIR)/build_logic/ufs_ss_iniu_sys
export SOC_DTI_CAMERA_SS_INIU_SYS_DIR := $(DEMO_DIR)/build_logic/camera_ss_iniu_sys
export SOC_DTI_MIPI_SS_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/mipi_ss_iniu_sys
export SOC_DTI_GPU_SS0_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/gpu_ss0_iniu_sys
export SOC_DTI_GPU_SS1_INIU_SYS_DIR  := $(DEMO_DIR)/build_logic/gpu_ss1_iniu_sys
export SOC_DTI_DP_SS_INIU_SYS_DIR    := $(DEMO_DIR)/build_logic/dp_ss_iniu_sys
export SOC_DTI_DISPLAY_SS_INIU_SYS_DIR := $(DEMO_DIR)/build_logic/display_ss_iniu_sys
export SYS_TCU_TNIU_SYS_DIR          := $(DEMO_DIR)/build_logic/sys_tcu_tniu_sys

DTI_COMMON_DEP_F := $(DEMO_DIR)/filelists/dti_common_dep.f
BUILD_DIR    := $(SIM_DIR)/build
SIMV         := $(BUILD_DIR)/simv
COMPILE_LOG  := $(BUILD_DIR)/compile.log
TB_SV        := $(SIM_DIR)/tb_soc_dti_logic_topo_tree.sv
CHECK_COMPILE_LOG := $(SIM_DIR)/check_compile_log.py
DUT_FILELIST := $(DEMO_DIR)/filelists/soc_dti_logic_topo.f

TESTCASES := tc_smoke tc_boundary_ids tc_concurrent_branches
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

.PHONY: all compile run_test regression sim_wave wave clean

all: compile regression

compile:
	mkdir -p $(BUILD_DIR)
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    -f $(DTI_COMMON_DEP_F) \
	    -f $(DUT_FILELIST) \
	    $(TB_SV) \
	    -top tb_soc_dti_logic_topo_tree \
	    -Mdir=$(BUILD_DIR)/csrc \
	    -o $(SIMV) \
	    -l $(COMPILE_LOG)
	python3 $(CHECK_COMPILE_LOG) $(COMPILE_LOG)

run_test: $(SIMV)
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l logs/$(TESTCASE).log

regression: $(SIMV)
	mkdir -p $(BUILD_DIR)/logs
	@for tc in $(TESTCASES); do \
	    echo "[SOC DTI] Running $$tc"; \
	    cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$$tc $(SIM_ARGS) -l logs/$$tc.log || exit $$?; \
	    grep -E "PASS|FAILED|fatal|ERROR" logs/$$tc.log || true; \
	 done

sim_wave: $(SIMV)
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=tc_smoke +DUMP_FSDB $(SIM_ARGS) -l logs/wave.log

wave:
	$(VERDI) -sv -f $(DTI_COMMON_DEP_F) -f $(DUT_FILELIST) $(TB_SV) -ssf $(BUILD_DIR)/soc_dti_logic_topo_tree.fsdb -dbdir $(BUILD_DIR)/simv.daidir &

clean:
	rm -rf $(BUILD_DIR)

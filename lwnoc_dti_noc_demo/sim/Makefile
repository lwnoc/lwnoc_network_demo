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
export DTI_SW_ROOT_OUT_DIR       := $(DEMO_DIR)/build_logic/dti_sw_root
export DTI_SW_RIGHT_NOC0_OUT_DIR := $(DEMO_DIR)/build_logic/dti_sw_right_noc0
export DTI_SW_RIGHT4_OUT_DIR     := $(DEMO_DIR)/build_logic/dti_sw_right4
export DTI_SW_LEFT_NOC1_OUT_DIR  := $(DEMO_DIR)/build_logic/dti_sw_left_noc1
export DTI_SW_LEFT_DSP0_OUT_DIR  := $(DEMO_DIR)/build_logic/dti_sw_left_dsp0
export DTI_SW_LEFT_DSP1_OUT_DIR  := $(DEMO_DIR)/build_logic/dti_sw_left_dsp1
export DTI_SW_LEFT3_OUT_DIR      := $(DEMO_DIR)/build_logic/dti_sw_left3

BUILD_DIR    := $(SIM_DIR)/build
SIMV         := $(BUILD_DIR)/simv
COMPILE_LOG  := $(BUILD_DIR)/compile.log
TB_SV        := $(SIM_DIR)/tb_dti_logic_topo_tree.sv
# Top-level DUT filelist published under filelists/
DUT_FILELIST := $(DEMO_DIR)/filelists/filelist.f

TESTCASES := tc_reset tc_req_routing tc_rsp_routing tc_boundary_ids tc_concurrent_branches tc_req_sticky
SIM_ARGS ?=

VCS_FLAGS := -full64 \
             -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
             -sverilog \
             -timescale=1ns/1ps \
             +v2k \
             +notimingcheck \
             +define+ASIC_SIM \
             -P $(VERDI_PLI_TAB) $(VERDI_PLI_LIB)

.PHONY: all compile run_test regression sim_wave wave clean

all: compile regression

compile:
	mkdir -p $(BUILD_DIR)
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    -f $(DUT_FILELIST) \
	    $(TB_SV) \
	    -top tb_dti_logic_topo_tree \
	    -Mdir=$(BUILD_DIR)/csrc \
	    -o $(SIMV) \
	    -l $(COMPILE_LOG)

run_test: $(SIMV)
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l logs/$(TESTCASE).log

regression: $(SIMV)
	mkdir -p $(BUILD_DIR)/logs
	@for tc in $(TESTCASES); do \
	    echo "[DTI TREE] Running $$tc"; \
	    cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$$tc $(SIM_ARGS) -l logs/$$tc.log || exit $$?; \
	    grep -E "PASS|FAILED|fatal|ERROR" logs/$$tc.log || true; \
	 done

sim_wave: $(SIMV)
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=all +DUMP_FSDB $(SIM_ARGS) -l logs/wave.log

wave:
	$(VERDI) -sv -f $(DUT_FILELIST) $(TB_SV) -ssf $(BUILD_DIR)/dti_logic_topo_tree.fsdb -dbdir $(BUILD_DIR)/simv.daidir &

clean:
	rm -rf $(BUILD_DIR)
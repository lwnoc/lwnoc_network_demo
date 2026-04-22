SIM_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DEMO_DIR := $(realpath $(SIM_DIR)/..)

export INTR_NOC_DEMO_DIR := $(DEMO_DIR)

VCS ?= vcs
TB_GEN := $(SIM_DIR)/gen_soc_intr_sanity_tb.py
TB_SV := $(SIM_DIR)/tb_soc_intr_noc_sanity.sv
DUT_FILELIST := $(DEMO_DIR)/build_logic/soc_intr_noc_wrap/filelist.f
BUILD_DIR := $(SIM_DIR)/build
SIMV := $(BUILD_DIR)/simv
COMPILE_LOG := $(BUILD_DIR)/compile.log
SIM_LOG := $(BUILD_DIR)/tc_sanity.log

VCS_FLAGS := -full64 \
	-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
	-sverilog \
	-timescale=1ns/1ps \
	+v2k \
	+notimingcheck \
	+lint=TFIPC-L \
	+error+OPD

.PHONY: compile sim clean

compile:
	python3 $(TB_GEN)
	mkdir -p $(BUILD_DIR)
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    -f $(DUT_FILELIST) \
	    $(TB_SV) \
	    -top tb_soc_intr_noc_sanity \
	    -Mdir=$(BUILD_DIR)/csrc \
	    -o $(SIMV) \
	    -l $(COMPILE_LOG)

sim: compile
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=tc_sanity +ntb_random_seed=1 -l $(SIM_LOG)

clean:
	rm -rf $(BUILD_DIR) $(TB_SV)
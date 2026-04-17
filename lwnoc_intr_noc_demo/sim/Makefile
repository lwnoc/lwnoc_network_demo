# Makefile for intr_ring_noc_4i2t functional verification
# Run: make compile   - compile the DUT + TB with VCS
# Run: make sim       - run simulation (all test cases)
# Run: make wave      - launch Verdi on the last FSDB waveform
# Run: make all       - compile + sim

SIM_DIR         := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DEMO_DIR        := $(realpath $(SIM_DIR)/..)
REPO_ROOT       := $(realpath $(DEMO_DIR)/..)
INTR_NOC_DIR    ?= $(REPO_ROOT)/subs/lwnoc_interrupt_noc
FCIP_DIR        := $(INTR_NOC_DIR)/fcip
LWNOC_LOWPOWER_COMPONENT := $(INTR_NOC_DIR)/lwnoc_lowpower_component
VCS             ?= vcs
VERDI           ?= verdi
VERDI_PLI_TAB   ?= $(dir $(shell which verdi 2>/dev/null))../share/PLI/VCS/linux64/novas.tab
VERDI_PLI_LIB   ?= $(dir $(shell which verdi 2>/dev/null))../share/PLI/VCS/linux64/pli.a

# Env vars read by DUT filelist.f via $VAR expansion
export INTR_NOC_DIR
export FCIP_DIR
export LWNOC_LOWPOWER_COMPONENT
export INTR_NOC_DEMO_DIR := $(DEMO_DIR)
# Combined top-side dir (SKILL §1b)
export INTR_RING_NOC_DIR     := $(DEMO_DIR)/build_logic/intr_ring_noc_4i2t
# Per-instance sys dirs
export INTR_TNIU0_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/tniu0_sys
export INTR_TNIU1_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/tniu1_sys
export INTR_INIU0_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/iniu0_sys
export INTR_INIU1_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/iniu1_sys
export INTR_INIU2_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/iniu2_sys
export INTR_INIU3_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/iniu3_sys

BUILD_DIR       := $(DEMO_DIR)/sim/build
SIMV            := $(BUILD_DIR)/simv
COMPILE_LOG     := $(BUILD_DIR)/compile.log
LOG_DIR         := $(BUILD_DIR)/logs
SIM_LOG         := $(LOG_DIR)/tc_sanity.log
FSDB            := $(BUILD_DIR)/intr_ring_noc_4i2t.fsdb
TESTCASES       := tc_sanity

VCS_FLAGS := -full64 \
             -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
             -sverilog \
             -timescale=1ns/1ps \
             +v2k \
             +notimingcheck \
             +lint=TFIPC-L \
             +define+ASIC_SIM \
             -P $(VERDI_PLI_TAB) $(VERDI_PLI_LIB)

# Top-level DUT filelist published under filelist/
DUT_FILELIST    := $(DEMO_DIR)/filelist/filelist.f
COMMON_DEPS_F   := $(DEMO_DIR)/filelist/intr_common_dep.f
DW02_STUB       := $(INTR_NOC_DIR)/ai_testbench/dw02_tree_stub.sv
TB_SV           := $(DEMO_DIR)/sim/tb_intr_ring_noc_4i2t.sv

.PHONY: all compile sim run_test regression sim_wave wave clean help

all: compile regression

compile:
	mkdir -p $(BUILD_DIR)
	@echo "[TB] Compiling DUT + testbench ..."
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    -f $(COMMON_DEPS_F) \
	    -f $(DUT_FILELIST) \
	    $(DW02_STUB) \
	    $(TB_SV) \
	    -top tb_intr_ring_noc_4i2t \
	    -Mdir=$(BUILD_DIR)/csrc \
	    -o $(SIMV) \
	    -l $(COMPILE_LOG)
	python3 $(SIM_DIR)/check_compile_log.py $(COMPILE_LOG)
	@echo "[TB] Compile done. Log: $(COMPILE_LOG)"

sim: $(SIMV)
	mkdir -p $(LOG_DIR)
	@echo "[TB] Running simulation ..."
	cd $(BUILD_DIR) && $(SIMV) \
	    +TESTCASE=tc_sanity \
	    +ntb_random_seed=1 \
	    -l $(SIM_LOG)
	@echo "[TB] Simulation done. Log: $(SIM_LOG)"
	@grep -E "all.*PASSED|FAILED|\[FAIL\]|\[PASS\]|$$fatal" $(SIM_LOG) || true

run_test: $(SIMV)
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	mkdir -p $(LOG_DIR)
	cd $(BUILD_DIR) && $(SIMV) \
	    +TESTCASE=$(TESTCASE) \
	    +ntb_random_seed=1 \
	    -l $(LOG_DIR)/$(TESTCASE).log

regression: $(SIMV)
	mkdir -p $(LOG_DIR)
	@for tc in $(TESTCASES); do \
	    echo "[TB] Running $$tc ..."; \
	    cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$$tc +ntb_random_seed=1 -l $(LOG_DIR)/$$tc.log || exit $$?; \
	    grep -E "PASSED|FAILED|\[FAIL\]|\[PASS\]|fatal|ERROR|observed X|observed Z|X/Z" $(LOG_DIR)/$$tc.log || true; \
	 done

sim_wave: $(SIMV)
	@echo "[TB] Running simulation with FSDB dump ..."
	cd $(BUILD_DIR) && $(SIMV) \
	    +ntb_random_seed=1 \
	    +dump_fsdb \
	    -l $(SIM_LOG)
	@echo "[TB] Waveform written to $(FSDB)"

wave:
	cd $(SIM_DIR) && $(VERDI) -sv \
	    -f $(COMMON_DEPS_F) \
	    -f $(DUT_FILELIST) \
	    -ssf $(FSDB) \
	    -dbdir $(BUILD_DIR)/simv.daidir &

clean:
	rm -rf $(BUILD_DIR)
	@echo "[TB] Build directory cleaned."

help:
	@echo "Targets:"
	@echo "  make compile    - compile DUT + TB (VCS)"
	@echo "  make sim        - run simulation"
	@echo "  make sim_wave   - run simulation with FSDB waveform dump"
	@echo "  make wave       - open Verdi with last waveform"
	@echo "  make all        - compile + sim"
	@echo "  make clean      - remove build/"

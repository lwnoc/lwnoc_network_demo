# Makefile for intr_ring_noc_4i2t functional verification
# Run: make compile   - compile the DUT + TB with VCS
# Run: make sim       - run simulation (all test cases)
# Run: make wave      - launch Verdi on the last FSDB waveform
# Run: make all       - compile + sim

SIM_DIR         := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DEMO_DIR        := $(realpath $(SIM_DIR)/..)
INTR_NOC_DIR    := /home/lgzhu/dev/noc_work/lwnoc_interrupt_noc
VCS             := /home/lgzhu/software/vcs2016/bin/vcs
VERDI           := /home/lgzhu/software/verdi2016/bin/verdi
VERDI_PLI_TAB   := /home/lgzhu/software/verdi2016/share/PLI/VCS/linux64/novas.tab
VERDI_PLI_LIB   := /home/lgzhu/software/verdi2016/share/PLI/VCS/linux64/pli.a

# Published child filelists under build_logic/ (read by DUT filelist.f via $VAR expansion)
export INTR_NOC_DIR
export INTR_RING_LNK_OUT_DIR := $(DEMO_DIR)/build_logic/intr_ring_lnk
export INTR_RING_STA_OUT_DIR := $(DEMO_DIR)/build_logic/intr_ring_sta
export INTR_TNIU_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/intr_tniu_sys
export INTR_TNIU_TOP_OUT_DIR := $(DEMO_DIR)/build_logic/intr_tniu_top
export INTR_INIU_SYS_OUT_DIR := $(DEMO_DIR)/build_logic/intr_iniu_sys
export INTR_INIU_TOP_OUT_DIR := $(DEMO_DIR)/build_logic/intr_iniu_top

BUILD_DIR       := $(DEMO_DIR)/sim/build
SIMV            := $(BUILD_DIR)/simv
COMPILE_LOG     := $(BUILD_DIR)/compile.log
SIM_LOG         := $(BUILD_DIR)/sim.log
FSDB            := $(BUILD_DIR)/intr_ring_noc_4i2t.fsdb
PYTHON          ?= python3
CHECK_COMPILE_LOG := $(DEMO_DIR)/sim/check_compile_log.py

VCS_FLAGS := -full64 \
             -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
             -sverilog \
             -timescale=1ns/1ps \
             +v2k \
             +notimingcheck \
             +lint=TFIPC-L \
             +define+ASIC_SIM \
             +define+intr_tniu_top_LWNOC_LP_DEFINE_PACKAGE_SV \
             +define+intr_tniu_top_LWNOC_LP_STRUCT_PACKAGE_SV \
             +define+intr_iniu_top_LWNOC_LP_DEFINE_PACKAGE_SV \
             +define+intr_iniu_top_LWNOC_LP_STRUCT_PACKAGE_SV \
             +define+intr_iniu_sys_LWNOC_LP_DEFINE_PACKAGE_SV \
             +define+intr_iniu_sys_LWNOC_LP_STRUCT_PACKAGE_SV \
             -P $(VERDI_PLI_TAB) $(VERDI_PLI_LIB)

# The published top filelist intentionally excludes foundation IP collateral.
# Compile it once here so shared packages/modules are not duplicated across child filelists.
COMMON_DEPS_F   := ../filelists/intr_common_dep.f
DUT_FILELIST    := intr_ring_noc_4i2t/filelist.f
DW02_STUB       := $(INTR_NOC_DIR)/ai_testbench/dw02_tree_stub.sv
TB_SV           := $(DEMO_DIR)/sim/tb_intr_ring_noc_4i2t.sv

.PHONY: all compile sim wave clean help

all: compile sim

compile:
	mkdir -p $(BUILD_DIR)
	@echo "[TB] Compiling DUT + testbench ..."
	cd $(DEMO_DIR)/build_logic && $(VCS) $(VCS_FLAGS) \
	    -f $(COMMON_DEPS_F) \
	    -f $(DUT_FILELIST) \
	    $(DW02_STUB) \
	    $(TB_SV) \
	    -top tb_intr_ring_noc_4i2t \
	    -Mdir=$(BUILD_DIR)/csrc \
	    -o $(SIMV) \
	    -l $(COMPILE_LOG)
	$(PYTHON) $(CHECK_COMPILE_LOG) $(COMPILE_LOG)
	@echo "[TB] Compile done. Log: $(COMPILE_LOG)"

sim: $(SIMV)
	@echo "[TB] Running simulation ..."
	cd $(BUILD_DIR) && $(SIMV) \
	    +ntb_random_seed=1 \
	    -l $(SIM_LOG)
	@echo "[TB] Simulation done. Log: $(SIM_LOG)"
	@grep -E "all.*PASSED|FAILED|\[FAIL\]|\[PASS\]|$$fatal" $(SIM_LOG) || true

sim_wave: $(SIMV)
	@echo "[TB] Running simulation with FSDB dump ..."
	cd $(BUILD_DIR) && $(SIMV) \
	    +ntb_random_seed=1 \
	    +dump_fsdb \
	    -l $(SIM_LOG)
	@echo "[TB] Waveform written to $(FSDB)"

wave:
	cd $(DEMO_DIR)/build_logic && $(VERDI) -sv \
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

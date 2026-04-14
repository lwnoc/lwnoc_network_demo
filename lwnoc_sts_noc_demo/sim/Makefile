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

export STS_NOC_DIR
export STS_NOC_DEMO_DIR
export RTL_PATH
export STS_INIU
export STS_TNIU
export STS_DEMO_INIU_OUT_DIR  := $(DEMO_DIR)/build_logic/sts_demo_iniu
export STS_DEMO_DEC4_OUT_DIR  := $(DEMO_DIR)/build_logic/sts_demo_dec4
export STS_DEMO_TNIU0_OUT_DIR := $(DEMO_DIR)/build_logic/sts_demo_tniu0
export STS_DEMO_TNIU1_OUT_DIR := $(DEMO_DIR)/build_logic/sts_demo_tniu1
export STS_DEMO_TNIU2_OUT_DIR := $(DEMO_DIR)/build_logic/sts_demo_tniu2
export STS_DEMO_TNIU3_OUT_DIR := $(DEMO_DIR)/build_logic/sts_demo_tniu3
export FCIP_DIR

BUILD_DIR    := $(SIM_DIR)/build
SIMV         := $(BUILD_DIR)/simv
COMPILE_LOG  := $(BUILD_DIR)/compile.log
TB_SV        := $(SIM_DIR)/tb_sts_logic_topo_1i4t.sv
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
             +define+ASIC_SIM \
             -P $(VERDI_PLI_TAB) $(VERDI_PLI_LIB)

.PHONY: all compile run_test regression sim_wave wave clean

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

run_test: $(SIMV)
	@if [ -z "$(TESTCASE)" ]; then echo "TESTCASE is required"; exit 1; fi
	mkdir -p $(BUILD_DIR)/logs
	cd $(BUILD_DIR) && $(SIMV) +TESTCASE=$(TESTCASE) $(SIM_ARGS) -l logs/$(TESTCASE).log

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
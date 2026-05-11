SIM_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DEMO_DIR := $(realpath $(SIM_DIR)/..)
REPO_ROOT := $(realpath $(DEMO_DIR)/../..)
BUILD_LOGIC_DIR := $(DEMO_DIR)/build_logic

FCIP_DIR := $(REPO_ROOT)/subs/fcip
LWNOC_LOWPOWER_COMPONENT := $(REPO_ROOT)/subs/lwnoc_lowpower_component

export INTR_NOC_DEMO_DIR := $(DEMO_DIR)
export FCIP_DIR
export LWNOC_LOWPOWER_COMPONENT
export INTR_INIU_TOP_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_iniu_top_side
export INTR_TNIU_TOP_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_tniu_top_side
export INTR_RING_NETWORK_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_ring_network
export INTR_RING_BUF_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_ring_buf
export INTR_RING_STATION_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_ring_station
export INTR_RING_LINK_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_ring_link
export INTR_RING_REQ_SINK_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_ring_req_sink
export INTR_RING_REQ_ZERO_SOURCE_OUT_DIR := $(BUILD_LOGIC_DIR)/intr_ring_req_zero_source
export SOC_INTR_RING_NOC := $(BUILD_LOGIC_DIR)

uppercase = $(shell printf '%s' '$(1)' | tr '[:lower:]-' '[:upper:]_')
SYS_BUILD_DIRS := $(sort $(notdir $(wildcard $(BUILD_LOGIC_DIR)/*_sys)))
$(foreach dir,$(SYS_BUILD_DIRS),$(eval export SOC_INTR_$(call uppercase,$(dir))_OUT_DIR := $(BUILD_LOGIC_DIR)/$(dir)))

VCS ?= vcs
TB_GEN := $(SIM_DIR)/gen_soc_intr_sanity_tb.py
TB_SV := $(SIM_DIR)/tb_soc_intr_noc_sanity.sv
DUT_FILELIST := $(DEMO_DIR)/build_logic/soc_intr_ring_noc/filelist.f
INTR_NOC_DIR := $(REPO_ROOT)/subs/lwnoc_interrupt_noc
INTR_NETWORK_DEFINE := $(INTR_NOC_DIR)/rtl/network/interrupt_network_define.sv

FOUNDATION_FILELISTS := \
	$(INTR_NETWORK_DEFINE) \
	-f $(FCIP_DIR)/vc/arbiter.f \
	-f $(FCIP_DIR)/vc/async_fifo.f \
	-f $(FCIP_DIR)/vc/basic.f \
	-f $(FCIP_DIR)/vc/ecc_codec.f \
	-f $(FCIP_DIR)/vc/memory.f \
	-f $(FCIP_DIR)/vc/regslice.f \
	-f $(FCIP_DIR)/vc/stdcell_wrap.f \
	-f $(FCIP_DIR)/vc/sync_fifo.f \
	-f $(FCIP_DIR)/vc/handshake.f \
	-f $(FCIP_DIR)/vc/mem_model.f \
	-f $(LWNOC_LOWPOWER_COMPONENT)/src/vc/lwnoc_lp_core.f
BUILD_DIR := $(SIM_DIR)/build
SIMV := $(BUILD_DIR)/simv
COMPILE_LOG := $(BUILD_DIR)/compile.log
SIM_LOG := $(BUILD_DIR)/tc_sanity.log

VCS_FLAGS := -full64 \
	-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS "-Wl,-no-pie -Wl,--no-as-needed" \
	-sverilog \
	-timescale=1ns/1ps \
	+v2k \
	+notimingcheck \
	+lint=TFIPC-L \
	+error+OPD

.PHONY: compile sim clean

compile:
	python3 $(TB_GEN)
	mkdir -p $(BUILD_DIR) $(BUILD_DIR)/simv.daidir/debug_dump
	cd $(SIM_DIR) && $(VCS) $(VCS_FLAGS) \
	    $(FOUNDATION_FILELISTS) \
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
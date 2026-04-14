# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

LWNOC Low-Power Component — a SystemVerilog RTL design implementing power management for a Network-on-Chip (NoC). It supports multi-level power gating (levels 0-3) via P-channel protocol with distributed FSM control across hub-based interconnect topology.

## Build Commands

Environment setup (required before all commands):
```bash
source prj.env
```

All build targets run from `qc/makefile` and require VCS:

| Command | Purpose |
|---------|---------|
| `make -f qc/makefile comp` | Compile core RTL (uses `src/vc/lwnoc_lp_core.f`) |
| `make -f qc/makefile comp_dut` | Compile DUT with FCIP dependencies (uses `src/vc/dut.f`) |
| `make -f qc/makefile comp_tb` | Compile full testbench with debug access (uses `src/vc/tb.f`) |
| `make -f qc/makefile lint` | Run FDE lint (config: `qc/lint.tcl`, waivers: `qc/lint.awl`) |
| `make -f qc/makefile clean` | Remove `work/` simulation artifacts |

Simulation output goes to `work/` directory. After `comp_tb`, run `./work/simv` to execute.

## Architecture

### Signal Flow

P-channel master (external) → **INIU** (pchn_niu → iniu) → **Hub** (interconnect) → **TNIU** (func_tniu/func_iniu → async_bridge → target domain)

### Key Subsystems

- **lp_common/lp_fsm/**: Two-stage FSM hierarchy — `stg1_fsm` handles activation/deactivation sequencing, `stg2_fsm` handles power state transitions, `niu_fsm` orchestrates both stages. Every NIU and slave adapter uses this FSM stack.
- **lp_hub/**: Parameterizable crossbar that aggregates `lwnoc_lp_req_signal_t` signals from multiple terminals. Auto-selects size variant (tiny ≤3, small =4, large ≥5) via `hub_wrapper`. Aggregation uses OR/AND reduction on `stg1_req`, `stg2_req`, and `deny` fields.
- **lp_iniu/**: Initiator-side — translates P-channel power state requests into internal LP request protocol.
- **lp_tniu/**: Target-side — includes async clock domain bridge, default slave (with configurable timeout), stall logic for in-flight transactions, and a dummy master for testing.
- **lp_common/lwnoc_lp_endpoint**: CDC synchronizer wrapper using FCIP sync cells for cross-domain LP signals.
- **lp_common/lwnoc_lp_nest**: Isolates a subdomain from the main LP domain (quarantine pattern).

### Packages

- `lwnoc_lp_define_package`: Enums — FSM states (`lwnoc_lp_main_fsm_state_t`), power levels (`lwnoc_lp_state_t`), P-channel states (`lwnoc_pchannel_state_t`)
- `lwnoc_lp_struct_package`: `lwnoc_lp_req_signal_t` struct — the core request bundle carrying `stg1_req_or/and`, `stg2_req_or/and`, `state`, `deny_or/and`

### External Dependency

FCIP (git submodule at `src/rtl/fcip/`) — provides CDC primitives: `fcip_sync_cell`, `fcip_sync_arst`, `fcip_sync_aset`, `fcip_marker`. Initialize with `git submodule update --init`.

## Verification

Testbench at `src/verif/tb_dut.sv` with P-channel Master VIP (`src/verif/vip/pchn_mst_vip.sv`). VIP provides tasks: `power_on()`, `level1_off()`, `level2_off()`, `level3_off()`, `send_request()`. DUT wrapper at `src/verif/dut.sv` instantiates a two-hub topology with INIU and multiple TNIU variants.

## Conventions

- Module prefix: `lwnoc_lp_`
- Signal suffixes: `_req` (request), `_ack`/`_accept` (acknowledge), `_deny` (denial), `rx_`/`tx_` (direction), `rst_n` (active-low reset)
- Parameters: `UPPER_SNAKE_CASE` (e.g., `NUM_TERMINAL`, `TIME_OUT_WIDTH`)
- File headers include author, description, copyright (BeYourDad Co., Ltd.)
- Filelists in `src/vc/*.f` use `$LWNOC_LOWPOWER_COMPONENT` and `$FCIP_DIR` env vars
- Commit messages: brief imperative style (e.g., "add configurable timeout", "fix lint")

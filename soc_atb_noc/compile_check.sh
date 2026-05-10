#!/bin/bash
# Compile script for ATB NoC demo — DTI-style auto-mapping env vars to build_logic
set -e

DEMO_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BL_DIR="$DEMO_DIR/build_logic"
TOPO_FL="$BL_DIR/atb_soc_topo/filelist.f"
COMPILE_LOG="$DEMO_DIR/compile_atb_soc.log"
COMPILE_DIR="$DEMO_DIR/build/compile"
mkdir -p "$COMPILE_DIR"
rm -f "$COMPILE_LOG"

echo "=== ATB NoC Compile ===" | tee "$COMPILE_LOG"
echo "Mapping env vars from $TOPO_FL" | tee -a "$COMPILE_LOG"

cd "$DEMO_DIR"

export ATB_SOC_TOP="$BL_DIR"
export SOC_ATB_NOC_DIR="$DEMO_DIR"
echo "  ATB_SOC_TOP=$ATB_SOC_TOP" | tee -a "$COMPILE_LOG"
echo "  SOC_ATB_NOC_DIR=$SOC_ATB_NOC_DIR" | tee -a "$COMPILE_LOG"

# Export every published build_logic directory using the <UPPER_DIR>_DIR convention.
while IFS= read -r dir_path; do
    dir_name="$(basename "$dir_path")"
    env_var="$(echo "$dir_name" | tr '[:lower:]-' '[:upper:]_')_DIR"
    export "$env_var=$dir_path"
    echo "  $env_var=${!env_var}" | tee -a "$COMPILE_LOG"
done < <(find "$BL_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

# Foundation IP env vars (FCIP, LP, etc.)
export FCIP_DIR="$DEMO_DIR/../subs/fcip"
export LWNOC_LOWPOWER_COMPONENT="$DEMO_DIR/../subs/lwnoc_lowpower_component"
echo "  FCIP_DIR=$FCIP_DIR" | tee -a "$COMPILE_LOG"
echo "  LWNOC_LOWPOWER_COMPONENT=$LWNOC_LOWPOWER_COMPONENT" | tee -a "$COMPILE_LOG"

echo "" | tee -a "$COMPILE_LOG"
echo "=== Running Verilator lint ===" | tee -a "$COMPILE_LOG"

cd "$COMPILE_DIR"
verilator --lint-only -Wall -Wno-fatal \
    -f "$FCIP_DIR/vc/arbiter.f" \
    -f "$FCIP_DIR/vc/async_fifo.f" \
    -f "$FCIP_DIR/vc/basic.f" \
    -f "$FCIP_DIR/vc/ecc_codec.f" \
    -f "$FCIP_DIR/vc/memory.f" \
    -f "$FCIP_DIR/vc/regslice.f" \
    -f "$FCIP_DIR/vc/stdcell_wrap.f" \
    -f "$FCIP_DIR/vc/sync_fifo.f" \
    -f "$FCIP_DIR/vc/handshake.f" \
    "$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_define_package.sv" \
    "$LWNOC_LOWPOWER_COMPONENT/src/rtl/lwnoc_lp_struct_package.sv" \
    -f "$LWNOC_LOWPOWER_COMPONENT/src/vc/lwnoc_lp_core.f" \
    -f "$TOPO_FL" \
    --top-module atb_soc_topo \
    2>&1 | tail -80 | tee -a "$COMPILE_LOG"

if grep -E "%Error|%Error-" "$COMPILE_LOG" > /dev/null 2>&1; then
    echo "" | tee -a "$COMPILE_LOG"
    echo "=== LINT FAILED - see $COMPILE_LOG ===" | tee -a "$COMPILE_LOG"
    grep -c "%Error" "$COMPILE_LOG" | xargs echo "Error count:" | tee -a "$COMPILE_LOG"
    exit 1
else
    echo "" | tee -a "$COMPILE_LOG"
    echo "=== LINT PASSED ===" | tee -a "$COMPILE_LOG"
fi

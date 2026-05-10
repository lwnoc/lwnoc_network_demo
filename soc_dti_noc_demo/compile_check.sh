#!/bin/bash
# Compile script for DTI NoC demo - auto-maps env vars from filelist to build_logic
set -e

DEMO_DIR="/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo"
BL_DIR="$DEMO_DIR/build_logic"
TOPO_FL="$BL_DIR/dti_logic_topo/filelist.f"
COMPILE_LOG="$DEMO_DIR/compile_soc_dti.log"
COMPILE_DIR="$DEMO_DIR/build/compile"
mkdir -p "$COMPILE_DIR"
rm -f "$COMPILE_LOG"

echo "=== DTI NoC Compile ===" | tee "$COMPILE_LOG"
echo "Mapping env vars from $TOPO_FL" | tee -a "$COMPILE_LOG"

cd "$DEMO_DIR"

# Extract all unique $ENV from filelist -f lines and map them to build_logic dirs
declare -A env_map

while IFS= read -r line; do
    # Parse -f $ENV/x → extract ENV and map to build_logic/<mapped_dir>
    if [[ "$line" =~ ^-f[[:space:]]+\$([A-Za-z_0-9]+)/(.*)$ ]]; then
        env_var="${BASH_REMATCH[1]}"
        # Determine build_logic dir from env_var naming convention
        # e.g. DTI_SW0_OUT_DIR → dti_sw0
        # e.g. NPU_INIU_SYS_DIR → npu_iniu_sys
        # e.g. DTI_INIU_TOP_NPU_SS0_DIR → dti_iniu_top_side_npu_ss0
        bl_dir="${env_var}"
        # Convert to lowercase and replace OUT_/SYS_/TOP_ patterns
        bl_dir=$(echo "$bl_dir" | tr '[:upper:]' '[:lower:]')
        bl_dir="${bl_dir/_out_dir/}"
        bl_dir="${bl_dir/_sys_dir/}"
        # DTI_INIU_TOP_*_DIR → dti_iniu_top_side_*
        bl_dir="${bl_dir/_dir/}"
        # Special: rebuild to match DtiTemplate naming
        if [[ "$bl_dir" == dti_iniu_top_* ]]; then
            # dti_iniu_top_npu_ss0 → dti_iniu_top_side_npu_ss0
            bl_dir="dti_iniu_top_side_${bl_dir#dti_iniu_top_}"
        fi
        # Check if the mapped dir exists
        if [[ -d "$BL_DIR/$bl_dir" ]]; then
            export "$env_var=$BL_DIR/$bl_dir"
            echo "  $env_var → $bl_dir" | tee -a "$COMPILE_LOG"
        else
            echo "  WARN: $env_var → $bl_dir (NOT FOUND at $BL_DIR/$bl_dir)" | tee -a "$COMPILE_LOG"
        fi
    fi
done < "$TOPO_FL"

# Also set foundation IP env vars (FCIP, LP, etc.) from DtiTemplate
export FCIP_DIR="/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip"
export LWNOC_LOWPOWER_COMPONENT="/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_lowpower_component"
export DTI_PR="/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc"

echo "" | tee -a "$COMPILE_LOG"
echo "=== Running VCS compile check ===" | tee -a "$COMPILE_LOG"

# VCS syntax-only check (no elaboration)
cd "$COMPILE_DIR"
vcs \
    -f "$TOPO_FL" \
    -sverilog \
    -timescale=1ns/1ps \
    +lint=all \
    -notice \
    -l "$COMPILE_LOG" \
    -o simv_dti_soc \
    2>&1 | tee -a "$COMPILE_LOG" || true

# Check result
if grep -E "Error[^:]|error:" "$COMPILE_LOG" | grep -v "warning" > /dev/null 2>&1; then
    echo "" | tee -a "$COMPILE_LOG"
    echo "=== COMPILE FAILED - see $COMPILE_LOG ===" | tee -a "$COMPILE_LOG"
    grep -E "Error[^:]" "$COMPILE_LOG" | head -20 | tee -a "$COMPILE_LOG"
else
    echo "" | tee -a "$COMPILE_LOG"
    echo "=== COMPILE PASSED ===" | tee -a "$COMPILE_LOG"
fi

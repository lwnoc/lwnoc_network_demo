#!/bin/bash
# Generate expanded filelist for lint analysis
# This script creates a flat filelist with absolute paths

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="$(dirname "$SCRIPT_DIR")"
LWNOC_DIR="$(dirname "$(dirname "$DEMO_DIR")")"

# Directories
INTR_RING_NOC_DIR="$LWNOC_DIR/subs/lwnoc_interrupt_noc/rtl/network"
INTR_NOC_DEMO_DIR="$LWNOC_DIR/lwnoc_intr_noc_demo"
SOC_INTR_DEMO_DIR="$DEMO_DIR"
FCIP_DIR="$LWNOC_DIR/subs/lwnoc_interrupt_noc/fcip"

OUT_FILE="$SCRIPT_DIR/soc_intr_lint_expanded.f"

# Start output file
cat > "$OUT_FILE" <<EOF
// Auto-generated expanded filelist for soc_intr_noc_demo
// Generated on $(date)

// FCIP modules
EOF

# Add FCIP basic modules
if [[ -f "$FCIP_DIR/ip/basic/fcip_basic.f" ]]; then
  cat "$FCIP_DIR/ip/basic/fcip_basic.f" | grep -v "^//" | grep -v "^#" | grep -v "^$" | sed "s#^#$FCIP_DIR/ip/basic/#" >> "$OUT_FILE"
fi

# Add async FIFO modules
if [[ -f "$FCIP_DIR/ip/async_fifo/fcip_async_fifo.f" ]]; then
  cat "$FCIP_DIR/ip/async_fifo/fcip_async_fifo.f" | grep -v "^//" | grep -v "^#" | grep -v "^$" | sed "s#^#$FCIP_DIR/ip/async_fifo/#" >> "$OUT_FILE"
fi

# Add arbiter modules
if [[ -f "$FCIP_DIR/ip/arbiter/fcip_arbiter.f" ]]; then
  cat "$FCIP_DIR/ip/arbiter/fcip_arbiter.f" | grep -v "^//" | grep -v "^#" | grep -v "^$" | sed "s#^#$FCIP_DIR/ip/arbiter/#" >> "$OUT_FILE"
fi

# Add core interrupt ring network modules
cat >> "$OUT_FILE" <<EOF

// Core interrupt ring network modules
EOF

for f in \
  "$INTR_RING_NOC_DIR/lwnoc_sync_cell.sv" \
  "$INTR_RING_NOC_DIR/lwnoc_sfifo.sv" \
  "$INTR_RING_NOC_DIR/lwnoc_vcbuf.sv" \
  "$INTR_RING_NOC_DIR/lwmnoc_flow_ctrl_buf.sv" \
  "$INTR_RING_NOC_DIR/lwmnoc_flow_ctrl_chk.sv" \
  "$INTR_RING_NOC_DIR/lwmnoc_rob_pingpong_prealloc.sv" \
  "$INTR_RING_NOC_DIR/lwnoc_ring_buf.sv" \
  "$INTR_RING_NOC_DIR/lwnoc_ring_station.sv" \
  "$INTR_RING_NOC_DIR/lwnoc_station_buffer.sv" \
  "$INTR_RING_NOC_DIR/intr_station_temp_mem_model.sv" \
  "$INTR_RING_NOC_DIR/intr_ring_buf_wrap.sv"; do
  if [[ -f "$f" ]]; then
    echo "$f" >> "$OUT_FILE"
  fi
done

# Add demo-specific modules from existing filelist
if [[ -f "$SOC_INTR_DEMO_DIR/filelist_pd/filelist.f" ]]; then
  cat >> "$OUT_FILE" <<EOF

// Demo-specific generated and wrapped modules
EOF
  cat "$SOC_INTR_DEMO_DIR/filelist_pd/filelist.f" | grep -v "^//" | grep -v "^#" | grep -v "^$" | grep -v "^-f" >> "$OUT_FILE"
fi

echo "[INFO] Expanded filelist created: $OUT_FILE"
wc -l "$OUT_FILE"

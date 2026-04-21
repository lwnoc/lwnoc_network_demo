#!/bin/bash
# Environment setup for soc_intr_noc_demo lint analysis

set -e

# Resolve absolute paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="$(dirname "$SCRIPT_DIR")"
LWNOC_DIR="$(dirname "$(dirname "$DEMO_DIR")")"

# Export key directories
export SOC_INTR_DEMO_DIR="$DEMO_DIR"
export INTR_RING_NOC_DIR="${INTR_RING_NOC_DIR:-$LWNOC_DIR/subs/lwnoc_interrupt_noc/rtl/network}"
export INTR_NOC_DEMO_DIR="${INTR_NOC_DEMO_DIR:-$LWNOC_DIR/lwnoc_intr_noc_demo}"
export FCIP_DIR="${FCIP_DIR:-$LWNOC_DIR/subs/lwnoc_interrupt_noc/fcip}"

# Set svlinter path
SVLINT_WORK="${SVLINT_WORK:-/home/lgzhu/dev/svlint_work}"
export SVLINTER="${SVLINTER:-$SVLINT_WORK/.venv/bin/svlinter}"

echo "[INFO] Environment setup complete:"
echo "  SOC_INTR_DEMO_DIR: $SOC_INTR_DEMO_DIR"
echo "  INTR_RING_NOC_DIR: $INTR_RING_NOC_DIR"
echo "  INTR_NOC_DEMO_DIR: $INTR_NOC_DEMO_DIR"
echo "  SVLINTER: $SVLINTER"

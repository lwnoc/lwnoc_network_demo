#!/usr/bin/env bash
set -euo pipefail

THIS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
REPO_ROOT="$(dirname "${THIS_DIR}")"

export SOC_ATB_NOC_DIR="${THIS_DIR}"
export LWNOC_TOPO_DIR="${REPO_ROOT}/lwnoc_topo"
export PYTHONPATH="${SOC_ATB_NOC_DIR}:${LWNOC_TOPO_DIR}:${PYTHONPATH:-}"

echo "SOC_ATB_NOC_DIR=${SOC_ATB_NOC_DIR}"
echo "LWNOC_TOPO_DIR=${LWNOC_TOPO_DIR}"

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== STS NoC workspace hygiene =="
echo "root: $ROOT_DIR"
echo

print_size() {
  local path="$1"
  if [ -e "$path" ]; then
    du -sh "$path"
  fi
}

echo "-- generated artifact sizes --"
print_size log
print_size work
print_size csrc
print_size simv.daidir
print_size cov
print_size simv.vdb
print_size debug.vcd
echo

echo "-- largest log files --"
if [ -d log ]; then
  find log -maxdepth 1 -type f -printf '%s %p\n' | sort -nr | head -n 10 | awk '{printf "%8.1f KB  %s\n", $1 / 1024.0, $2}'
else
  echo "log/ not present"
fi
echo

echo "-- editor hygiene hints --"
if [ -f .vscode/settings.json ]; then
  echo ".vscode/settings.json present"
else
  echo "missing .vscode/settings.json"
fi

if [ -d csrc ] || [ -d simv.daidir ] || [ -d work ] || [ -d cov ]; then
  echo "consider: make clean_generated"
fi

echo "for debug-only traces, use: make <target> SIM_ARGS='+ENABLE_TRACE +ENABLE_VCD'"
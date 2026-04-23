#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SHARED_BUILD_DIR="$ROOT_DIR/build_logic"
FULL_RING_DIR="$SHARED_BUILD_DIR/soc_intr_ring_top"
UP_HARDEN_DIR="$SHARED_BUILD_DIR/soc_intr_ring_noc_up_harden_wrap"
DN_HARDEN_DIR="$SHARED_BUILD_DIR/soc_intr_ring_noc_dn_harden_wrap"
HARDEN_TOP_DIR="$SHARED_BUILD_DIR/soc_intr_ring_top_pd"
LEGACY_HARDEN_TOP_DIR="$ROOT_DIR/build_logic_pd/soc_intr_ring_noc_harden_top"
LEGACY_PD_WRAP_DIR="$SHARED_BUILD_DIR/soc_intr_noc_wrap_pd"
HARDEN_FILELIST="$ROOT_DIR/filelist_pd/filelist_harden.f"
PD_ENTRY_FILELIST="$ROOT_DIR/filelist_pd/filelist.f"
UP_FILELIST="$UP_HARDEN_DIR/filelist.f"
DN_FILELIST="$DN_HARDEN_DIR/filelist.f"
TOP_FILELIST="$HARDEN_TOP_DIR/filelist.f"

if [[ ! -d "$SHARED_BUILD_DIR" ]]; then
  echo "status: fail"
  echo "reason: missing_shared_build_logic"
  echo "path: $SHARED_BUILD_DIR"
  exit 2
fi

if [[ ! -d "$FULL_RING_DIR" ]]; then
  echo "status: fail"
  echo "reason: missing_full_ring_shared_root"
  echo "path: $FULL_RING_DIR"
  exit 2
fi

if [[ ! -d "$HARDEN_TOP_DIR" ]]; then
  echo "status: fail"
  echo "reason: missing_harden_top_shared_root"
  echo "path: $HARDEN_TOP_DIR"
  exit 2
fi

if [[ ! -d "$UP_HARDEN_DIR" ]]; then
  echo "status: fail"
  echo "reason: missing_up_harden_partition_dir"
  echo "path: $UP_HARDEN_DIR"
  exit 2
fi

if [[ ! -d "$DN_HARDEN_DIR" ]]; then
  echo "status: fail"
  echo "reason: missing_dn_harden_partition_dir"
  echo "path: $DN_HARDEN_DIR"
  exit 2
fi

UP_WRAP="$UP_HARDEN_DIR/soc_intr_ring_noc_up_harden_wrap.v"
DN_WRAP="$DN_HARDEN_DIR/soc_intr_ring_noc_dn_harden_wrap.v"
HARDEN_TOP_WRAP="$HARDEN_TOP_DIR/soc_intr_ring_top_pd.v"

MISSING_WRAPPERS=()
[[ ! -f "$UP_WRAP" ]] && MISSING_WRAPPERS+=("$UP_WRAP")
[[ ! -f "$DN_WRAP" ]] && MISSING_WRAPPERS+=("$DN_WRAP")
[[ ! -f "$HARDEN_TOP_WRAP" ]] && MISSING_WRAPPERS+=("$HARDEN_TOP_WRAP")

if [[ ${#MISSING_WRAPPERS[@]} -gt 0 ]]; then
  echo "status: fail"
  echo "reason: missing_shared_root_harden_payload"
  for w in "${MISSING_WRAPPERS[@]}"; do echo "  missing: $w"; done
  exit 3
fi

if [[ ! -f "$UP_FILELIST" ]]; then
  echo "status: fail"
  echo "reason: missing_up_partition_filelist"
  echo "path: $UP_FILELIST"
  exit 4
fi

if [[ ! -f "$DN_FILELIST" ]]; then
  echo "status: fail"
  echo "reason: missing_dn_partition_filelist"
  echo "path: $DN_FILELIST"
  exit 4
fi

if [[ ! -f "$TOP_FILELIST" ]]; then
  echo "status: fail"
  echo "reason: missing_top_partition_filelist"
  echo "path: $TOP_FILELIST"
  exit 4
fi

if [[ ! -f "$HARDEN_FILELIST" ]]; then
  echo "status: fail"
  echo "reason: missing_harden_filelist"
  echo "path: $HARDEN_FILELIST"
  exit 5
fi

if [[ ! -f "$PD_ENTRY_FILELIST" ]]; then
  echo "status: fail"
  echo "reason: missing_pd_entry_filelist"
  echo "path: $PD_ENTRY_FILELIST"
  exit 6
fi

if rg -n "build_logic_pd" "$HARDEN_FILELIST" >/dev/null 2>&1; then
  echo "status: fail"
  echo "reason: harden_filelist_uses_legacy_root"
  echo "file: $HARDEN_FILELIST"
  echo "legacy_root: build_logic_pd"
  exit 7
fi

EXPECTED_HARDEN_FILELIST_ENTRIES=(
  '-f $INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_top_pd/filelist.f'
)

MISSING_FILELIST_ENTRIES=()
for entry in "${EXPECTED_HARDEN_FILELIST_ENTRIES[@]}"; do
  if ! rg -n -F -- "$entry" "$HARDEN_FILELIST" >/dev/null 2>&1; then
    MISSING_FILELIST_ENTRIES+=("$entry")
  fi
done

if [[ ${#MISSING_FILELIST_ENTRIES[@]} -gt 0 ]]; then
  echo "status: fail"
  echo "reason: missing_harden_ingress_entries"
  for entry in "${MISSING_FILELIST_ENTRIES[@]}"; do echo "  missing: $entry"; done
  exit 8
fi

EXPECTED_UP_FILELIST_ENTRIES=(
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_up_harden_wrap/cpu_ss_iniu_noc_side.v'
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_up_harden_wrap/ddr11_tniu_noc_side.v'
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_up_harden_wrap/soc_intr_ring_noc_up_harden_wrap.v'
)

EXPECTED_DN_FILELIST_ENTRIES=(
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_dn_harden_wrap/mipi_ss_iniu_noc_side.v'
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_dn_harden_wrap/ucie_ss0_tniu_noc_side.v'
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_dn_harden_wrap/soc_intr_ring_noc_dn_harden_wrap.v'
)

EXPECTED_TOP_FILELIST_ENTRIES=(
  '-f $INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_up_harden_wrap/filelist.f'
  '-f $INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_noc_dn_harden_wrap/filelist.f'
  '$INTR_NOC_DEMO_DIR/build_logic/soc_intr_ring_top_pd/soc_intr_ring_top_pd.v'
)

check_filelist_entries() {
  local target_file="$1"
  shift
  missing_entries=()
  for entry in "$@"; do
    if ! rg -n -F -- "$entry" "$target_file" >/dev/null 2>&1; then
      missing_entries+=("$entry")
    fi
  done
  if [[ ${#missing_entries[@]} -gt 0 ]]; then
    echo "status: fail"
    echo "reason: partition_filelist_missing_entries"
    echo "file: $target_file"
    for entry in "${missing_entries[@]}"; do echo "  missing: $entry"; done
    exit 9
  fi
}

check_filelist_entries "$UP_FILELIST" "${EXPECTED_UP_FILELIST_ENTRIES[@]}"
check_filelist_entries "$DN_FILELIST" "${EXPECTED_DN_FILELIST_ENTRIES[@]}"
check_filelist_entries "$TOP_FILELIST" "${EXPECTED_TOP_FILELIST_ENTRIES[@]}"

FORBIDDEN_TOP_PAYLOAD=(
  "$HARDEN_TOP_DIR/intr_network_flat.svh"
  "$HARDEN_TOP_DIR/intr_niu_flat.svh"
  "$HARDEN_TOP_DIR/soc_intr_ring_noc_up_harden_wrap.v"
  "$HARDEN_TOP_DIR/soc_intr_ring_noc_dn_harden_wrap.v"
)

FORBIDDEN_PARTITION_FLATS=(
  "$UP_HARDEN_DIR/intr_network_flat.svh"
  "$UP_HARDEN_DIR/intr_niu_flat.svh"
  "$DN_HARDEN_DIR/intr_network_flat.svh"
  "$DN_HARDEN_DIR/intr_niu_flat.svh"
)

LEAKED_TOP_PAYLOAD=()
for path in "${FORBIDDEN_TOP_PAYLOAD[@]}"; do
  if [[ -e "$path" ]]; then
    LEAKED_TOP_PAYLOAD+=("$path")
  fi
done

if [[ ${#LEAKED_TOP_PAYLOAD[@]} -gt 0 ]]; then
  echo "status: fail"
  echo "reason: top_dir_contains_partition_payload"
  for path in "${LEAKED_TOP_PAYLOAD[@]}"; do echo "  leaked: $path"; done
  exit 10
fi

LEAKED_PARTITION_FLATS=()
for path in "${FORBIDDEN_PARTITION_FLATS[@]}"; do
  if [[ -e "$path" ]]; then
    LEAKED_PARTITION_FLATS+=("$path")
  fi
done

if [[ ${#LEAKED_PARTITION_FLATS[@]} -gt 0 ]]; then
  echo "status: fail"
  echo "reason: partition_dir_contains_flat_headers"
  for path in "${LEAKED_PARTITION_FLATS[@]}"; do echo "  leaked: $path"; done
  exit 10
fi

if [[ -d "$LEGACY_PD_WRAP_DIR" ]]; then
  echo "status: fail"
  echo "reason: legacy_pd_wrapper_dir_present"
  echo "path: $LEGACY_PD_WRAP_DIR"
  exit 10
fi

if ! rg -n "filelist_harden\.f" "$PD_ENTRY_FILELIST" >/dev/null 2>&1; then
  echo "status: fail"
  echo "reason: pd_entry_missing_harden_ingress"
  echo "pd_entry: $PD_ENTRY_FILELIST"
  echo "expected_ingress: -f \$INTR_NOC_DEMO_DIR/filelist_pd/filelist_harden.f"
  exit 11
fi

echo "status: pass"
echo "shared_build_dir: $SHARED_BUILD_DIR"
echo "full_ring_dir: $FULL_RING_DIR"
echo "up_harden_dir: $UP_HARDEN_DIR"
echo "dn_harden_dir: $DN_HARDEN_DIR"
echo "harden_top_dir: $HARDEN_TOP_DIR"
if [[ -d "$LEGACY_HARDEN_TOP_DIR" ]]; then
  echo "legacy_harden_top_dir: present_non_authoritative"
else
  echo "legacy_harden_top_dir: absent"
fi
echo "legacy_pd_wrap_dir: absent"
echo "up_harden_wrap: $(basename $UP_WRAP) found"
echo "dn_harden_wrap: $(basename $DN_WRAP) found"
echo "harden_top_wrap: $(basename $HARDEN_TOP_WRAP) found"
echo "harden_filelist: $HARDEN_FILELIST found"
echo "up_filelist: $UP_FILELIST found"
echo "dn_filelist: $DN_FILELIST found"
echo "top_filelist: $TOP_FILELIST found"
echo "partition_flat_headers: absent_from_up_dn_dirs"
echo "pd_entry_ingress: filelist_harden.f referenced in $(basename $PD_ENTRY_FILELIST)"
echo "result: partitioned_shared_root_harden_output_gate_passed"

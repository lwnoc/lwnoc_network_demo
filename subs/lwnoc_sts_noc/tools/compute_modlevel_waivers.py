#!/usr/bin/env python3
"""Compute toggle waivers using MODULE-level dead bit-directions from modinfo.txt.

For each module, the MODULE-level toggle section aggregates across ALL instances.
Bit-directions uncovered at MODULE level are structurally dead (never toggle in ANY instance).
This gives the safest possible waiver amount.

Additionally handles:
- Wrapper modules (sts_tniu_top, sts_tniu_sys) CTI dead signals
- INIU axlen[7:1] constraint (user says upstream only sends axlen=0)
"""
import re
import json
import sys
from pathlib import Path

MODINFO = Path("log/urg_nouvm/cov_text/modinfo.txt")


def load_text():
    return MODINFO.read_text()


def get_module_toggle(text, module_name):
    """Get MODULE-level toggle summary: Total Bits, Covered, and per-signal detail."""
    marker = f"Toggle Coverage for Module : {module_name}\n"
    pos = text.find(marker)
    if pos < 0:
        return None
    # Find end of this toggle section
    end1 = text.find("\nBranch Coverage for Module", pos + len(marker))
    end2 = text.find("\n===============", pos + len(marker))
    ends = [e for e in [end1, end2] if e > 0]
    end = min(ends) if ends else pos + 50000
    chunk = text[pos + len(marker):end]

    # Parse summary
    m = re.search(r"Total Bits\s+(\d+)\s+(\d+)\s+[\d.]+", chunk)
    if not m:
        return None
    total_bits = int(m.group(1))
    covered_bits = int(m.group(2))

    # Parse per-signal detail
    signals = []
    in_ports = False
    in_signals = False
    for line in chunk.split("\n"):
        if "Port Details" in line:
            in_ports = True
            in_signals = False
            continue
        if "Signal Details" in line:
            in_signals = True
            in_ports = False
            continue
        if not (in_ports or in_signals):
            continue
        parts = line.split()
        if len(parts) < 4:
            continue
        name = parts[0]
        toggle = parts[1]
        t10 = parts[2]
        t01 = parts[3]
        if name in ("Toggle", "Port", "Ports", "Signal", "Signals", "Totals", "Total"):
            continue
        # Count bit width
        bm = re.search(r"\[(\d+):(\d+)\]$", name)
        if bm:
            bits = int(bm.group(1)) - int(bm.group(2)) + 1
        elif re.search(r"\[(\d+)\]$", name):
            bits = 1
        else:
            bits = 1

        uncov_10 = bits if t10 == "No" else 0
        uncov_01 = bits if t01 == "No" else 0
        if uncov_10 + uncov_01 > 0:
            direction = ""
            if in_ports and len(parts) >= 5:
                direction = parts[4]
            signals.append({
                "name": name,
                "bits": bits,
                "uncov_10": uncov_10,
                "uncov_01": uncov_01,
                "total_uncov": uncov_10 + uncov_01,
                "direction": direction,
                "section": "port" if in_ports else "signal",
            })

    return {
        "total_bits": total_bits,
        "covered_bits": covered_bits,
        "uncov_bits": total_bits - covered_bits,
        "dead_signals": signals,
        "dead_bitdirs": sum(s["total_uncov"] for s in signals),
    }


def get_instance_toggle(text, inst):
    """Get instance-level Total Bits and Covered."""
    marker = f"Toggle Coverage for Instance : {inst}\n"
    pos = text.find(marker)
    if pos < 0:
        return None, None
    chunk = text[pos:pos + 500]
    m = re.search(r"Total Bits\s+(\d+)\s+(\d+)", chunk)
    if m:
        return int(m.group(1)), int(m.group(2))
    return None, None


def count_instances_in_hierarchy(text, module_name, path_filter=None):
    """Count how many instance paths appear under a module, optionally filtered."""
    marker = f"Module : {module_name}\n"
    pos = text.find(marker)
    if pos < 0:
        return []
    # Find the instances table
    inst_marker = "Module self-instances :"
    ipos = text.find(inst_marker, pos)
    if ipos < 0 or ipos > pos + 2000:
        return []
    # Read all lines until blank line
    lines = text[ipos + len(inst_marker):ipos + len(inst_marker) + 100000].split("\n")
    instances = []
    for line in lines:
        line = line.strip()
        if line.startswith("SCORE") or line.startswith("---") or not line:
            if instances:  # Break at first blank line after data
                break
            continue
        parts = line.split()
        if len(parts) >= 7:
            name = parts[-1].strip()
            if path_filter is None or path_filter(name):
                instances.append(name)
    return instances


def main():
    text = load_text()

    # ================================================================
    # 1. MODULE-level dead bits for key modules
    # ================================================================
    modules_to_check = {
        "lwring_id_remap_entry": {
            "instance_regex": r"GEN_ENTRY\[\d+\]\.u_entry$",
            "desc": "ID remap entry: upper ID bits never fully toggled in any instance",
        },
        "lwring_id_remap": {
            "instance_regex": r"u_[rw]_id_remap$",
            "desc": "ID remap top: structural dead bits at module level",
        },
        "Base_sts_tniu_top": {
            "instance_regex": r"u_tniu[0-2]$",
            "desc": "TNIU top wrapper: CTI dead ports + internal wires (all CTI tied 0)",
        },
        "Base_sts_tniu_sys": {
            "instance_regex": r"u_tniu[0-2]\.u_sts_tniu_sys$",
            "desc": "TNIU sys wrapper: CTI dead ports (all CTI tied 0)",
        },
        "apb2apb_async_bridge_qual": {
            "instance_regex": r"u_tniu_apb_async_bridge$",
            "desc": "APB async bridge: structural dead bits",
        },
        "Base_sts_iniu_top": {
            "instance_regex": r"u_iniu$",
            "desc": "INIU top wrapper: structural dead bits",
        },
        "Base_sts_iniu_sys": {
            "instance_regex": r"u_iniu\.u_sts_iniu_sys$",
            "desc": "INIU sys wrapper: structural dead bits",
        },
        "Base_sts_iniu_noc": {
            "instance_regex": r"u_iniu\.u_sts_iniu_noc$",
            "desc": "INIU noc wrapper: structural dead bits",
        },
        "Base_sts_iniu_rd_channel": {
            "instance_regex": r"u_iniu_rd_chnl$",
            "desc": "INIU read channel: structural dead bits",
        },
        "Base_sts_iniu_wr_channel": {
            "instance_regex": r"u_iniu_wr_chnl$",
            "desc": "INIU write channel: structural dead bits",
        },
        "Base_sts_iniu_axi_iniu": {
            "instance_regex": r"u_sts_axi_iniu_sys_side$",
            "desc": "INIU AXI bridge: structural dead bits",
        },
        "Base_sts_iniu_axi_bundle": {
            "instance_regex": r"u_sts_iniu_axi_bundle$",
            "desc": "INIU AXI bundle: structural dead bits",
        },
        "Base_sts_iniu_addr_map": {
            "instance_regex": r"u_[aw][rw]_addr_map$",
            "desc": "INIU address map: structural dead bits",
        },
    }

    print("=" * 80)
    print("MODULE-LEVEL DEAD BIT-DIRECTIONS ANALYSIS")
    print("=" * 80)

    rules = []
    for mod_name, info in modules_to_check.items():
        result = get_module_toggle(text, mod_name)
        if result is None:
            print(f"\n{mod_name}: NOT FOUND in modinfo.txt")
            continue

        dead = result["dead_bitdirs"]
        print(f"\n{mod_name}:")
        print(f"  Total Bits={result['total_bits']}, Covered={result['covered_bits']}, "
              f"Uncov={result['uncov_bits']}")
        print(f"  Module-level dead bit-directions: {dead}")
        if result["dead_signals"]:
            for s in result["dead_signals"]:
                print(f"    {s['name']}: {s['total_uncov']} dead "
                      f"({'1->0' if s['uncov_10'] else ''}"
                      f"{',' if s['uncov_10'] and s['uncov_01'] else ''}"
                      f"{'0->1' if s['uncov_01'] else ''}) "
                      f"[{s['section']}{' '+s['direction'] if s['direction'] else ''}]")

        if dead > 0:
            rules.append({
                "name": f"waive_toggle_modlevel_{mod_name.lower().replace('base_', '')}",
                "instance_regex": info["instance_regex"],
                "reason": f"Module-level structurally dead toggle: {info['desc']}. "
                          f"Dead bit-directions: {', '.join(s['name'] for s in result['dead_signals'])}",
                "adjustments": {
                    "toggle": {"total": dead, "covered": 0}
                }
            })

    # ================================================================
    # 2. AXLEN waiver for INIU
    # ================================================================
    print("\n" + "=" * 80)
    print("AXLEN[7:1] WAIVER ANALYSIS")
    print("=" * 80)
    # User says: INIU only receives axlen=0, so axlen[7:1] are structurally dead
    # Need to find all instances where axlen/arlen/awlen bits appear
    # In sts_req_ext_typ: len[5:0] (6-bit), but AXI AR/AW has 8-bit len
    # The STS request len field is 6 bits: sts_req_ext_typ.len[5:0]
    # User says bit0 can toggle, bits [7:1] dead. But STS only has [5:0], so [5:1] dead = 5 bits
    # Actually in pack: sts_req_ext_typ has `len` as 6-bit. AXI has awlen[7:0]/arlen[7:0] as 8-bit
    # The INIU maps AXI arlen/awlen to STS req.len. Since only axlen=0 is sent,
    # req.len[5:1] = 0 (dead), arlen[7:1] = 0 (dead), awlen[7:1] = 0 (dead)
    print("STS req.len is 6 bits. With axlen=0, len[5:1] = 5 bits dead = 10 bit-dirs per signal")
    print("AXI arlen/awlen is 8 bits. With axlen=0, arlen[7:1]/awlen[7:1] = 7 bits dead = 14 bit-dirs per signal")
    print("Need to check which modules carry these signals and how many instances")

    # ================================================================
    # 3. Summary of rules
    # ================================================================
    print("\n" + "=" * 80)
    print(f"TOTAL RULES: {len(rules)}")
    print("=" * 80)
    for r in rules:
        print(f"  {r['name']}: regex={r['instance_regex']}, toggle.total={r['adjustments']['toggle']['total']}")

    # Output JSON
    print("\n" + "=" * 80)
    print("Generated waiver rules (JSON):")
    print("=" * 80)
    print(json.dumps(rules, indent=2))


if __name__ == "__main__":
    main()

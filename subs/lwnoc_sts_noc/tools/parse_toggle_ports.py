#!/usr/bin/env python3
"""Parse toggle port details from URG HTML reports for cmn_vrp_reg_fifo instances."""

import re
import json
from pathlib import Path
from collections import defaultdict

URG_DIR = Path("/home/lgzhu/dev/noc_work/lwnoc_sts_noc/log/urg_nouvm")

# Instance mapping: (mod_file, inst_tag) -> full_path
INSTANCES = {
    # u_req_fifo instances (6)
    ("mod18_5.html", "inst_tag_189"): "top_nouvm.u_dut.u_tniu0.u_sts_tniu_noc.u_sts_tniu_apb_noc.u_req_fifo",
    ("mod18_6.html", "inst_tag_190"): "top_nouvm.u_dut.u_tniu0.u_sts_tniu_sys.u_sts_tniu_apb_sys.u_req_fifo",
    ("mod18_7.html", "inst_tag_191"): "top_nouvm.u_dut.u_tniu1.u_sts_tniu_noc.u_sts_tniu_apb_noc.u_req_fifo",
    ("mod18_8.html", "inst_tag_192"): "top_nouvm.u_dut.u_tniu1.u_sts_tniu_sys.u_sts_tniu_apb_sys.u_req_fifo",
    ("mod18_9.html", "inst_tag_193"): "top_nouvm.u_dut.u_tniu2.u_sts_tniu_noc.u_sts_tniu_apb_noc.u_req_fifo",
    ("mod18_10.html", "inst_tag_194"): "top_nouvm.u_dut.u_tniu2.u_sts_tniu_sys.u_sts_tniu_apb_sys.u_req_fifo",
    # u_ar_fifo instance (1)
    ("mod18_2.html", "inst_tag_186"): "top_nouvm.u_dut.u_iniu.u_sts_iniu_sys.u_sts_axi_iniu_sys_side.u_iniu_rd_chnl.u_ar_fifo",
}


def parse_port_summary(html, inst_tag):
    """Extract Port Bits summary (total, covered, percent) from the toggle section."""
    # Find the toggle section
    toggle_anchor = f'<a name="{inst_tag}_Toggle">'
    idx = html.find(toggle_anchor)
    if idx == -1:
        return None
    
    section = html[idx:idx+3000]
    
    summary = {}
    for label in ["Ports", "Port Bits", "Port Bits 0->1", "Port Bits 1->0"]:
        pattern = re.compile(
            rf'<td>{re.escape(label)}</td>\s*'
            rf'<td class="rt">(\d+)</td>\s*'
            rf'<td class="rt">(\d+)</td>\s*'
            rf'<td class="rt">([\d.]+)\s*</td>',
            re.DOTALL
        )
        # search with nowrap variant too
        pattern2 = re.compile(
            rf'<td nowrap>{re.escape(label)}</td>\s*'
            rf'<td class="rt">(\d+)</td>\s*'
            rf'<td class="rt">(\d+)</td>\s*'
            rf'<td class="rt">([\d.]+)\s*</td>',
            re.DOTALL
        )
        m = pattern.search(section) or pattern2.search(section)
        if m:
            summary[label] = {
                "total": int(m.group(1)),
                "covered": int(m.group(2)),
                "percent": float(m.group(3)),
            }
    return summary


def parse_port_details(html, inst_tag):
    """Extract Port Details table: signal name, toggle, toggle 1->0, toggle 0->1, direction."""
    toggle_anchor = f'<a name="{inst_tag}_Toggle">'
    idx = html.find(toggle_anchor)
    if idx == -1:
        return []
    
    # Find the Port Details table
    port_details_idx = html.find("<b>Port Details</b>", idx)
    if port_details_idx == -1:
        return []
    
    # Find end of Port Details table (Signal Details or Branch section)
    signal_details_idx = html.find("<b>Signal Details</b>", port_details_idx)
    branch_idx = html.find(f'<a name="{inst_tag}_Branch">', port_details_idx)
    
    end_idx = len(html)
    if signal_details_idx != -1:
        end_idx = min(end_idx, signal_details_idx)
    if branch_idx != -1:
        end_idx = min(end_idx, branch_idx)
    
    table_html = html[port_details_idx:end_idx]
    
    # Parse rows: <td>name</td> <td class="sN cl">Yes/No</td> x3 <td>direction</td>
    row_pattern = re.compile(
        r'<td>([^<]+)</td>\s*'
        r'<td class="s\d+ cl">(Yes|No)</td>\s*'
        r'<td class="s\d+ cl">(Yes|No)</td>\s*'  # 1->0
        r'<td class="s\d+ cl">(Yes|No)</td>\s*'  # 0->1
        r'<td>(INPUT|OUTPUT)</td>',
        re.DOTALL
    )
    
    ports = []
    for m in row_pattern.finditer(table_html):
        name = m.group(1).strip()
        toggle_all = m.group(2) == "Yes"
        toggle_1to0 = m.group(3) == "Yes"
        toggle_0to1 = m.group(4) == "Yes"
        direction = m.group(5)
        
        # Count bits from signal name
        bits = count_bits(name)
        
        ports.append({
            "name": name,
            "bits": bits,
            "toggle": toggle_all,
            "toggle_1to0": toggle_1to0,
            "toggle_0to1": toggle_0to1,
            "direction": direction,
        })
    
    return ports


def count_bits(name):
    """Count number of bits from signal name like 'foo[31:0]' -> 32, 'foo[3]' -> 1, 'foo' -> 1."""
    m = re.search(r'\[(\d+):(\d+)\]$', name)
    if m:
        return abs(int(m.group(1)) - int(m.group(2))) + 1
    m = re.search(r'\[(\d+)\]$', name)
    if m:
        return 1
    return 1


def compute_dead_bit_directions(ports):
    """Compute dead (uncovered) toggle bit-directions from port details.
    
    Returns list of (signal_name, direction_type, num_dead_bits) tuples
    where direction_type is '0->1' or '1->0'.
    """
    dead = []
    for p in ports:
        if not p["toggle_0to1"]:
            dead.append((p["name"], "0->1", p["bits"], p["direction"]))
        if not p["toggle_1to0"]:
            dead.append((p["name"], "1->0", p["bits"], p["direction"]))
    return dead


def main():
    results = {}
    
    for (mod_file, inst_tag), full_path in sorted(INSTANCES.items()):
        html_path = URG_DIR / mod_file
        html = html_path.read_text()
        
        summary = parse_port_summary(html, inst_tag)
        ports = parse_port_details(html, inst_tag)
        dead = compute_dead_bit_directions(ports)
        
        total_dead_bit_dirs = sum(d[2] for d in dead)
        
        results[full_path] = {
            "mod_file": mod_file,
            "inst_tag": inst_tag,
            "summary": summary,
            "ports": ports,
            "dead_bit_directions": dead,
            "total_dead_bit_directions": total_dead_bit_dirs,
        }
    
    # ──────────────────────────────────────────
    # Print per-instance results
    # ──────────────────────────────────────────
    req_fifo_paths = [p for p in results if "u_req_fifo" in p]
    ar_fifo_paths = [p for p in results if "u_ar_fifo" in p]
    
    print("=" * 100)
    print("u_req_fifo INSTANCES (6 total)")
    print("=" * 100)
    
    for path in sorted(req_fifo_paths):
        r = results[path]
        s = r["summary"]
        print(f"\n--- {path} ---")
        print(f"  Port Bits: {s['Port Bits']['total']} total, {s['Port Bits']['covered']} covered, {s['Port Bits']['percent']:.2f}%")
        print(f"  Port Bits 0->1: {s['Port Bits 0->1']['total']} total, {s['Port Bits 0->1']['covered']} covered, {s['Port Bits 0->1']['percent']:.2f}%")
        print(f"  Port Bits 1->0: {s['Port Bits 1->0']['total']} total, {s['Port Bits 1->0']['covered']} covered, {s['Port Bits 1->0']['percent']:.2f}%")
        print(f"  Dead bit-directions: {r['total_dead_bit_directions']}")
        for d in r["dead_bit_directions"]:
            print(f"    {d[0]:40s} {d[1]:5s} ({d[2]} bits) [{d[3]}]")
    
    # ──────────────────────────────────────────
    # Compute INTERSECTION of dead port toggle bits across all 6 req_fifo
    # ──────────────────────────────────────────
    print("\n" + "=" * 100)
    print("INTERSECTION: Dead port toggle bits across ALL 6 u_req_fifo instances")
    print("=" * 100)
    
    # Build set of (signal_name, transition_dir) for each instance
    dead_sets = []
    for path in sorted(req_fifo_paths):
        r = results[path]
        dead_set = set()
        for d in r["dead_bit_directions"]:
            dead_set.add((d[0], d[1]))  # (signal_name, direction)
        dead_sets.append(dead_set)
    
    # Intersection
    common_dead = dead_sets[0]
    for ds in dead_sets[1:]:
        common_dead = common_dead & ds
    
    # Count bits
    # Build a bit-count map from any instance (all same module)
    bit_map = {}
    for p in results[sorted(req_fifo_paths)[0]]["ports"]:
        bit_map[p["name"]] = p["bits"]
    
    total_common_dead_bits = 0
    common_dead_list = sorted(common_dead, key=lambda x: (x[0], x[1]))
    for sig, direction in common_dead_list:
        bits = bit_map.get(sig, 1)
        total_common_dead_bits += bits
        print(f"  {sig:40s} {direction:5s} ({bits} bits)")
    
    print(f"\n  TOTAL common dead toggle_port bit-directions: {total_common_dead_bits}")
    
    # ──────────────────────────────────────────
    # ar_fifo results
    # ──────────────────────────────────────────
    print("\n" + "=" * 100)
    print("u_ar_fifo INSTANCE")
    print("=" * 100)
    
    for path in sorted(ar_fifo_paths):
        r = results[path]
        s = r["summary"]
        print(f"\n--- {path} ---")
        print(f"  Port Bits: {s['Port Bits']['total']} total, {s['Port Bits']['covered']} covered, {s['Port Bits']['percent']:.2f}%")
        print(f"  Port Bits 0->1: {s['Port Bits 0->1']['total']} total, {s['Port Bits 0->1']['covered']} covered, {s['Port Bits 0->1']['percent']:.2f}%")
        print(f"  Port Bits 1->0: {s['Port Bits 1->0']['total']} total, {s['Port Bits 1->0']['covered']} covered, {s['Port Bits 1->0']['percent']:.2f}%")
        print(f"  Dead bit-directions: {r['total_dead_bit_directions']}")
        for d in r["dead_bit_directions"]:
            print(f"    {d[0]:40s} {d[1]:5s} ({d[2]} bits) [{d[3]}]")
    
    # ──────────────────────────────────────────
    # Summary for waiver creation
    # ──────────────────────────────────────────
    print("\n" + "=" * 100)
    print("WAIVER SUMMARY")
    print("=" * 100)
    
    # req_fifo: show per-signal group with bit counts
    print("\n--- req_fifo common dead (for module-level waiver) ---")
    # Group by signal name
    sig_dirs = defaultdict(list)
    for sig, direction in common_dead_list:
        sig_dirs[sig].append(direction)
    
    total_01 = 0
    total_10 = 0
    for sig in sorted(sig_dirs.keys()):
        bits = bit_map.get(sig, 1)
        dirs = sig_dirs[sig]
        for d in sorted(dirs):
            if d == "0->1":
                total_01 += bits
            else:
                total_10 += bits
        print(f"  {sig:40s} bits={bits:3d}  dead_dirs={dirs}")
    
    print(f"\n  Total dead 0->1 bit-directions: {total_01}")
    print(f"  Total dead 1->0 bit-directions: {total_10}")
    print(f"  Total dead toggle_port bit-directions: {total_01 + total_10}")
    
    # ar_fifo
    ar_path = sorted(ar_fifo_paths)[0]
    ar_r = results[ar_path]
    ar_dead = ar_r["dead_bit_directions"]
    ar_total_01 = sum(d[2] for d in ar_dead if d[1] == "0->1")
    ar_total_10 = sum(d[2] for d in ar_dead if d[1] == "1->0")
    
    print(f"\n--- ar_fifo dead ---")
    for d in ar_dead:
        print(f"  {d[0]:40s} {d[1]:5s} ({d[2]} bits) [{d[3]}]")
    print(f"\n  Total dead 0->1 bit-directions: {ar_total_01}")
    print(f"  Total dead 1->0 bit-directions: {ar_total_10}")
    print(f"  Total dead toggle_port bit-directions: {ar_total_01 + ar_total_10}")
    
    # ──────────────────────────────────────────
    # Also print which per-instance dead are NOT in the common set (for reference)
    # ──────────────────────────────────────────
    print("\n" + "=" * 100)
    print("PER-INSTANCE EXTRA DEAD (not in common intersection)")
    print("=" * 100)
    
    for path in sorted(req_fifo_paths):
        r = results[path]
        instance_dead = set((d[0], d[1]) for d in r["dead_bit_directions"])
        extra = instance_dead - common_dead
        if extra:
            print(f"\n  {path}:")
            for sig, direction in sorted(extra):
                bits = bit_map.get(sig, 1)
                print(f"    {sig:40s} {direction:5s} ({bits} bits)")
        else:
            print(f"\n  {path}: (none)")


if __name__ == "__main__":
    main()

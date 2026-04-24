#!/usr/bin/env python3
"""Parse VCS URG modinfo.txt to extract condition and toggle coverage gaps."""

import re
import sys
from collections import defaultdict

INFILE = "/home/lgzhu/dev/noc_work/lwnoc_sts_noc/new_tb/log/urg/cov_text_waived/modinfo.txt"

def main():
    with open(INFILE, 'r') as f:
        lines = f.readlines()
    
    total_lines = len(lines)
    print(f"Total lines in file: {total_lines}")
    
    # ── Phase 1: Find all module/instance section boundaries ──
    sections = []
    i = 0
    while i < total_lines:
        line = lines[i].rstrip()
        # Module instance section
        m = re.match(r'^Module Instance\s*:\s*(.+)', line)
        if m:
            inst_path = m.group(1).strip()
            sections.append(('instance', inst_path, i))
            i += 1
            continue
        # Base module section
        m = re.match(r'^Module\s*:\s*(Base_\S+)', line)
        if m:
            mod_name = m.group(1).strip()
            sections.append(('base_module', mod_name, i))
            i += 1
            continue
        i += 1
    
    print(f"Found {len(sections)} sections")
    
    # ── Phase 2: Parse Condition Coverage sections ──
    # Look for "Cond Coverage for Module" or "Cond Coverage for Instance"
    cond_sections = []
    i = 0
    while i < total_lines:
        line = lines[i].rstrip()
        m = re.match(r'^Cond Coverage for (Module|Instance)\s*:\s*(.+)', line)
        if m:
            scope_type = m.group(1)
            scope_name = m.group(2).strip()
            cond_sections.append((scope_type, scope_name, i))
        i += 1
    
    print(f"Found {len(cond_sections)} Condition Coverage sections")
    
    # Parse each condition section
    cond_data = {}  # scope_name -> {total, covered, uncovered_exprs: [...]}
    
    for scope_type, scope_name, start_line in cond_sections:
        # Read the summary line (Conditions   total covered percent)
        total_conds = 0
        covered_conds = 0
        j = start_line + 1
        while j < min(start_line + 10, total_lines):
            m = re.match(r'\s*Conditions\s+(\d+)\s+(\d+)\s+[\d.]+', lines[j])
            if m:
                total_conds = int(m.group(1))
                covered_conds = int(m.group(2))
                break
            j += 1
        
        # Now parse individual expressions until we hit the next section
        uncovered_exprs = []
        j = start_line + 1
        # Find end of this cond section (next ---- or === or another Coverage section)
        end_j = start_line + 5000  # reasonable limit
        
        current_line_no = None
        current_expr = None
        current_table = []
        
        while j < min(end_j, total_lines):
            raw = lines[j].rstrip()
            
            # Stop at next section
            if re.match(r'^-{40,}', raw) or re.match(r'^={40,}', raw):
                # Flush current expression
                if current_expr and current_table:
                    for row in current_table:
                        if 'Not Covered' in row:
                            uncovered_exprs.append({
                                'line': current_line_no,
                                'expr': current_expr,
                                'row': row.strip()
                            })
                break
            
            # Expression LINE marker
            m = re.match(r'\s*LINE\s+(\d+)', raw)
            if m:
                # Flush previous
                if current_expr and current_table:
                    for row in current_table:
                        if 'Not Covered' in row:
                            uncovered_exprs.append({
                                'line': current_line_no,
                                'expr': current_expr,
                                'row': row.strip()
                            })
                current_line_no = m.group(1)
                current_expr = None
                current_table = []
                j += 1
                continue
            
            # EXPRESSION line
            m = re.match(r'\s*EXPRESSION\s+(.+)', raw)
            if m:
                current_expr = m.group(1).strip()
                current_table = []
                j += 1
                continue
            
            # Table rows with Status (Covered/Not Covered)
            if 'Covered' in raw or 'Not Covered' in raw:
                # This is a status row
                current_table.append(raw)
            
            j += 1
        
        # Flush last
        if current_expr and current_table:
            for row in current_table:
                if 'Not Covered' in row:
                    uncovered_exprs.append({
                        'line': current_line_no,
                        'expr': current_expr,
                        'row': row.strip()
                    })
        
        cond_data[scope_name] = {
            'type': scope_type,
            'total': total_conds,
            'covered': covered_conds,
            'uncovered': total_conds - covered_conds,
            'uncovered_exprs': uncovered_exprs
        }
    
    # ── Phase 3: Parse Toggle Coverage sections ──
    toggle_sections = []
    i = 0
    while i < total_lines:
        line = lines[i].rstrip()
        m = re.match(r'^Toggle Coverage for (Module|Instance)\s*:\s*(.+)', line)
        if m:
            scope_type = m.group(1)
            scope_name = m.group(2).strip()
            toggle_sections.append((scope_type, scope_name, i))
        i += 1
    
    print(f"Found {len(toggle_sections)} Toggle Coverage sections")
    
    # Parse toggle sections
    toggle_data = {}
    
    for scope_type, scope_name, start_line in toggle_sections:
        total_bits = 0
        covered_bits = 0
        j = start_line + 1
        while j < min(start_line + 15, total_lines):
            m = re.match(r'\s*Total Bits\s+(\d+)\s+(\d+)\s+[\d.]+', lines[j])
            if m:
                total_bits = int(m.group(1))
                covered_bits = int(m.group(2))
                break
            j += 1
        
        # Parse uncovered signals (toggle = No)
        uncovered_ports = []
        uncovered_signals = []
        in_port_details = False
        in_signal_details = False
        
        j = start_line + 1
        end_j = min(start_line + 5000, total_lines)
        
        while j < end_j:
            raw = lines[j].rstrip()
            
            if re.match(r'^-{40,}', raw) or re.match(r'^={40,}', raw):
                break
            
            if 'Port Details' in raw:
                in_port_details = True
                in_signal_details = False
                j += 1
                continue
            if 'Signal Details' in raw:
                in_signal_details = True
                in_port_details = False
                j += 1
                continue
            
            if in_port_details or in_signal_details:
                # Format: signal_name   Toggle Toggle1->0 Toggle0->1 [Direction]
                # Look for "No" entries
                parts = raw.split()
                if len(parts) >= 4 and parts[0] not in ('Toggle', 'Port', 'Signal', '', 'Totals', 'Total', 'Ports', 'Signals'):
                    sig_name = parts[0]
                    has_no = 'No' in parts[1:4]
                    if has_no:
                        toggle_info = ' '.join(parts[1:])
                        if in_port_details:
                            uncovered_ports.append((sig_name, toggle_info))
                        else:
                            uncovered_signals.append((sig_name, toggle_info))
            
            j += 1
        
        toggle_data[scope_name] = {
            'type': scope_type,
            'total_bits': total_bits,
            'covered_bits': covered_bits,
            'uncovered_bits': total_bits - covered_bits,
            'uncovered_ports': uncovered_ports,
            'uncovered_signals': uncovered_signals,
            'pct': (covered_bits / total_bits * 100) if total_bits > 0 else 0
        }
    
    # ── Phase 4: Filter to Instance sections (top_newtb hierarchy, skip (X)) ──
    # For conditions - use Instance-level data 
    print("\n" + "="*80)
    print("CONDITION COVERAGE ANALYSIS")
    print("="*80)
    
    # Separate base vs instance
    inst_cond = {k: v for k, v in cond_data.items() if v['type'] == 'Instance'}
    base_cond = {k: v for k, v in cond_data.items() if v['type'] == 'Module'}
    
    print(f"\nBase module condition sections: {len(base_cond)}")
    print(f"Instance condition sections: {len(inst_cond)}")
    
    # Use base module data for aggregate (avoids double counting)
    total_cond_points = 0
    total_cond_covered = 0
    
    for name, d in base_cond.items():
        total_cond_points += d['total']
        total_cond_covered += d['covered']
    
    print(f"\n--- Aggregate from Base Modules ---")
    print(f"Total condition points: {total_cond_points}")
    print(f"Covered condition points: {total_cond_covered}")
    print(f"Uncovered condition points: {total_cond_points - total_cond_covered}")
    if total_cond_points > 0:
        print(f"Condition coverage: {total_cond_covered/total_cond_points*100:.2f}%")
    
    # Top 5 modules with most uncovered condition points (base)
    sorted_cond = sorted(base_cond.items(), key=lambda x: x[1]['uncovered'], reverse=True)
    print(f"\n--- TOP 5 Modules with Most Uncovered CONDITION Points ---")
    for rank, (name, d) in enumerate(sorted_cond[:5], 1):
        print(f"\n#{rank}: {name}")
        print(f"  Total: {d['total']}, Covered: {d['covered']}, Uncovered: {d['uncovered']}")
        if d['uncovered_exprs']:
            print(f"  Uncovered expressions ({len(d['uncovered_exprs'])} rows):")
            for expr in d['uncovered_exprs']:
                print(f"    Line {expr['line']}: {expr['expr']}")
                print(f"      → {expr['row']}")
    
    # Also show instance-level data
    sorted_inst_cond = sorted(inst_cond.items(), key=lambda x: x[1]['uncovered'], reverse=True)
    print(f"\n--- TOP 5 Instances with Most Uncovered CONDITION Points ---")
    for rank, (name, d) in enumerate(sorted_inst_cond[:5], 1):
        print(f"\n#{rank}: {name}")
        print(f"  Total: {d['total']}, Covered: {d['covered']}, Uncovered: {d['uncovered']}")
        if d['uncovered_exprs']:
            print(f"  Uncovered expressions ({len(d['uncovered_exprs'])} rows):")
            for expr in d['uncovered_exprs'][:20]:  # limit output
                print(f"    Line {expr['line']}: {expr['expr']}")
                print(f"      → {expr['row']}")
            if len(d['uncovered_exprs']) > 20:
                print(f"    ... and {len(d['uncovered_exprs'])-20} more")
    
    # ── Phase 5: Toggle coverage analysis ──
    print("\n" + "="*80)
    print("TOGGLE COVERAGE ANALYSIS")
    print("="*80)
    
    base_toggle = {k: v for k, v in toggle_data.items() if v['type'] == 'Module'}
    inst_toggle = {k: v for k, v in toggle_data.items() if v['type'] == 'Instance'}
    
    total_toggle_bits = 0
    total_toggle_covered = 0
    for name, d in base_toggle.items():
        total_toggle_bits += d['total_bits']
        total_toggle_covered += d['covered_bits']
    
    print(f"\n--- Aggregate from Base Modules ---")
    print(f"Total toggle bits: {total_toggle_bits}")
    print(f"Covered toggle bits: {total_toggle_covered}")
    print(f"Uncovered toggle bits: {total_toggle_bits - total_toggle_covered}")
    if total_toggle_bits > 0:
        print(f"Toggle coverage: {total_toggle_covered/total_toggle_bits*100:.2f}%")
    
    # Top 5 by uncovered bits (base modules)
    sorted_toggle = sorted(base_toggle.items(), key=lambda x: x[1]['uncovered_bits'], reverse=True)
    print(f"\n--- TOP 5 Modules with Most Uncovered TOGGLE Bits ---")
    for rank, (name, d) in enumerate(sorted_toggle[:5], 1):
        print(f"\n#{rank}: {name}")
        print(f"  Total bits: {d['total_bits']}, Covered: {d['covered_bits']}, Uncovered: {d['uncovered_bits']} ({d['pct']:.1f}%)")
        # Show uncovered ports
        if d['uncovered_ports']:
            print(f"  Uncovered ports ({len(d['uncovered_ports'])}):")
            for sig, info in d['uncovered_ports'][:15]:
                print(f"    {sig}: {info}")
            if len(d['uncovered_ports']) > 15:
                print(f"    ... and {len(d['uncovered_ports'])-15} more")
        if d['uncovered_signals']:
            print(f"  Uncovered signals ({len(d['uncovered_signals'])}):")
            for sig, info in d['uncovered_signals'][:15]:
                print(f"    {sig}: {info}")
            if len(d['uncovered_signals']) > 15:
                print(f"    ... and {len(d['uncovered_signals'])-15} more")
    
    # Top 5 instances
    sorted_inst_toggle = sorted(inst_toggle.items(), key=lambda x: x[1]['uncovered_bits'], reverse=True)
    print(f"\n--- TOP 5 Instances with Most Uncovered TOGGLE Bits ---")
    for rank, (name, d) in enumerate(sorted_inst_toggle[:5], 1):
        print(f"\n#{rank}: {name}")
        print(f"  Total bits: {d['total_bits']}, Covered: {d['covered_bits']}, Uncovered: {d['uncovered_bits']} ({d['pct']:.1f}%)")
        if d['uncovered_ports']:
            print(f"  Uncovered ports ({len(d['uncovered_ports'])}):")
            for sig, info in d['uncovered_ports'][:10]:
                print(f"    {sig}: {info}")
        if d['uncovered_signals']:
            print(f"  Uncovered signals ({len(d['uncovered_signals'])}):")
            for sig, info in d['uncovered_signals'][:10]:
                print(f"    {sig}: {info}")
    
    # ── Phase 6: u_channel_out_async and lwnoc_cti_channel search ──
    print("\n" + "="*80)
    print("SPECIFIC MODULE SEARCH: u_channel_out_async / lwnoc_cti_channel")
    print("="*80)
    
    for name, d in toggle_data.items():
        if 'channel_out_async' in name.lower() or 'cti_channel' in name.lower():
            print(f"\n  Found: {name}")
            print(f"    Type: {d['type']}")
            print(f"    Total bits: {d['total_bits']}, Covered: {d['covered_bits']}, Pct: {d['pct']:.1f}%")
            if d['uncovered_ports']:
                print(f"    Uncovered ports ({len(d['uncovered_ports'])}):")
                for sig, info in d['uncovered_ports']:
                    print(f"      {sig}: {info}")
            if d['uncovered_signals']:
                print(f"    Uncovered signals ({len(d['uncovered_signals'])}):")
                for sig, info in d['uncovered_signals']:
                    print(f"      {sig}: {info}")
    
    # Also search in cond data
    for name, d in cond_data.items():
        if 'channel_out_async' in name.lower() or 'cti_channel' in name.lower():
            print(f"\n  Found in cond data: {name}")
            print(f"    Total: {d['total']}, Covered: {d['covered']}, Uncovered: {d['uncovered']}")
            for expr in d['uncovered_exprs']:
                print(f"    Line {expr['line']}: {expr['expr']}")
                print(f"      → {expr['row']}")
    
    # ── Broader search in raw text for these modules ──
    print(f"\n--- Raw text search for channel_out_async / cti_channel ---")
    for idx, line in enumerate(lines):
        if 'channel_out_async' in line.lower() or 'lwnoc_cti_channel' in line.lower():
            print(f"  Line {idx+1}: {line.rstrip()[:120]}")
    
    # ── Phase 7: List ALL modules and their COND scores from header ──
    print("\n" + "="*80)
    print("ALL MODULES COND SCORES FROM HEADERS")
    print("="*80)
    
    # Search for COND column in score lines
    i = 0
    mod_cond_scores = []
    current_module = None
    while i < total_lines:
        raw = lines[i].rstrip()
        m = re.match(r'^Module\s*:\s*(Base_\S+)', raw)
        if m:
            current_module = m.group(1).strip()
        m2 = re.match(r'^Module Instance\s*:\s*(.+)', raw)
        if m2:
            current_module = m2.group(1).strip()
        
        # Score line: SCORE LINE COND TOGGLE FSM BRANCH
        # Values like: 71.13  93.33  50.00  66.17 --      75.00
        if current_module and re.match(r'^\s*[\d.]+\s+', raw):
            parts = raw.split()
            if len(parts) >= 6:
                try:
                    score = parts[0]
                    line_cov = parts[1]
                    cond_val = parts[2]
                    toggle_val = parts[3]
                    if cond_val != '--':
                        cond_pct = float(cond_val)
                        mod_cond_scores.append((current_module, cond_pct))
                except (ValueError, IndexError):
                    pass
        i += 1
    
    # Show modules with COND coverage
    unique_cond_mods = {}
    for name, pct in mod_cond_scores:
        if name.startswith('Base_'):
            if name not in unique_cond_mods or pct < unique_cond_mods[name]:
                unique_cond_mods[name] = pct
    
    sorted_mods = sorted(unique_cond_mods.items(), key=lambda x: x[1])
    print(f"\nModules with COND coverage (sorted by lowest):")
    for name, pct in sorted_mods:
        print(f"  {name}: COND={pct:.2f}%")

if __name__ == '__main__':
    main()

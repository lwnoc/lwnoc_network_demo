#!/usr/bin/env python3
"""
ATB Node IO Checker: Audits ATB node kinds against upstream RTL module declarations.

Compares node interface contracts defined in AtbNode.py and soc_atb_logic_topology.json
against module port declarations in /home/lgzhu/dev/noc_work/lwnoc_atb_noc/rtl/.

Classification:
  - direct-match: Node contract aligns 1:1 with a single upstream module
  - composed-match: Node contract aligns with multiple upstream modules (e.g., INIU = INIU_sys + INIU_noc)
  - reduced-contract: Node exposes fewer ports than the corresponding upstream module (protocol family loss)
  - unresolved: No clear upstream module mapping found

Usage:
  python3 atb_node_io_checker.py --topo <topology.json> --output <report.json>
"""

import json
import re
import argparse
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple, Optional
from collections import defaultdict


# ATB Protocol families
ATB_FAMILIES = {
    'forward': {'atvalid', 'atbytes', 'atdata', 'atid'},
    'reverse': {'atready', 'afvalid', 'afready', 'syncreq', 'atwakeup'},
    'lp': {'preq', 'pstate', 'pactive', 'paccept', 'pdeny'},
    'debug': {'apb', 'debug'},  # context-dependent
}

# Helper port families (reduced contract)
HELPER_FAMILIES = {
    'reduced': {'valid', 'ready', 'data'},
}


class ModuleDeclarationParser:
    """Parse SystemVerilog module declarations to extract port names and widths."""
    
    def __init__(self, rtl_root: Path):
        self.rtl_root = rtl_root
        self.module_ports: Dict[str, Dict] = {}  # module_name -> {port_name -> {width, direction}}
        self._parse_rtl()
    
    def _parse_rtl(self):
        """Parse all SystemVerilog files under rtl_root."""
        for sv_file in self.rtl_root.rglob('*.sv'):
            self._parse_file(sv_file)
    
    def _parse_file(self, filepath: Path):
        """Parse a single SystemVerilog file."""
        try:
            with open(filepath, 'r') as f:
                content = f.read()
        except Exception as e:
            print(f"Warning: Could not read {filepath}: {e}", file=sys.stderr)
            return
        
        # Extract module declarations: module name or module `_PREFIX_(...) 
        # The module header spans from 'module' keyword to the closing ')' with ';'
        
        # Pattern 1: module `_PREFIX_(name)
        prefix_pattern = r'module\s+`_PREFIX_\((\w+)\)'
        # Pattern 2: module name
        simple_pattern = r'module\s+(\w+)\s*(?:#|import|$)'
        
        # Find module declarations - need to handle prefix variants
        lines = content.split('\n')
        i = 0
        while i < len(lines):
            line = lines[i]
            
            # Check for module declaration with prefix
            prefix_match = re.search(prefix_pattern, line)
            if prefix_match:
                module_name = prefix_match.group(1)
                # Find the port list - should end with );
                port_section = self._extract_port_section(lines, i)
                if port_section:
                    ports = self._parse_ports(port_section)
                    if ports:
                        self.module_ports[module_name] = ports
                i += 1
                continue
            
            # Check for module declaration without prefix
            simple_match = re.match(r'module\s+(\w+)\s*(?:#|\(|;|import)', line)
            if simple_match:
                module_name = simple_match.group(1)
                # Find the port list
                port_section = self._extract_port_section(lines, i)
                if port_section:
                    ports = self._parse_ports(port_section)
                    if ports:
                        self.module_ports[module_name] = ports
                i += 1
                continue
            
            i += 1
    
    def _extract_port_section(self, lines: List[str], start_idx: int) -> str:
        """Extract the port section from a module declaration starting at line start_idx."""
        # Accumulate lines from start_idx until we find the closing )
        section = []
        paren_depth = 0
        in_port_section = False
        
        for i in range(start_idx, len(lines)):
            line = lines[i]
            
            # Skip to the opening (
            if not in_port_section:
                if '(' in line:
                    in_port_section = True
                    # Count parentheses
                    paren_depth = line.count('(') - line.count(')')
                    section.append(line)
                    if paren_depth == 0:
                        return '\n'.join(section)
                continue
            
            section.append(line)
            paren_depth += line.count('(') - line.count(')')
            
            if paren_depth == 0:
                return '\n'.join(section)
        
        return '\n'.join(section)
    
    def _parse_ports(self, port_section: str) -> Dict[str, Dict]:
        """Parse individual ports from a port section."""
        ports = {}
        
        # Regex to match port declarations
        port_pattern = r'(input|output|inout|logic)\s+(?:\[(\d+):0\]\s+)?(\w+)'
        
        for match in re.finditer(port_pattern, port_section):
            direction = 'input' if 'input' in match.group(1) else 'output' if 'output' in match.group(1) else 'inout'
            width_str = match.group(2)
            port_name = match.group(3)
            
            width = int(width_str) + 1 if width_str else 1
            
            ports[port_name] = {
                'direction': direction,
                'width': width
            }
        
        return ports
    
    def get_port_families(self, module_name: str) -> Dict[str, Set[str]]:
        """Classify ports of a module into ATB protocol families."""
        if module_name not in self.module_ports:
            return {}
        
        ports = self.module_ports[module_name]
        families = defaultdict(set)
        
        for port_name in ports.keys():
            # Normalize port name: remove direction prefixes (s_, m_) and suffixes
            normalized = re.sub(r'^(s_|m_)', '', port_name)
            normalized = re.sub(r'^(in|out)(\d+)?_', '', normalized)
            
            # Classify into families
            for family, keywords in ATB_FAMILIES.items():
                if any(keyword in normalized for keyword in keywords):
                    families[family].add(port_name)
            
            # Check for helper ports
            if any(kw in normalized for kw in HELPER_FAMILIES['reduced']):
                families['reduced'].add(port_name)
        
        return dict(families)
    
    def get_module(self, module_name: str) -> Optional[Dict]:
        """Return module ports or None if not found."""
        return self.module_ports.get(module_name)


class NodeContractParser:
    """Parse node interface contracts from soc_atb_logic_topology.json."""
    
    def __init__(self, topology_path: Path):
        self.topology_path = topology_path
        self.topology = {}
        self.node_kinds = {}  # node_kind -> {concrete_nodes: [...], interfaces: [...]}
        self._load_topology()
    
    def _load_topology(self):
        """Load topology JSON."""
        try:
            with open(self.topology_path, 'r') as f:
                self.topology = json.load(f)
        except Exception as e:
            print(f"Error loading topology: {e}", file=sys.stderr)
            return
        
        # Index nodes by kind and aggregate interface signatures
        nodes = self.topology.get('nodes', [])
        for node in nodes:
            kind = node.get('kind')
            interfaces_dict = node.get('interfaces', {})  # Dict with keys like 'sys_in', 'top_out'
            
            if kind not in self.node_kinds:
                self.node_kinds[kind] = {
                    'concrete_nodes': [],
                    'port_names': set()
                }
            
            self.node_kinds[kind]['concrete_nodes'].append(node.get('node_id', ''))
            
            # Extract all port names from all interface groups
            if isinstance(interfaces_dict, dict):
                for iface_group, port_list in interfaces_dict.items():
                    if isinstance(port_list, list):
                        for port_def in port_list:
                            if isinstance(port_def, dict) and 'name' in port_def:
                                self.node_kinds[kind]['port_names'].add(port_def['name'])
    
    def get_node_kinds(self) -> Set[str]:
        """Return all node kinds found in topology."""
        return set(self.node_kinds.keys())
    
    def get_node_port_names(self, node_kind: str) -> Set[str]:
        """Return all port names exposed by a node kind."""
        return self.node_kinds.get(node_kind, {}).get('port_names', set())


class ATBNodeIOChecker:
    """Main checker: compares node contracts against upstream RTL."""
    
    def __init__(self, topology_path: Path, rtl_root: Path):
        self.node_parser = NodeContractParser(topology_path)
        self.module_parser = ModuleDeclarationParser(rtl_root)
        self.report = {
            'timestamp': '',
            'classifications': {},  # node_kind -> {class, matched_modules, missing_families, evidence}
            'summary': {}
        }
    
    def check_all_nodes(self) -> Dict:
        """Run full audit on all node kinds."""
        node_kinds = self.node_parser.get_node_kinds()
        
        for kind in sorted(node_kinds):
            self._check_node_kind(kind)
        
        self._generate_summary()
        return self.report
    
    def _check_node_kind(self, node_kind: str):
        """Classify a single node kind using heuristics for port name analysis."""
        port_names = self.node_parser.get_node_port_names(node_kind)
        concrete_nodes = self.node_parser.node_kinds[node_kind]['concrete_nodes']
        
        # Classify based on node kind and port patterns
        if node_kind == 'atb_iniu':
            classification = self._classify_iniu(port_names)
            matched = ['atb_iniu_sys', 'atb_iniu_noc']
            missing = []
        elif node_kind == 'atb_tniu':
            classification = self._classify_tniu(port_names)
            matched = ['atb_tniu_sys', 'atb_tniu_noc']
            missing = []
        else:
            classification, matched, missing = self._classify_node(node_kind, port_names)
        
        self.report['classifications'][node_kind] = {
            'classification': classification,
            'matched_modules': matched,
            'missing_families': missing,
            'concrete_nodes': concrete_nodes,
            'node_port_count': len(port_names),
            'exposed_ports': sorted(port_names)
        }
    
    def _classify_iniu(self, port_names: Set[str]) -> str:
        """Check if INIU node exposes full ATB protocol families."""
        # Look for indication of full ATB families
        has_atvalid = any('atvalid' in p for p in port_names)
        has_atready = any('atready' in p for p in port_names)
        has_atbytes = any('atbytes' in p for p in port_names)
        has_atdata = any('atdata' in p for p in port_names)
        has_atid = any('atid' in p for p in port_names)
        has_afvalid = any('afvalid' in p for p in port_names)
        has_afready = any('afready' in p for p in port_names)
        
        # Check for LP control ports
        has_lp = any(p in port_names for p in ['preq', 'pstate', 'pactive', 'paccept', 'pdeny'])
        
        all_atb = has_atvalid and has_atready and has_atbytes and has_atdata and has_atid and has_afvalid and has_afready
        
        if all_atb and has_lp:
            return 'composed-match'
        elif all_atb:
            return 'reduced-contract'
        else:
            return 'unresolved'
    
    def _classify_tniu(self, port_names: Set[str]) -> str:
        """Check if TNIU node exposes full ATB protocol families."""
        # Same logic as INIU
        has_atvalid = any('atvalid' in p for p in port_names)
        has_atready = any('atready' in p for p in port_names)
        has_atbytes = any('atbytes' in p for p in port_names)
        has_atdata = any('atdata' in p for p in port_names)
        has_atid = any('atid' in p for p in port_names)
        has_afvalid = any('afvalid' in p for p in port_names)
        has_afready = any('afready' in p for p in port_names)
        
        has_lp = any(p in port_names for p in ['preq', 'pstate', 'pactive', 'paccept', 'pdeny'])
        
        all_atb = has_atvalid and has_atready and has_atbytes and has_atdata and has_atid and has_afvalid and has_afready
        
        if all_atb and has_lp:
            return 'composed-match'
        elif all_atb:
            return 'reduced-contract'
        else:
            return 'unresolved'
    
    def _classify_node(
        self, node_kind: str, port_names: Set[str]
    ) -> Tuple[str, List[str], List[str]]:
        """
        Classify node against upstream modules.
        Checks if node exposes ATB protocol families present in upstream modules.
        
        Returns: (classification, matched_modules, missing_families)
        """
        
        # Map node kind to expected upstream module names
        module_candidates = self._get_module_candidates(node_kind)
        
        if not module_candidates:
            return ('unresolved', [], [])
        
        all_matched_modules = []
        all_missing_families = []
        
        for module_name in module_candidates:
            upstream_module = self.module_parser.get_module(module_name)
            if not upstream_module:
                # Module not in parsed RTL, try heuristic classification
                continue
            
            all_matched_modules.append(module_name)
            
            # Check for family coverage
            missing = self._check_family_coverage(port_names, upstream_module)
            all_missing_families.extend(missing)
        
        if not all_matched_modules:
            # Fallback: check if node exposes reduced-contract ports (valid/data only)
            has_valid = any('valid' in p for p in port_names)
            has_data = any('data' in p for p in port_names)
            
            if has_valid and has_data and len(port_names) < 20:
                # Likely a reduced-contract helper
                return ('reduced-contract', module_candidates, ['forward', 'reverse', 'lp'])
            
            return ('unresolved', [], [])
        
        # Classify based on matching and coverage
        missing_families = list(set(all_missing_families))
        
        if len(all_matched_modules) > 1:
            classification = 'composed-match'
        elif missing_families:
            classification = 'reduced-contract'
        else:
            classification = 'direct-match'
        
        return (classification, all_matched_modules, missing_families)
    
    def _get_module_candidates(self, node_kind: str) -> List[str]:
        """Map node kind to likely upstream module names."""
        mappings = {
            'atb_iniu': ['atb_iniu_sys', 'atb_iniu_noc'],
            'atb_tniu': ['atb_tniu_sys', 'atb_tniu_noc'],
            'atb_async_bridge_slv': ['atb_async_bridge_top'],
            'atb_async_bridge_mst': ['atb_async_bridge_top'],
            'atb_funnel': ['atb_funnel'],
            'atb_funnel3': ['atb_funnel'],
            'atb_funnel6': ['atb_funnel'],
        }
        
        candidates = mappings.get(node_kind, [])
        
        # Also try generic match
        if not candidates:
            candidates = [node_kind, node_kind.replace('atb_', '')]
        
        return candidates
    
    def _check_family_coverage(self, node_ports: Set[str], upstream_module: Dict) -> List[str]:
        """
        Check if node exposes all ATB protocol families present in upstream module.
        
        Returns: list of missing families.
        """
        upstream_families = self._extract_families(upstream_module.keys())
        node_families = self._extract_families(node_ports)
        
        missing = set(upstream_families.keys()) - set(node_families.keys())
        
        # Filter out 'reduced' family as that's expected for helpers
        missing.discard('reduced')
        
        return sorted(missing)
    
    def _extract_families(self, port_names) -> Dict[str, Set[str]]:
        """Classify port names into ATB families."""
        families = defaultdict(set)
        
        for port in port_names:
            # Normalize
            normalized = re.sub(r'^(s_|m_)', '', port)
            normalized = re.sub(r'^(in|out)(\d+)?_', '', normalized)
            normalized_lower = normalized.lower()
            
            # Check ATB families
            for family, keywords in ATB_FAMILIES.items():
                if any(kw in normalized_lower for kw in keywords):
                    families[family].add(port)
            
            # Check helper families
            for family, keywords in HELPER_FAMILIES.items():
                if any(kw in normalized_lower for kw in keywords):
                    families[family].add(port)
        
        return dict(families)
    
    def _generate_summary(self):
        """Generate summary statistics."""
        classifications = self.report['classifications']
        
        summary = {
            'total_node_kinds': len(classifications),
            'direct_match': 0,
            'composed_match': 0,
            'reduced_contract': 0,
            'unresolved': 0,
        }
        
        for node_kind, info in classifications.items():
            cls = info['classification']
            summary[cls.replace('-', '_')] += 1
        
        self.report['summary'] = summary


def main():
    parser = argparse.ArgumentParser(
        description='Audit ATB node kinds against upstream RTL module declarations'
    )
    parser.add_argument(
        '--topo', required=True,
        help='Path to soc_atb_logic_topology.json'
    )
    parser.add_argument(
        '--rtl-root', 
        default='/home/lgzhu/dev/noc_work/lwnoc_atb_noc/rtl',
        help='Path to RTL root directory (default: /home/lgzhu/dev/noc_work/lwnoc_atb_noc/rtl)'
    )
    parser.add_argument(
        '--output', required=True,
        help='Output JSON report path'
    )
    args = parser.parse_args()
    
    topo_path = Path(args.topo)
    rtl_root = Path(args.rtl_root)
    output_path = Path(args.output)
    
    if not topo_path.exists():
        print(f"Error: Topology file not found: {topo_path}", file=sys.stderr)
        sys.exit(1)
    
    if not rtl_root.exists():
        print(f"Error: RTL root not found: {rtl_root}", file=sys.stderr)
        sys.exit(1)
    
    print(f"Checking ATB nodes against RTL...", file=sys.stderr)
    print(f"  Topology: {topo_path}", file=sys.stderr)
    print(f"  RTL root: {rtl_root}", file=sys.stderr)
    print(f"  Output: {output_path}", file=sys.stderr)
    
    checker = ATBNodeIOChecker(topo_path, rtl_root)
    report = checker.check_all_nodes()
    
    # Write report
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w') as f:
        json.dump(report, f, indent=2)
    
    # Print summary
    print("\nAudit Summary:", file=sys.stderr)
    for key, count in report['summary'].items():
        if count > 0:
            print(f"  {key}: {count}", file=sys.stderr)
    
    print(f"\nReport saved to: {output_path}", file=sys.stderr)
    
    # Print detailed classification
    print("\nNode Classifications:", file=sys.stderr)
    for node_kind in sorted(report['classifications'].keys()):
        info = report['classifications'][node_kind]
        print(f"  {node_kind}: {info['classification']}", file=sys.stderr)
        if info['matched_modules']:
            print(f"    -> {', '.join(info['matched_modules'])}", file=sys.stderr)
        if info['missing_families']:
            print(f"    Missing: {', '.join(info['missing_families'])}", file=sys.stderr)


if __name__ == '__main__':
    main()

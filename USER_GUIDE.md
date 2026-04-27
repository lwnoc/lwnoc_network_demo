# NoC Generation User Guide

## Overview

This workspace contains 4 NoC (Network-on-Chip) topology generation demos, each following the **four-file rule** and the **three-layer release pattern** pioneered by the memnoc reference at `aichip_memnoc_aichip_dev/`.

Each demo generates RTL wrappers, filelists, and harden partitions from topology descriptions written in Python. The generation pipeline is:

```
Topology description (Topo.py)
  → UHDL graph construction (Node.py + Template.py params)
  → ip_builder RTL prefix + filelist expansion (temp_build)
  → Verilog generation (build_uhdl + generate_verilog)
  → Filelist generation (generate_filelist)
  → Harden partition + aggregation (ring_top_wrap pattern)
```

---

## 1. Demo Overview

| Demo | Submodule IP | Protocol | Standalone Repo | Entrypoint Script |
|------|-------------|----------|-----------------|-------------------|
| **INTR** | `lwnoc_interrupt_noc` | Interrupt ring | `/home/lgzhu/dev/noc_work/lwnoc_interrupt_noc` | `gen_soc_intr_topo.py` |
| **STS** | `lwnoc_sts_noc` | APB/CTI trace | `/home/lgzhu/dev/noc_work/lwnoc_sts_noc` | `gen_sts_soc_topo.py` |
| **ATB** | `lwnoc_atb_noc` | ATB trace | `/home/lgzhu/dev/noc_work/lwnoc_atb_noc` | `gen_soc_atb_topo.py` |
| **DTI** | `lwnoc_dti_noc` | DTI (AXI stream) | `/home/lgzhu/dev/noc_work/lwnoc_dti_noc` | `gen_dti_topo.py` |

### Four-File Structure

Each demo consists of exactly these 4 Python files:

| File | Purpose | What it contains |
|------|---------|-----------------|
| `*Node.py` | Node class definitions | `UhdlComponentNode` / `UhdlWrapperNode` subclasses, `TemplateComponent` instantiation, `add_interface()` port mapping |
| `*Template.py` | IP configuration | `TemplateIPConfig` instances, filelist paths, env var setup, `param_overrides` (ALL design-size constants) |
| `*Topo.py` | Topology class | `UhdlWrapperNode` subclass, node instances, `connect()` wiring, clock domains, harden leaf lists |
| `gen_*_topo.py` | Generation driver | Build → generate_verilog → generate_filelist → harden partition → ring_top_wrap aggregation |

### Filelist Resolution Strategy

Each demo's Template.py defines where RTL source is loaded from:

- **INTR/STS/DTI**: Check `EXTERNAL_*_ROOT` (standalone repo path) first, fallback to `subs/` directory
- **ATB**: Uses `ATB_SUBIP_ROOT` env var (defaults to `/home/lgzhu/dev/noc_work/lwnoc_atb_noc`)

All `_pub.f` filelists are stored in the **standalone repo's `vc/` directory**, not in the demo directory.

---

## 2. Environment Setup

### Prerequisites

```bash
# Set up lwnoc_topo (UHDL framework)
export PYTHONPATH=/path/to/lwnoc_topo:$PYTHONPATH

# Each demo needs its submodule paths working. Verify with:
cd lwnoc_sts_noc_demo && python3 -c "from StsTemplate import *; print('OK')"
cd soc_atb_noc      && python3 -c "from AtbTemplate import *; print('OK')"
```

### How Generation Works (pipeline)

1. **TemplateIPConfig** — describes one IP instance (name, prefix, filelist, params)
2. **TemplateComponent** — wraps TemplateIP with VComponent (pyslang parser) to create a UHDL component tree
3. **UhdlComponentNode** — single IP node (e.g. one INIU sys-side)
4. **UhdlWrapperNode** — composite node that assembles multiple sub-nodes and interfaces
5. **TopologySerializer** — saves the node graph as JSON for debugging
6. **`.build()`** — recursively calls `build_uhdl()` on all wrapper nodes, producing `Component` trees
7. **`.generate_verilog()`** — emits `.v` files from Component trees
8. **`.generate_filelist()`** — emits `filelist.f` with `-f` references to sub-IPs

---

## 3. How to Modify

### 3.1 Understanding the Inputs

Each demo's inputs are:

| Input | Location | Description |
|-------|----------|-------------|
| RTL source | Standalone repo `rtl/` | SystemVerilog modules for INIU, TNIU, decoders, switches |
| Filelists | Standalone repo `vc/*.f` | Compile order and file groups for each IP component |
| `_pub.f` filelists | Standalone repo `vc/*_pub.f` | Self-contained publish filelists (no FCIP/LP dependencies) |
| LP packages | Standalone repo `lwnoc_lowpower_component/` | Low-power protocol type definitions |
| Node classes | Demo dir `*Node.py` | UHDL node definitions mapping RTL modules to UHDL |
| Templates | Demo dir `*Template.py` | IP configuration (params, env vars, filelist paths) |
| Topology | Demo dir `*Topo.py` | Node instances and wiring |
| Gen script | Demo dir `gen_*_topo.py` | Build pipeline and output layout |

### 3.2 Modifying RTL

If you change RTL port names or add/remove ports:

1. Edit the `.sv` file in the **standalone repo** (e.g. `/home/lgzhu/dev/noc_work/lwnoc_sts_noc/rtl/tniu/sts_tniu_top.sv`)
2. Update the corresponding node's `add_interface()` regex in `*Node.py`
3. Regen: `cd demo_dir && python3 gen_*_topo.py`

**Key rules**:
- **Top-level modules** (directly instantiated by `TemplateComponent`): struct-typed ports MUST be converted to explicit bit width (e.g. `[118:0]`) with internal cast signals — this avoids pyslang nested-struct alias resolution bugs
- **Internal modules** (instantiated within top-level modules): can keep struct-typed ports
- After modifying RTL ports to vector, remove `struct_mode="packed"` from the corresponding `TemplateComponent(...)` call in `*Node.py`

### 3.3 Changing Node Configuration

Per-IP parameters are defined in `*Template.py` as `TemplateIPConfig` objects:

```python
# Example: STS sys-side config
vpu_ss_tniu_sys_config = TemplateIPConfig(
    name="vpu_ss_tniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="VPU_SS_TNIU_SYS_OUT_DIR",
)
# Add parameter overrides
vpu_ss_tniu_sys_config.param_overrides = {
    "DBG_TIMESTAMP_WIDTH": 64,
    "DBG_DATA_WIDTH": 32,
}
```

To change parameters:
- **Design-size constants** (WIDTH, DEPTH, NUM): edit `param_overrides` in `*Template.py`
- **Filelist paths**: edit the `filelist=` parameter or update the referenced `.f` file
- **Prefix/env_var**: change these in the `TemplateIPConfig` constructor call

### 3.4 Adding or Removing Nodes

To add a new node instance (e.g. a new TNIU for a new subsystem):

1. **If new node type** (new RTL module): add node class in `*Node.py` with `add_interface()` calls
2. **If new instance** (existing RTL, new config): add new `TemplateIPConfig` in `*Template.py`
3. **Wire into topology**: add `setattr(self, "new_node_name", NewNodeClass(...))` and `connect(...)` calls in `*Topo.py`
4. **Add to harden**: update `harden_dn_leaf_names` / `harden_up_leaf_names` in the Topo class
5. **Update gen script**: if the gen script references nodes explicitly, add the reference

### 3.5 Changing the Topology Structure

The topology (how nodes are connected) is defined in `*Topo.py`:

```python
class StsSocLogicTopo(UhdlWrapperNode):
    def __init__(self):
        super().__init__(id=SOC_STS_NOC_TOP_ID)
        # Interface declarations
        self.add_interface("clk_sys", is_global=True)
        # Node instances
        self.aon_ss_iniu = StsIniuNode(...)
        self.dec0 = StsDecNode(...)
        # Connections
        connect(self.aon_ss_iniu.req, self.dec0.mst_req)
```

To modify the topology:
- Change `connect()` calls to rewire nodes
- Add/remove nodes with `setattr(self, "name", node)` 
- Clock domains: use `is_global=True` for fanout clocks

### 3.6 Changing Output File Format and Layout

The gen script (`gen_*_topo.py`) controls output layout:

```python
# Output directory
BUILD_DIR = THIS_DIR / "build_logic"

# Main topology output
comp.generate_verilog(iteration=True)
comp.generate_filelist(abs_path=False, prefix="$SOC_PREFIX")

# Harden partition output → top_wrap_dir (flat aggregation, memnoc pattern)
top_wrap_dir = str(BUILD_DIR / "sts_soc_top_wrap")
hc.output_dir = top_wrap_dir  # ← all harden .v goes to top_wrap dir
hc.generate_verilog(iteration=True)
hc.generate_filelist(abs_path=False, prefix="$SOC_PREFIX")

# Final aggregation wrapper
rtw_comp = ring_top_wrap.build_uhdl()
rtw_comp.output_dir = top_wrap_dir
rtw_comp.generate_verilog(iteration=True)
```

To change output layout:
- **Change output root**: modify `BUILD_DIR`
- **Flat vs layered**: harden `.v` files → `top_wrap_dir` (flat); IP template `.v` files → `BUILD_DIR/<ip_name>/` (layered)
- **Filelist prefix**: change the `prefix=` argument to `generate_filelist()`
- **Filelist format**: `abs_path=False` for relative paths, `True` for absolute

### 3.7 Adding/Removing Topology Structure (Harden Partition)

Harden partitions divide the NoC into clock-domain-separated groups:

```python
# In gen_*_topo.py:
dn_harden = UhdlWrapperNode("soc_sts_dn_harden")
dn_harden.add_interface("clk_harden_dn_func", is_global=True)
for name in sorted(logic_wrapper.harden_dn_leaf_names):
    setattr(dn_harden, f"{name}_top", node.top_side)
    connect(sub.clk_dst, dn_harden.clk_harden_dn_func)
```

The `harden_dn_leaf_names` / `harden_up_leaf_names` defined in `*Topo.py` control which nodes go to which partition.

To restructure:
- Change the leaf name sets in `*Topo.py`
- Hardens use `.top_side` property of wrapper nodes (defined in `*Node.py`)
- The aggregation wrapper nests hardens via `u_dn_harden` / `u_up_harden`

---

## 4. Four-Demo Specific Patterns

### 4.1 INTR (`lwnoc_intr_noc_demo/soc_intr_noc/`)

- **Purpose**: Interrupt ring network (INIUs collect interrupts → ring → TNIUs deliver to CPUs)
- **Special files**: `filelist/` with LP package wrappers, `tools/intr_gen_preflight.py` (pre-flight checks), `tools/intr_gen_publish.py` (publish helpers)
- **Node types**: `SocIntrIniuSysNode`, `SocIntrIniuTopNode`, `SocIntrIniuNode` (wrapper + .top_side), ring station/buf/sp, xbar LUT
- **Harden**: `soc_intr_ring_noc_dn_harden_wrap`, `soc_intr_ring_noc_up_harden_wrap`
- **Ring topology**: ring stations + ring buf nodes form a circular bus

### 4.2 STS (`lwnoc_sts_noc_demo/`)

- **Purpose**: SoC debug/trace network (APB masters collecting trace data)
- **Special**: TNIU sys/top split + properly separated INIU wrapper
- **Node types**: `StsIniuSysNode`, `StsIniuTopNode`, `StsIniuNode` (wrapper), `StsDecNode` (n-ary), `StsTniuWrapNode` (wrap)
- **Decoder**: n-ary route-based decoder (`SLAVE_NUM` parameter)
- **No LP package** needed (no low-power ports in this protocol)

### 4.3 ATB (`soc_atb_noc/`)

- **Purpose**: ATB trace funnel network (DSP trace data via funnel→async bridge)
- **Special features**: Funnel + Aggregator nodes, async bridge for clock domain crossing
- **Node types**: `AtbIniuSysNode/TopNode/Node`, `AtbTniuSysNode/TopNode/Node`, `AtbFunnelNode`, `AtbAsyncBridgeNode`
- **Filelists**: `filelist/atb_async_bridge.f`, `filelist/atb_funnel.f` (local), `_pub.f` in standalone repo `vc/`
- **LP packages**: Required by RTL but provided via self-contained `_pub.f` filelists

### 4.4 DTI (`soc_dti_noc_demo/`)

- **Purpose**: DTI data transport network (AXI stream-like data movers)
- **Special features**: Switch-based (4x) topology with async bridge
- **Node types**: `DtiIniuSysWrapNode`/`TopWrapNode`/`Node`, `DtiTniuSysWrapNode`/`TopWrapNode`/`Node`, `DtiSwitchNode` (3i1o, 4i1o, 5i1o, 6i1o), `DtiReqRspAsyncBridgeNode`
- **LP packages**: Required, provided via `_pub.f` in standalone repo `vc/`

---

## 5. Common Tasks Reference

### 5.1 Quick Regen All Four Demos

```bash
cd /home/lgzhu/dev/noc_work/lwnoc_network_demo

# INTR
cd lwnoc_intr_noc_demo/soc_intr_noc
rm -rf build/temp build_logic build
python3 gen_soc_intr_topo.py

# STS
cd ../../lwnoc_sts_noc_demo
rm -rf build/temp build_logic build
python3 gen_sts_soc_topo.py

# ATB
cd ../soc_atb_noc
rm -rf build/temp build_logic build
python3 gen_soc_atb_topo.py

# DTI
cd ../soc_dti_noc_demo
rm -rf build/temp build_logic build
python3 gen_dti_topo.py
```

### 5.2 Adding a New SS Instance (all demos)

1. `*Template.py`: Add `TemplateIPConfig(name="new_ss_iniu_sys", ...)`
2. `*Node.py`: Add `setattr(self, "new_ss_iniu", ...)` (if using existing node class, just instance it)
3. `*Topo.py`: Instance + connect + add to harden leaf list
4. `gen_*_topo.py`: Nothing (automatic via `harden_dn_leaf_names`)

### 5.3 Changing Output Filelist Prefix

Edit the `prefix=` argument in `*_topo.py`:
```python
comp.generate_filelist(abs_path=False, prefix="$NEW_PREFIX")
```

### 5.4 Adding a New Harden Partition

1. `*Topo.py`: Add new `harden_new_leaf_names` tuple
2. `gen_*_topo.py`: Add new `UhdlWrapperNode("new_harden")` block + expose/build/generate
3. `gen_*_topo.py`: Nest in `ring_top_wrap` via `setattr(ring_top_wrap, "u_new_harden", new_harden)`

---

## 6. Troubleshooting

### 6.1 `[-1:0]` in Generated Verilog

**Root cause**: pyslang cannot resolve `bitWidth` for nested struct typedef aliases. Fix: convert struct ports to explicit bit vector in top-level RTL modules, add internal cast signals.

See `lwnoc_sts_noc/rtl/tniu/sts_tniu_top.sv` for example of the cast pattern.

### 6.2 `ErrAttrMismatch` during Build

**Cause**: `struct_mode="packed"` inconsistency between connected nodes. One node's IO is `UInt(N,0)` (packed), the other's is `StructIO` (unpacked).

**Fix**: Ensure all connected nodes either all use `struct_mode="packed"` or none do. If top-level RTL ports are already vector (no struct types), remove `struct_mode` from the `TemplateComponent(...)` call in `*Node.py`.

### 6.3 `_pub.f` File Not Found

**Fix**: Ensure the standalone repo (not the demo directory) has the `_pub.f` files in `vc/`. The demo's Template.py reads from the standalone repo path:
```python
# Check which path your demo uses:
grep "EXTERNAL.*ROOT\|DEFAULT.*ROOT" *Template.py
```

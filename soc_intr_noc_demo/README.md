# SoC INTR NoC Demo

This demo models a SoC-scale interrupt ring NoC source flow based on the attached topology sketch.

Scope:
- New demo root: `soc_intr_noc_demo/`
- Source-layer generation only: topology Python, TemplateIP configs, node wrappers, filelists, and demo-local helper RTL
- Reuses the same interrupt NoC IP and ring-network collateral as `lwnoc_intr_noc_demo`

Intentional modeling simplifications relative to the picture:
- Subsystems that show both `INIU` and `TNIU` are represented as two adjacent ring nodes, for example `cpu_ss_iniu` + `cpu_ss_tniu`
- `ASYNC`, `SP`, and `S2M Bridge` markers are treated as placement/integration hints, not as separate top-level NIU endpoints in this first source-layer demo
- The ring order follows the picture's perimeter traversal so the named endpoint sequence remains human-auditable

Primary entrypoint:
- `python gen_soc_intr_topo.py`

Primary outputs after generation:
- `soc_intr_logic_topology.json`
- `build_logic/`
- `filelist/filelist.f`
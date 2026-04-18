# SoC DTI NoC Demo

This demo models the DTI transport portion of the attached SoC sketch as a merge tree rooted at `sys_tcu`.

Scope:
- Demo root: `soc_dti_noc_demo/`
- Source-layer generation: topology Python, TemplateIP configs, generated RTL/filelists, and sim scaffolding
- Reuses the same DTI IP and network collateral as `lwnoc_dti_noc_demo`

Image-derived INIU/TID plan:
- `dsp_ss0` .. `dsp_ss5` -> TIDs `0..5`
- `vpu_ss` -> `6`
- `pcie_rtg_ss` -> `7`
- `ufs_ss` -> `8`
- `camera_ss` -> `9`
- `mipi_ss` -> `10`
- `gpu_ss0` -> `11`
- `gpu_ss1` -> `12`
- `dp_ss` -> `13`
- `display_ss` -> `14`

Topology shape:
- `dsp_ss0..5` merge through a left DSP subtree
- `vpu/pcie_rtg/ufs/camera` merge through a right IO subtree
- `mipi/gpu_ss0/gpu_ss1/dp/display` merge through a display-side subtree
- The two major branches merge at `soc_dti_sw_root` and terminate at `sys_tcu`

## Python Dependency Structure

**Generator entrypoint:** `gen_soc_dti_topo.py`

**Required SOC-specific files (do NOT omit):**
- `SocDtiTreeTopo.py` — SOC-level topology definition
- `SocDtiNode.py` — SOC node factories (INIU/TNIU generators)
- `SocDtiTemplate.py` — SOC node template configs

**Inherited base files (from same directory):**
- `DtiTreeNode.py` — base switch node definitions
- `DtiTreeTopo.py` — base topology utilities

**Note:** The directory contains TWO parallel generator sets:
- Base DTI: `gen_dti_topo.py`, `DtiNode.py`, `DtiTemplate.py`, `DtiTreeTopo.py` 
- SOC DTI: `gen_soc_dti_topo.py`, `SocDtiNode.py`, `SocDtiTemplate.py`, `SocDtiTreeTopo.py`

Use `gen_soc_dti_topo.py` (not `gen_dti_topo.py`) for this SOC demo.

Primary entrypoint:
- `/home/lgzhu/dev/noc_work/lwnoc_network_demo/.venv/bin/python gen_soc_dti_topo.py`

Primary outputs after generation:
- `soc_dti_logic_topology.json`
- `build_logic/`
- `filelists/filelist.f`

# SoC ATB NoC Demo

This directory provides a standalone ATB network generation flow that does not modify anything under lwnoc_topo.

## Topology summary (from diagram)

- Left branch: six DSP SS initiators -> left funnel.
- Bottom branch: camera_ss and mipi_ss initiators -> camera funnel.
- Merge path: left funnel -> async bridge slave/master pair -> right funnel; camera funnel -> right funnel.
- Sink: debug SS TNIU endpoint receives the merged 128-bit ATB stream.

## Current implementation status

- The active topology no longer instantiates ATB buffer or ATB upsizer nodes; buffering and CDC belong inside the INIU sys-side implementation.
- Async bridge placeholders were replaced by real CDC stages (`atb_async_bridge_slv` and `atb_async_bridge_mst`) using async FIFO-based crossings in `rtl/atb_primitives.sv`.
- Generated RTL is now published in memnoc-like ATB ownership buckets under `build_logic/`:
	- one per-SS INIU sys-side directory for each source endpoint (`dsp_ss0_iniu_sys/` ... `dsp_ss5_iniu_sys/`, `camera_ss_iniu_sys/`, `mipi_ss_iniu_sys/`)
	- one per-SS TNIU sys-side directory for the sink endpoint (`debug_tniu_ss_tniu_sys/`)
	- one noc-top directory `build_logic/atb_soc_topo/` that owns topology assembly payload, including `atb_network_layer.v`, `atb_iniu_noc_side.sv`, `atb_tniu_noc_side.sv`, and the final `atb_soc_topo.v`
- Per-SS `*_sys_side.sv` wrappers are now anchored to real sub-IP modules from `lwnoc_atb_noc`:
	- INIU path: `NPU_atb_iniu_sys + NPU_atb_iniu_noc`
	- TNIU path: `NPU_atb_tniu_noc + NPU_atb_tniu_sys`
	- sub-IP dependency flatten list is published as `build_logic/atb_soc_topo/real_subip_expanded.f`
- The live compile entry now ingresses all per-SS sys-side filelists first, then the shared noc-top payload list.
- Internal funnel / async bridge nodes stay inside that generated top wrapper and are not published as standalone delivery folders.
- ATB now supports dual publish/ingress flows for async-harden split:
	- DV flow: `build_logic/` + `filelist/filelist.f`
	- PD flow: `build_logic_pd/` + `filelist_pd/filelist.f` (through `filelist_pd/filelist_harden.f`)
	- harden wrappers: `atb_soc_harden_dn_wrap.v`, `atb_soc_harden_up_wrap.v`

## Generate and compile

```bash
source setup_env.sh
/home/lgzhu/dev/noc_work/lwnoc_network_demo/.venv/bin/python gen_soc_atb_topo_dv.py
/home/lgzhu/dev/noc_work/lwnoc_network_demo/.venv/bin/python gen_soc_atb_topo_pd.py

# iverilog is useful for quick local checks but may fail on FCIP syntax in external deps.
# Use VCS as live closure frontend in this flow:
vcs -sverilog -full64 -LDFLAGS "-no-pie" -f filelist/filelist.f -top atb_soc_topo
vcs -sverilog -full64 -LDFLAGS "-no-pie" -f filelist_pd/filelist.f -top atb_soc_harden_up_wrap
```

Outputs:

- Topology JSON: `soc_atb_logic_topology.json`
- Per-SS INIU sys-side payloads: `build_logic/*_iniu_sys/*_iniu_sys_side.sv`
- Per-SS TNIU sys-side payloads: `build_logic/*_tniu_sys/*_tniu_sys_side.sv`
- Generated RTL top: `build_logic/atb_soc_topo/atb_soc_topo.v`
- Noc-top payloads: `build_logic/atb_soc_topo/atb_network_layer.v`, `build_logic/atb_soc_topo/atb_iniu_noc_side.sv`, `build_logic/atb_soc_topo/atb_tniu_noc_side.sv`
- Topology payload/common helper copy: `build_logic/atb_soc_topo/atb_primitives.sv`
- Localized expanded lists: `build_logic/*/expanded_filelist.f`
- Compile ingress filelist: `filelist/filelist.f`
- PD ingress filelists: `filelist_pd/filelist.f`, `filelist_pd/filelist_harden.f`

# lwnoc_network_demo
noc demo build by UHDL,will contain intr noc/sts noc/dti noc/atb noc demo

## Topology Capability Check

Use the shared checker to inspect each demo's live entrypoints, output roots, compile ingresses, topology artifacts, and harden-partition delivery.

```bash
python3 tools/check_topo_capability.py lwnoc_dti_noc_demo
python3 tools/check_topo_capability.py lwnoc_intr_noc_demo/soc_intr_noc
python3 tools/check_topo_capability.py soc_dti_noc_demo
```

Add `--json` for machine-readable output.

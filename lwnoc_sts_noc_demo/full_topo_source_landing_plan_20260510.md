# STS Demo Full-Topo Source Landing Plan

## Goal
- Land a source-owned full-topology STS demo update in the demo repo.
- Scope for this plan is source analysis and source-edit sequencing only.
- This plan does not claim generator closure or regenerated RTL closure.

## Authoritative Inputs
- Topology review source: `soc_sts_noc_topo`
- Full-topo parameter source: `lwnoc_sts_noc/doc/sts_latest_topo_gen_param_basis.md`
- Global consistency note: missing `SafetySS(Aon) / TNIU34` leaf must be restored at the root decoder

## Local Hypothesis
- The blocked full-topo landing is controlled by `StsTemplate.py` and `StsSocTopo.py`, not by `StsNode.py`.
- `StsNode.py` is already sufficient for the first landing pass because:
  - `StsDecNode` now accepts `slave_num` in `[1, 16]`
  - decoder wrapper selection is already parameterized by `top_wrap`
  - INIU/TNIU composite nodes already expose the required sys-side and noc-side interfaces

## Cheap Disconfirming Checks
- If any required decoder fanout exceeds 16, `StsNode.py` must be revisited before landing.
- If any required full-topo leaf needs a port family not already exposed by `StsIniuNode` or `StsTniuNode`, `StsNode.py` must be revised before landing.
- If full-topo source landing must preserve the current harden/async publish model, `gen_sts_soc_topo.py` becomes in-scope in the same session.

## Current Source Mismatch Snapshot
- `StsTemplate.py` still describes a toy/demo configuration set:
  - `TGT_ID_WIDTH` is still `8`, but full-topo basis requires `9`
  - decoder macros are still centered on one demo config (`STS_DEMO_DEC_SLAVE_NUM = 4`)
  - INIU address map is still a 48-entry demo table, but the AON INIU basis requires the frozen 191-entry table
  - only three TNIU config families exist (`vpu_ss`, `camera_ss`, `dspss`), while the full topology needs 38 TNIUs plus the AON-local TNIU leaf
- `StsSocTopo.py` still instantiates the demo tree:
  - one INIU
  - four dec nodes (`dec0`, `dec1`, `dec2`, `dec2_ext`)
  - eight TNIU leaves (`vpu_ss`, `camera_ss`, `dspss0..5`)
- `soc_sts_noc_topo` and the full-topo basis both show a much larger tree:
  - six named decoder levels
  - 38 TNIU leaves
  - one AON-local TNIU leaf at the root in addition to the single AON INIU source
- `gen_sts_soc_topo.py` is still tightly coupled to the current two-partition harden demo shape.

## Phase 1: Freeze Source-of-Truth Data in `StsTemplate.py`

### 1. Replace toy-wide constants with full-topo constants
- Set `STS_TGT_ID_WIDTH = 9`.
- Replace demo decoder assumptions (`STS_DEMO_DEC_SLAVE_NUM = 4`) with full-topo per-instance decoder configs.
- Replace the 48-entry demo INIU address map with the frozen 191-entry AON INIU map from the STS doc.

### 2. Split data into explicit full-topo domains
- Add one module-level decoder basis table for each real decoder instance:
  - `sts_dec_l0_root`
  - `sts_dec_l1_upper_ctrl`
  - `sts_dec_l2_left_ddr`
  - `sts_dec_l1_right_upper`
  - `sts_dec_l2_right_lower`
  - `sts_dec_l3_lower_mid`
- For each decoder config, populate:
  - exact `SLAVE_NUM`
  - exact `ROUTE_VLD_TABLE`
  - exact `ROUTE_DST_TABLE`
  - legacy `ROUTE_BASE` / `ROUTE_MASK` left at zero-compatible values
  - `top_wrap = "sts_noc_dec_node_1to<SLAVE_NUM>_wrap"`

### 3. Replace shared TNIU demo configs with full-topo per-instance data
- Introduce a single authoritative per-subsystem data table keyed by topology leaf name.
- Each entry must carry at least:
  - `tniu_id`
  - `func_base`
  - `debug_base`
  - `local_iniu_cti_tgt_id`
  - `local_regbank_tgt_id`
  - `local_cti_tgt_id`
  - `has_iniu_cti_apb`
  - `sys_reg_route_base`
  - `sys_apb_route_base`
- Use the full-topo basis table as the only numeric source.
- Add an explicit AON-local TNIU entry for `SafetySS(Aon)` / `TNIU34`.

### 4. Configuration declaration policy
- Decoder configs should be explicit module-level `TemplateIPConfig(...)` declarations because there are only six of them.
- TNIU sys-side and top-side configs may use a small repetitive helper because there are more than 10 structurally identical instances, but the exported result must still be module-level named config objects or a module-level mapping dict keyed by explicit subsystem names.
- Avoid name-derived heuristics; use explicit mapping tables.

### 5. INIU config policy
- Keep exactly one AON INIU config pair (`sys` and `top_side`).
- Reuse the frozen 191-entry address map rather than re-deriving a new one.
- Preserve the current note that only the AON INIU has `HAS_INIU_CTI_APB = 1`.

## Phase 2: Rewrite `StsSocTopo.py` to the Reviewed Full Tree

### 1. Replace demo decoder graph with the reviewed hierarchy
- Remove the `dec0/dec1/dec2/dec2_ext` toy graph.
- Instantiate the six reviewed dec nodes with their final names:
  - `sts_dec_l0_root`
  - `sts_dec_l1_upper_ctrl`
  - `sts_dec_l2_left_ddr`
  - `sts_dec_l1_right_upper`
  - `sts_dec_l2_right_lower`
  - `sts_dec_l3_lower_mid`

### 2. Replace the eight demo TNIU leaves with the full leaf set
- Instantiate one `StsTniuNode` per real subsystem leaf.
- Use topology-readable ids derived from the review doc, not demo placeholders.
- The root-level leaf set must include the restored `SafetySS(Aon)` local TNIU.

### 3. Rewire the full request/rsp/cti/dbg tree
- `aon_ss_iniu.top_req/top_rsp` remains the only source-side entry point.
- Root decoder fanout must match the reviewed tree and basis port map exactly.
- Child decoder chaining must match the six-node tree from the review doc.
- Every TNIU leaf must receive the same req/rsp/cti/dbg sideband family currently used by the demo nodes.

### 4. Clock/reset policy for this landing pass
- Keep the currently exposed sys-side/global clock families unless the user provides a different full-topo clock partition spec.
- Do not invent a new harden partition split from the current demo-only async bridge structure.
- If no full-topo harden partition source-of-truth exists, the landing target should be a logically correct full topology first.

## Phase 3: Resolve the Generator Coupling Decision

### Decision point
- `gen_sts_soc_topo.py` currently assumes:
  - two harden partitions (`dn` and `up`)
  - one async bridge crossing between them
  - `harden_dn_leaf_names` and `harden_up_leaf_names` attributes on the topology class
- The reviewed full-topo source document does not yet define a corresponding harden split.

### Recommended handling
- Treat generator adaptation as a separate source task after the logical full-topo topology is landed.
- Do not guess a harden partitioning in the same patch unless the user explicitly confirms the intended split.
- If the user wants the generator to stay immediately runnable, then `gen_sts_soc_topo.py` must be patched in the same session and the partitioning choice becomes an explicit user-facing design decision.

## Phase 4: Static Validation for the Source-Landing Patch
- Run `python3 -m py_compile StsTemplate.py StsSocTopo.py StsNode.py gen_sts_soc_topo.py`.
- Verify no stale toy decoder names remain in `StsSocTopo.py`:
  - `dec0`
  - `dec1`
  - `dec2`
  - `dec2_ext`
- Verify full-topo names do appear in source:
  - `sts_dec_l0_root`
  - `sts_dec_l3_lower_mid`
  - `SafetySS(Aon)` leaf mapping equivalent
- Verify `StsTemplate.py` no longer carries toy-width assumptions:
  - `TGT_ID_WIDTH = 8` must be gone
  - 48-entry demo INIU map constants must be gone or isolated as dead code removed
- Do not run generator output publication in this phase if the user still wants source-only landing.

## Expected Edit Set
- Mandatory:
  - `StsTemplate.py`
  - `StsSocTopo.py`
- Likely unchanged in the first pass:
  - `StsNode.py`
- Conditional follow-up:
  - `gen_sts_soc_topo.py`

## Primary Risks
- The largest unresolved source question is whether the full-topo demo should preserve the current harden/async bridge publish contract or abandon it for a pure logical tree.
- The current topology review text does not define a full-topo harden split, so generator closure is blocked until that policy is chosen.
- The AON-local TNIU leaf must not be forgotten; otherwise the source tree will remain inconsistent with the frozen global ID table.

## Recommended Execution Order
1. Refactor `StsTemplate.py` into full-topo data ownership.
2. Rewrite `StsSocTopo.py` to instantiate the six-decoder, 38-leaf tree.
3. Run static Python validation only.
4. Revisit `gen_sts_soc_topo.py` only after the harden partition policy is confirmed.

## Exit Criteria for This Planned Landing
- `StsTemplate.py` expresses the exact full-topo decoder and TNIU parameter basis.
- `StsSocTopo.py` expresses the exact reviewed logical tree, including `SafetySS(Aon) / TNIU34`.
- Static syntax/import validation passes.
- Generator/publish closure is explicitly deferred, not silently implied.
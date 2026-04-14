# Skill Improvement Report — Intr Common-Dep Evidence

Date: 2026-04-15
Scenario: The task was to re-evaluate an intr-demo sync retrospective after the user pointed out that `/home/lgzhu/dev/noc_work/aichip_memnoc/lwnoc_intr_noc_demo/build_logic/intr_iniu_sys` already contains no `fcip` or `lwnoc_lp` files. The environment involved two intr-demo checkouts, their generated `build_logic/` child trees, top-level `common_dep.f` publishers, and previously written retrospective artifacts.

## Context

### Work Scenario
The earlier retrospective correctly observed that source and target intr demos publish common dependencies differently at the top level, but it did not verify the generated child-output evidence before describing that mismatch. Direct inspection showed that the source repo's Type-A child outputs such as `build_logic/intr_iniu_sys/intr_iniu_sys_filelist.f` and `build_logic/intr_iniu_top/intr_iniu_top_filelist.f` exclude foundation IP, while the target repo separately publishes a demo-local copied common-dependency bundle via `filelist/intr_common_dep.f`. `fexpand` is still not installed in the current shell, so the analysis relied on direct file and directory inspection rather than flattening. `skill-creator/SKILL.md` is not present in the available external skill inventory, so overlap review proceeded without it.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to filelist evidence correction. |
| design-microarch | ❌ | Not the primary workflow; the issue is evidence layering, not RTL semantics. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | Broad RTL workflow context only; it explicitly defers filelist/relocation refactors to framework-specific skills. |
| dev-skill-index | ❌ | Not needed because the proposal refines an existing correctly discovered skill. |
| dev-skill-load-test | ❌ | Not needed for this retrospective. |
| eda-toolchain-debug | ❌ | No toolchain failure was central to this correction. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Relevant to filelist reasoning, but the CLI is not installed in the current shell. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ❌ | Not relevant. |
| lwnoc-topo | ✅ | Primary domain skill because the problem is about lwnoc demo filelist layers and generated build trees. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | Relevant because the user referred to generated RTL payload, but not sufficient for the evidence-layer workflow. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | Not central; no installation proposal is needed beyond noting `fexpand` is unavailable. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Broad RTL/filelist coordination context only; not the primary workflow for this correction. |

## Findings

### F1: Top-Level `common_dep.f` Was Conflated With Child Generated Payload
- **What happened**: The earlier retrospective described the source-versus-target difference as a `common_dep.f` translation issue without first checking the actual source Type-A child outputs. The user corrected this by pointing to source `build_logic/intr_iniu_sys/`, and inspection confirmed that both source `intr_iniu_sys_filelist.f` and source `intr_iniu_top_filelist.f` exclude `fcip/lwnoc_lp` payload.
- **Outcome**: ❌ Missed
- **Iterations**: 2
- **Impact**: Produced an over-broad retrospective claim and could steer future sync work toward the wrong artifact layer.
- **Category**: `quality-criteria`

### F2: Cross-Repo Sync Guidance Lacked An Explicit Foundation-IP Evidence Ladder
- **What happened**: The newly added `lwnoc-topo` cross-repo sync section told the agent to reconcile `common_dep.f` separately, but it did not explicitly require checking child filelists, child directory payload, and top-level common-dependency publisher as separate layers. That left room to repeat the same conflation even after the first skill fix.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 2
- **Impact**: Future agents could still make correct top-level observations but describe the wrong lower-level generated evidence.
- **Category**: `skill-gap`

## Proposals

### Proposal 1: Add Foundation-IP Evidence Ladder — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2
- **Problem class**: Cross-repo lwnoc demo comparisons where top-level common-dependency publication and per-block generated payload can diverge.
- **Change summary**: Extend the cross-repo sync guidance so agents must distinguish three evidence layers before summarizing a source/target common-dependency mismatch: child filelist, child directory payload, and top-level `common_dep.f` publisher.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: modify — Content sketch: add an explicit evidence ladder and examples showing that child outputs may stay clean even when top-level common dependencies are published in different ways.
- **Architecture notes**: This belongs inside `lwnoc-topo` because it refines an existing lwnoc-specific migration workflow rather than creating a new domain.
- **Estimated context cost**: +120 tokens in `SKILL.md`
- **Overlaps checked**: `lwnoc-topo` already partially covers Type-A/B/C filelist separation and one-time common RTL delivery, but its cross-repo sync section was too coarse; `design-workflow` explicitly delegates relocation/filelist refactors to the framework-specific skill; `fexpand` can flatten filelists but does not define evidence-layer policy and is not installed; `ip-design` is broader spec/RTL/testbench orchestration; `skill-creator/SKILL.md` is unavailable in the current external skill inventory.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add foundation-IP evidence ladder to `lwnoc-topo` | High | Low | P0 | ✅ Done |
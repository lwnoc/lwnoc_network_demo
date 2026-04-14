# Skill Improvement Report — Intr Single Build Unification

Date: 2026-04-14
Scenario: The task was to analyze the user's criticism that the interrupt NoC wrapper should compile from a single generated build tree instead of a mixed `build_logic` plus `build/temp` model. The environment involved the intr demo's published top-level filelist, `sim/Makefile`, mirrored generated sub-block trees under `build_logic/`, and the legacy `build/temp/` workspace.

## Context

### Work Scenario
The interrupt demo had been explained as a hybrid compile model: top-level files from `build_logic`, sub-block filelists from `build/temp`. The user then pointed out that all RTL required by the NoC wrapper should live in one build, which required determining whether the mirrored `build_logic/` sub-block trees were complete enough to collapse compile onto a single tree and, if so, fixing the compile consumer.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to interrupt build-tree unification. |
| design-microarch | ✅ | Relevant because the question asks where the generated RTL that structurally composes the interrupt NoC should come from. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | General RTL workflow context only; not sufficient for filelist-tree unification by itself. |
| dev-skill-index | ❌ | Not needed. |
| dev-skill-load-test | ❌ | Not relevant. |
| eda-toolchain-debug | ❌ | No toolchain failure was central here. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Relevant to hierarchical filelist reasoning, but the CLI is not installed in the current shell. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ❌ | Not relevant. |
| lwnoc-topo | ✅ | Primary skill: covers generated demo structure, published filelists, and output publication patterns. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | General RTL context only; not the primary path-unification skill. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | Not central; no tool availability result changed the fix. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Broad context only; not enough for interrupt filelist-tree unification. |

## Findings

### F1: The Hybrid Compile Model Was Left In Place After It Was Understood
- **What happened**: After identifying that the interrupt demo compiled from a hybrid mix of `build_logic` and `build/temp`, the workflow stopped at explanation instead of checking whether the mirrored `build_logic` sub-block trees were complete enough to retarget compile onto one tree. The Makefile still exported all `INTR_*_OUT_DIR` variables to `build/temp` even though matching directories existed under `build_logic`.
- **Outcome**: ❌ Missed
- **Iterations**: 4
- **Impact**: The user had to point out that wrapper-required RTL should be consolidated into one build, and the repo was left with avoidable compile-path split complexity.
- **Category**: `quality-criteria`

### F2: Shared Guidance Allowed Hybrid Models But Did Not Prefer Convergence When Possible
- **What happened**: The earlier skill fix correctly documented that hybrid compile models can exist, but it did not say that if `build_logic` already mirrors all needed sub-block filelists and RTL, the preferred end state is to collapse compile onto a single tree. That gap let the analysis stop one step short of the actual cleanup.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: The skill preserved descriptive accuracy about the current state but did not push toward the lower-complexity final state the user expected.
- **Category**: `skill-gap`

## Proposals

### Proposal 1: Retarget Intr Compile Exports To One Tree — Repo Fix
- **Type**: Modify Existing
- **Target**: `lwnoc_intr_noc_demo/sim/Makefile`
- **Addresses findings**: F1
- **Problem class**: Demo compile flows that already have a complete mirrored generated RTL tree but still consume legacy intermediate paths.
- **Change summary**: Point all interrupt demo `INTR_*_OUT_DIR` exports at `build_logic/` so both top-level and sub-block filelists resolve within one compile-facing tree.
- **Specific changes**:
  - File: `lwnoc_intr_noc_demo/sim/Makefile` — Section: exported `INTR_*_OUT_DIR` variables — Action: modify — Content sketch: replace `build/temp/...` with `build_logic/...` and leave the published top-level filelist unchanged.
- **Architecture notes**: This is a repo-local cleanup that reduces compile-path split without changing the logical design hierarchy.
- **Estimated context cost**: +0 tokens in skills, minor repo code churn only
- **Overlaps checked**: `lwnoc-topo` describes publication patterns but does not itself change repo behavior; `fexpand` is not installed and was unnecessary for this narrow retargeting.

### Proposal 2: Prefer Single Compile Tree When Mirrors Exist — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F2
- **Problem class**: lwnoc demos where agents discover a hybrid compile model but should decide whether it can be collapsed onto a single published generated tree.
- **Change summary**: Extend `lwnoc-topo` so agents treat hybrid compile models as transitional when `build_logic/` already mirrors the sub-block outputs, and instruct them to try a `sim/Makefile` retarget plus clean compile validation.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: prefer one compile-facing tree when both top filelist and lower-level sub-filelists can resolve under `build_logic`.
  - File: `SKILL.md` — Section: `Pitfall Reference` — Action: add — Content sketch: add a pitfall for stopping at hybrid-model explanation instead of checking for single-tree convergence.
- **Architecture notes**: This remains inside `lwnoc-topo` because it refines a topology-demo publication workflow that already belongs there.
- **Estimated context cost**: +110 tokens in `SKILL.md`
- **Overlaps checked**: `fexpand` covers filelist reasoning but not lwnoc-specific convergence policy and is not installed; `design-microarch` covers RTL structure, not publication end-state decisions; `skill-creator/SKILL.md` is unavailable in the current skill inventory.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Retarget intr compile exports to one tree | High | Low | P0 | ✅ Done |
| 2 | Prefer single compile tree when mirrors exist | High | Low | P0 | ✅ Done |

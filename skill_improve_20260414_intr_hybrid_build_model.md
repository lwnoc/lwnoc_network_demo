# Skill Improvement Report — Intr Hybrid Build Model

Date: 2026-04-14
Scenario: The task was to explain why the interrupt demo's top-level published filelist shows `build_logic` paths while the `INTR_INIU_TOP_OUT_DIR`-style environment variables in `sim/Makefile` still point into `build/temp`. The environment involved the intr demo's top-level filelist, Makefile exports, generator publish logic, and both generated trees under `build_logic/` and `build/temp/`.

## Context

### Work Scenario
The user questioned an apparent contradiction between the published top-level filelist and the Makefile environment variables. Answering it required following the actual filelist chain end to end: the top-level filelist had been selectively republished to `build_logic` for top-level ring/NOC files, but the preserved `-f` includes still resolved through Makefile variables into `build/temp` for sub-block RTL.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to filelist/build-path analysis. |
| design-microarch | ✅ | Relevant because the question is about which generated RTL structures actually compose the interrupt NoC. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | General RTL workflow context only; not sufficient for hybrid filelist-path reasoning. |
| dev-skill-index | ❌ | Not needed. |
| dev-skill-load-test | ❌ | Not relevant. |
| eda-toolchain-debug | ❌ | No toolchain failure was central here. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Directly relevant to hierarchical filelist reasoning, though the CLI is not installed in the current shell. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ❌ | Not relevant. |
| lwnoc-topo | ✅ | Primary skill: covers generated demo structure, published filelists, and topology output patterns. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | General RTL context only; not the main path-analysis skill. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | Not central; no tool check changed the answer. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Broad context only; not enough for this filelist-specific hybrid model. |

## Findings

### F1: `build_logic` Rule Was Over-Generalized Across Demos
- **What happened**: A prior improvement generalized that `build_logic` is the compile-facing generated RTL tree, which was accurate for the migrated DTI demo but incomplete for the interrupt demo. The intr demo actually compiles in a hybrid way: top-level published files from `build_logic`, sub-block filelists from `build/temp`.
- **Outcome**: ❌ Missed
- **Iterations**: 3
- **Impact**: Created a contradictory explanation and risked wrong guidance when users compare Makefile env vars against published top-level filelists.
- **Category**: `quality-criteria`

### F2: Hybrid Filelist Models Were Not Captured In The Shared Topology Skill
- **What happened**: The shared `lwnoc-topo` skill did not say that a published top-level filelist can selectively rewrite only top-level files while preserving env-var-driven sub-filelists. That forced manual archaeology through `filelist/filelist.f`, `sim/Makefile`, and generator publish code.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 4
- **Impact**: Repeat path-analysis work whenever a demo mixes republished top-level files with legacy generated sub-block outputs.
- **Category**: `skill-gap`

## Proposals

### Proposal 1: Add Hybrid Compile-Model Guidance — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2
- **Problem class**: Python-generated lwnoc demos whose top-level published filelists and lower-level env-var sub-filelists resolve to different generated trees.
- **Change summary**: Extend `lwnoc-topo` so agents explicitly check whether a demo uses a hybrid compile model before declaring either `build_logic` or `build/temp` the sole RTL source of truth.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: explain that some demos republish only top-level files to `build_logic` while leaving `-f $OUT_DIR/...` sub-filelists bound to `build/temp`.
  - File: `SKILL.md` — Section: `Pitfall Reference` — Action: add — Content sketch: add a pitfall for hybrid compile models where the correct answer is intentionally mixed rather than a single directory.
- **Architecture notes**: This belongs inside `lwnoc-topo` because it is a recurring topology-demo publication pattern, not a separate tool or domain.
- **Estimated context cost**: +140 tokens in `SKILL.md`
- **Overlaps checked**: `fexpand` helps reason about hierarchical filelists but is not installed in the current shell and does not define lwnoc-specific publication policy; `design-microarch` covers RTL structure, not hybrid compile path conventions; `ip-design` is too broad; `skill-creator/SKILL.md` is unavailable in the current skill inventory.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add hybrid compile-model guidance to `lwnoc-topo` | High | Low | P0 | ✅ Done |

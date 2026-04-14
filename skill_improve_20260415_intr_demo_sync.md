# Skill Improvement Report — Intr Demo Sync

Date: 2026-04-15
Scenario: The task was to analyze how an agent should port changes from `/home/lgzhu/dev/noc_work/aichip_memnoc/lwnoc_intr_noc_demo` into `/home/lgzhu/dev/noc_work/lwnoc_network_demo/lwnoc_intr_noc_demo`, explicitly including both filelists and RTL. The environment involved two intr-demo checkouts with different compile-facing filelist publication models, generated `build_logic/` trees, VCS Makefiles, and repo-local published filelists.

## Context

### Work Scenario
The source intr demo still compiles from `build_logic/intr_ring_noc_4i2t/filelist.f` plus `filelists/intr_common_dep.f`, while the target intr demo compiles from a published `filelist/filelist.f` plus `filelist/intr_common_dep.f` anchored by `INTR_NOC_DEMO_DIR`. That means this is not a path-for-path copy task: the agent must translate source changes into the target repo's compile contract. `fexpand` is not installed in the current shell, so filelist reasoning had to rely on direct file inspection instead of flattening. `skill-creator/SKILL.md` is not present in the available external skill inventory, so overlap review proceeded without it.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to repo-to-repo intr demo sync. |
| design-microarch | ❌ | Could help with RTL semantics, but not the primary filelist/publication-model workflow. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | Relevant as broad RTL workflow context, but it explicitly defers relocation/filelist refactors to framework-specific skills. |
| dev-skill-index | ❌ | Not needed because the proposal modifies an already-correctly-discovered skill. |
| dev-skill-load-test | ❌ | Not needed for this retrospective. |
| eda-toolchain-debug | ❌ | Toolchain behavior was not the primary blocker here. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Relevant to filelist reasoning, but the CLI is not installed in the current shell. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ❌ | Not relevant unless the sync flow became externally blocked. |
| lwnoc-topo | ✅ | Primary domain skill for lwnoc demos, build trees, and top-level filelist publication. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | Relevant because the user explicitly included RTL in the sync scope, but not sufficient for repo-sync workflow. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | Could formalize tool checks, but no installation fix was needed for the proposal. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Broad RTL/filelist synchronization context only; not the right primary workflow for this relocation task. |

## Findings

### F1: Source And Target Compile Contracts Had To Be Reconstructed Manually
- **What happened**: The request was to sync one intr demo checkout into another, including filelists and RTL, but the source and target compile entrypoints are published differently: source uses `build_logic/intr_ring_noc_4i2t/filelist.f`, while target uses `filelist/filelist.f`. Existing shared guidance described migration closure and published filelists, but it did not give a direct source-to-target sync checklist for this kind of mixed publication-model task.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Required separate inventory, Makefile, and filelist reads before the artifact boundary was safe to state; increases the chance of copying the wrong filelist layer.
- **Category**: `skill-gap`

### F2: `common_dep.f` Translation Rules Were Missing For Repo Sync
- **What happened**: The source demo's `filelists/intr_common_dep.f` points at external `$INTR_NOC_DIR/...` collateral, while the target demo's `filelist/intr_common_dep.f` publishes copied `$INTR_NOC_DEMO_DIR/build_logic/...` collateral. The existing skill already required one-time common RTL delivery, but it did not explicitly state that these two `common_dep.f` models must be translated rather than copied literally during a repo-to-repo sync.
- **Outcome**: ❌ Missed
- **Iterations**: unresolved
- **Impact**: High risk of producing a target filelist that bypasses the repo's published build tree or compiles against the wrong dependency model.
- **Category**: `quality-criteria`

## Proposals

### Proposal 1: Add Cross-Repo Demo Sync Checklist — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2
- **Problem class**: Syncing one lwnoc demo checkout into another when source and target use different compile-facing umbrella/common-dependency publication models.
- **Change summary**: Extend `lwnoc-topo` with an explicit source-versus-target compile-contract inventory step, artifact-layer sync rules, and a `common_dep.f` translation rule so agents preserve the target repo's compile model unless the user explicitly asks to change it.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: add a cross-repo demo sync checklist covering source/target compile contract inventory, artifact-layer sync, target-model preservation, and target-side clean compile closure.
- **Architecture notes**: This belongs inside `lwnoc-topo` because the gap is specific to lwnoc topology-demo publication and migration behavior, not broad enough for a standalone new skill.
- **Estimated context cost**: +180 tokens in `SKILL.md`
- **Overlaps checked**: `design-workflow` explicitly says relocation/filelist refactors should use a filelist/framework skill instead of the generic RTL workflow; `ip-design` is broader spec/RTL/testbench orchestration and is not the right primary workflow for repo-to-repo demo sync; `fexpand` can flatten filelists but the CLI is not installed and it does not define target publication-policy decisions; `rtl-coding-style` governs RTL style only; `skill-creator/SKILL.md` is unavailable in the current external skill inventory.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add cross-repo demo sync checklist to `lwnoc-topo` | High | Low | P0 | ✅ Done |
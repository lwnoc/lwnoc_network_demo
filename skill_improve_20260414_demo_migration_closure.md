# Skill Improvement Report — Demo Migration Closure

Date: 2026-04-14
Scenario: The task was to migrate the generated STS and DTI NoC demos into this repo, then prove that the moved demos still compile and that their compile-facing filelists are centralized under the demo roots. The environment used repo-local generated RTL under `build_logic/`, VCS 2016/Verdi 2016, a Python `.venv`, and a partially populated `lwnoc_topo/` checkout whose `uhdl/uhdl` tree is currently missing.

## Context

### Work Scenario
The migration itself completed, but closure was incomplete until a retrospective check was requested. `networkx` was installable and available, `fexpand` was not installed in the current shell, and generator rerun remained blocked by `ModuleNotFoundError: uhdl.uhdl` because `lwnoc_topo/uhdl/uhdl` is absent in this checkout. `skill-creator/SKILL.md` was not present in the available skill inventory, so overlap review proceeded without it.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to demo migration, compile closure, or filelist layout. |
| design-microarch | ✅ | Used earlier for RTL-oriented analysis, but not the main migration-closure skill. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | Used earlier for RTL workflow framing, but not sufficient for topology-demo relocation details. |
| dev-skill-index | ❌ | Not needed for this retrospective. |
| dev-skill-load-test | ❌ | Not needed for this retrospective. |
| eda-toolchain-debug | ✅ | Relevant for interpreting VCS behavior and residual toolchain warnings. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Relevant for filelist auditing, but the CLI is not installed in the current shell. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ✅ | Relevant only as a fallback if migration closure stayed blocked. |
| lwnoc-topo | ✅ | Primary skill for topology demos, generated filelists, and repo-local relocation patterns. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | Used earlier for RTL work, but not the migration-specific closure skill. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ✅ | Relevant for tool availability checks because `fexpand` and generator prerequisites had to be validated. |
| terminal-manager | ❌ | Not needed. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Helpful earlier in the session, but not sufficient for post-migration compile/filelist closure. |

## Findings

### F1: Migration Closed Before Clean Compile Proof
- **What happened**: The DTI and STS demos were copied, path-fixed, and syntax-checked, but the migration was treated as effectively done before a clean compile proof existed. The first compile evidence was only an incremental VCS path that reported `simv up to date`, which is not strong enough after repo relocation.
- **Outcome**: ❌ Missed
- **Iterations**: 2
- **Impact**: Extra user round-trip and risk that copied build artifacts masked a broken relocation.
- **Category**: `quality-criteria`

### F2: Compile-Facing Filelists Were Not Centralized Under Demo Roots
- **What happened**: Both demos still compiled from `build_logic/<top>/filelist.f`, while the demo-root `filelists/` directories only contained sub-block filelists. That left the compile entrypoint split between generated output and demo-local metadata.
- **Outcome**: ❌ Missed
- **Iterations**: 2
- **Impact**: Filelist ownership was unclear, manual inspection was slower, and relocation correctness depended on generated-path assumptions instead of a stable demo-root umbrella filelist.
- **Category**: `skill-gap`

### F3: Generator Health And Compile Health Were Not Separated Early
- **What happened**: Generator rerun was blocked by the incomplete `lwnoc_topo/uhdl` checkout, but there was no explicit migration-closure rule saying compile validation may proceed against the existing generated RTL once repo-local filelists and paths are repaired.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Time was spent diagnosing Python/generator prerequisites before the compile-closure path was reframed around existing `build_logic/` outputs.
- **Category**: `skill-gap`

## Proposals

### Proposal 1: Add Migration Closure Rules — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2, F3
- **Problem class**: Relocating or vendoring lwnoc topology demos into a new repo while preserving generated RTL usability.
- **Change summary**: Extend `lwnoc-topo` so migration tasks must finish with a demo-root umbrella filelist, compile consumer retargeting, and `make clean && make compile` proof rather than incremental VCS evidence.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: modify — Content sketch: add migration done criteria covering published top-level filelist, Makefile/wave consumer retargeting, and clean compile validation.
  - File: `SKILL.md` — Section: `Pitfall Reference` — Action: add — Content sketch: add a pitfall for migrations that only checked copied outputs or stale VCS state instead of clean compile closure.
- **Architecture notes**: This stays inside the existing topology-demo skill because the gap is workflow-specific, not broad enough to justify a new skill.
- **Estimated context cost**: +110 tokens in `SKILL.md`
- **Overlaps checked**: `fexpand` partially covers umbrella-filelist auditing but not migration closure policy; `sw-install-self-test` covers tool presence only; `eda-toolchain-debug` covers VCS/tool issues only; `issue-reporter` covers escalation, not normal closure.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add migration closure rules to `lwnoc-topo` | High | Low | P0 | ✅ Done |

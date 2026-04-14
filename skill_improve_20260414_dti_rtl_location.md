# Skill Improvement Report — DTI RTL Location Lookup

Date: 2026-04-14
Scenario: The task was to answer which directory in the migrated DTI demo actually contains the RTL that composes the demo NoC: `build_logic/` or `build/`. The environment involved the DTI generator script, demo-root umbrella filelist, `sim/Makefile`, generated per-block trees, and a scratch `build/temp/` tree created by the topology toolchain.

## Context

### Work Scenario
The user asked a concrete question about ownership of generated RTL while the editor was focused on the demo-root umbrella filelist. Answering it required correlating `gen_dti_topo.py`, `filelists/filelist.f`, `sim/Makefile`, and the on-disk shape of both `build_logic/` and `build/`, because both directories contain Verilog-like artifacts but only one is compile-facing.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to DTI RTL location lookup. |
| design-microarch | ✅ | Relevant because the question asks which generated RTL tree structurally composes the DTI NoC. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | General RTL workflow context only; not sufficient for this lookup by itself. |
| dev-skill-index | ❌ | Not needed; no new skill was created. |
| dev-skill-load-test | ❌ | Not relevant. |
| eda-toolchain-debug | ❌ | No toolchain failure was central to this question. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ❌ | Filelist-related but not needed for the answer; the CLI is also not installed in the current shell. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ❌ | Not relevant. |
| lwnoc-topo | ✅ | Primary skill: covers generated demo structure, filelists, and output publication patterns. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | General RTL context only; not the lookup workflow source. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | Not central; no tool-dependent blocker affected the answer. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Broadly related but too general for distinguishing published vs scratch generated trees. |

## Findings

### F1: No Explicit Rule For `build_logic/` vs `build/temp/`
- **What happened**: To answer which directory actually forms the DTI NoC RTL, the agent had to manually cross-check the generator output path, demo-root filelist, exported `*_OUT_DIR` variables, and on-disk directories because the shared topology skill did not explicitly define `build_logic/` as published compile-facing RTL and `build/` as intermediate workspace.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: A simple path question expanded into multi-file archaeology and risked a wrong answer because both trees contain generated `.sv` files.
- **Category**: `skill-gap`

### F2: Filelist-Based Evidence Was Not Elevated To A First-Class Lookup Recipe
- **What happened**: The strongest evidence came from the demo-root umbrella filelist and `sim/Makefile`, which both point into `build_logic/`, but the current skill did not present that as a standard lookup sequence for users asking where the "real RTL" lives.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Repeated manual reasoning is needed even though the answer is mechanically derivable from a small set of compile-facing files.
- **Category**: `quality-criteria`

## Proposals

### Proposal 1: Add Published-vs-Scratch Output Guidance — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2
- **Problem class**: Distinguishing compile-facing generated RTL from intermediate tool workspace in Python-generated lwnoc demos.
- **Change summary**: Extend `lwnoc-topo` with an explicit rule that `build_logic/` is the default published generated RTL tree, while `build/` or `build/temp/` are intermediate unless republished into the demo-root umbrella filelist or Makefile.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: explain `build_logic/` vs `build/` semantics and the quick verification sequence using `gen_<design>_topo.py`, umbrella filelist, and `sim/Makefile`.
  - File: `SKILL.md` — Section: `Pitfall Reference` — Action: add — Content sketch: add a pitfall for mistaking `build/temp/` artifacts as the real compile-consumed RTL tree.
- **Architecture notes**: This stays within `lwnoc-topo` because it is a core topology-demo workflow question, not a separate domain.
- **Estimated context cost**: +130 tokens in `SKILL.md`
- **Overlaps checked**: `design-microarch` helps interpret structure but not publish-vs-scratch directory policy; `ip-design` is too broad; `fexpand` is filelist-focused and not installed in the current shell; `skill-creator/SKILL.md` is unavailable in the current skill inventory.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add published-vs-scratch output guidance to `lwnoc-topo` | High | Low | P0 | ✅ Done |

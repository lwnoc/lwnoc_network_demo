# Skill Improvement Report — DTI Demo Top Lookup

Date: 2026-04-14
Scenario: The task was to answer two DTI demo hierarchy questions precisely: which module/file is the DUT top, and why the demo contains wrappers named `2i1o`, `3i1o`, and `4i1o`. The environment involved demo-local `sim/Makefile`, demo-root umbrella filelists, generated `build_logic/` RTL, and the Python topology sources that build the DTI tree.

## Context

### Work Scenario
The user asked for a concrete hierarchy explanation on the migrated DTI demo while the editor was open on `rtl/dti_switch_4i1o_wrap.sv`. Answering it required correlating four layers: simulation compile top, demo-root DUT filelist, generated DUT top RTL, and the topology/config Python that explains the `2i1o` / `3i1o` / `4i1o` naming.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to DTI hierarchy/top lookup. |
| design-microarch | ✅ | Relevant because the question asks for structural meaning of DTI switch wrappers and topology fan-in. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | Broad RTL workflow context only; not the primary source for demo top lookup. |
| dev-skill-index | ❌ | Not needed; no new skill creation or cross-ref audit was required. |
| dev-skill-load-test | ❌ | Not relevant. |
| eda-toolchain-debug | ✅ | Peripheral relevance only; compile-top discovery often starts from `sim/Makefile`, but no toolchain failure was involved. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Filelist-oriented skill with partial relevance, but its CLI is not installed in the current shell and the lookup did not require flattening. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Parameter/integration focus, not demo hierarchy identification. |
| issue-reporter | ❌ | Not relevant. |
| lwnoc-topo | ✅ | Primary skill: covers demo structure, filelists, generated tops, and topology scripts. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | General RTL context only; not sufficient for hierarchy lookup. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | No tool-dependent blocker was central to this question. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ✅ | Broadly related to design deliverables, but not specific enough for quick top-name archaeology. |

## Findings

### F1: No Fast Recipe For Compile Top vs DUT Top Lookup
- **What happened**: To answer which file/module is the DTI demo top, the agent had to manually inspect `sim/Makefile`, the demo-root umbrella filelist, and the generated `build_logic` top instead of following a single documented lookup recipe.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Extra archaeology each time a user asks "哪个文件是 top", especially when the currently open file is not the DUT top.
- **Category**: `skill-gap`

### F2: DTI Switch Naming Semantics Were Implicit, Not Documented
- **What happened**: Explaining `dti_switch_2i1o_wrap`, `dti_switch_3i1o_wrap`, and `dti_switch_4i1o_wrap` required tracing `DtiTreeTopo.py`, `DtiTreeNode.py`, `DtiTemplate.py`, and the wrapper ports because the shared skill did not spell out that `Ni1o` means N initiator-side inputs merged to one target-side output.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 4
- **Impact**: A simple naming question expanded into multi-file reverse engineering that should have been avoidable.
- **Category**: `skill-gap`

## Proposals

### Proposal 1: Add Demo Top Lookup And Wrapper-Naming Guidance — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2
- **Problem class**: Fast hierarchy identification in Python-generated lwnoc demos where users often open an internal wrapper and ask which file/module is really the top.
- **Change summary**: Extend `lwnoc-topo` with a concise rule for distinguishing compile top, DUT top, and internal wrappers, plus an explicit interpretation for DTI-style `Ni1o` switch names.
- **Specific changes**:
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: add a lookup rule using `sim/Makefile`, demo-root umbrella filelist, and generated top instantiation checks.
  - File: `SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: define `dti_switch_2i1o/3i1o/4i1o` as N-input-to-1-output fan-in blocks and point to `input_count=N` in topology Python.
  - File: `SKILL.md` — Section: `Pitfall Reference` — Action: add — Content sketch: add a pitfall for mistaking `*_wrap.sv` as the demo top.
- **Architecture notes**: This belongs in `lwnoc-topo` rather than a new skill because it is a recurring lookup pattern inside the existing topology-demo domain.
- **Estimated context cost**: +150 tokens in `SKILL.md`
- **Overlaps checked**: `design-microarch` helps reason about structure but not demo top lookup workflow; `fexpand` helps filelist flattening but not wrapper naming semantics; `ip-design` is too broad; `skill-creator/SKILL.md` is unavailable in the current skill inventory.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add demo top lookup and wrapper-naming guidance to `lwnoc-topo` | High | Low | P0 | ✅ Done |

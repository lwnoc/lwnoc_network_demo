# Skill Improvement Report — STS Single-Build Check

Date: 2026-04-14
Scenario: The user asked for a retrospective-style check to confirm whether the STS NoC demo's compile-facing filelists also converge to a single generated directory such as `build_logic`, instead of mixing `build_logic` and `build/temp`. The audit used demo-root filelists, `sim/Makefile`, generated sub-filelists, shell inspection, and the current skill inventory.

## Context

### Work Scenario
The task was to verify the STS demo's compile-facing generated RTL pathing, not just restate the earlier DTI or interrupt conclusion. The concrete checks were: demo-root umbrella filelist `lwnoc_sts_noc_demo/filelists/filelist.f`, `lwnoc_sts_noc_demo/sim/Makefile` exported `STS_DEMO_*_OUT_DIR`, generated `build_logic/*/*_filelist.f` sub-filelists, and a whole-tree grep to distinguish compile-facing inputs from scratch `build/temp` artifacts. The verified result was: the STS demo-generated RTL does resolve through a single `build_logic` tree, while `build/temp` remains scratch output and FCIP vendor filelists remain separate external collateral. Relevant tools and environment facts: shell/grep/read-file inspection, `fexpand` skill loaded but `fexpand` CLI was not installed, and the STS compile flow still includes external FCIP vendor filelists from `subs/lwnoc_sts_noc/fcip` in addition to the generated demo tree.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant; no coverage database audit in this task. |
| design-microarch | ✅ | Used earlier in the conversation for RTL behavior audits, but not the primary skill for this STS filelist check. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | Used earlier in the conversation; not primary for this build-tree audit. |
| dev-skill-index | ❌ | Not needed; no new cross-skill topology change. |
| dev-skill-load-test | ❌ | Not needed. |
| eda-toolchain-debug | ✅ | Relevant background only if VCS/filelist behavior became toolchain-related; no new EDA infrastructure issue was the main blocker here. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Relevant for hierarchical filelist expansion, but CLI unavailable in PATH, so manual inspection was required. ❌ NOT INSTALLED. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| ip-design | ✅ | Used earlier in the conversation; not primary for this narrow STS filelist audit. |
| issue-reporter | ✅ | Used earlier in the conversation; not relevant to this specific finding. |
| lwnoc-topo | ✅ | Primary skill for demo-root filelists, build tree semantics, and generated NoC topology outputs. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | Used earlier in the conversation for RTL work; not primary here. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for the retrospective report and proposal structure. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ✅ | Relevant background for tool-availability checks; not the primary audit skill here. |
| terminal-manager | ✅ | Used earlier in the conversation for long-running VCS tasks, but not required for this STS filelist-only confirmation. |
| wave-reader | ❌ | Not relevant. |

## Findings

### F1: Single-tree verification still needed a manual STS re-audit
- **What happened**: Even after earlier DTI and interrupt build-tree analyses, the user still needed a dedicated confirmation that the STS demo's compile-facing filelists also resolve through one generated tree. The current audit had to reread the STS umbrella filelist, Makefile exports, and generated sub-filelists instead of relying on one reusable checklist.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Repeated audits across demos cost time and create a risk of over-generalizing one demo's answer to another.
- **Category**: `quality-criteria`

### F2: Scratch and external-collateral paths can be mistaken for active compile inputs
- **What happened**: A whole-tree grep over `lwnoc_sts_noc_demo/**` returned many `build/temp` hits from scratch `*.expanded.f` artifacts, while the real compile-facing chain still points at `build_logic`. Separately, `sim/Makefile` also compiles FCIP vendor filelists from `subs/lwnoc_sts_noc/fcip`, which can be misread as evidence that the generated STS RTL is not single-tree.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Without a scope rule, an agent can answer the wrong question: "every dependency path" instead of "generated demo RTL pathing," leading to avoidable follow-up.
- **Category**: `quality-criteria`

## Proposals

### Proposal 1: Add a single-tree audit checklist and scope boundary — lwnoc-topo
- **Type**: Modify Existing
- **Target**: `skills/skills/lwnoc-topo/`
- **Addresses findings**: F1, F2
- **Problem class**: Auditing compile-facing generated RTL trees in lwnoc demos that also contain scratch generation artifacts and external shared collateral.
- **Change summary**: Extend `lwnoc-topo` with an explicit single-tree verification checklist, explain that `build/temp/*.expanded.f` is scratch rather than compile-facing evidence, and clarify that external vendor/common filelists do not invalidate a single-tree conclusion for demo-generated RTL.
- **Specific changes**:
  - File: `~/.claude/skills/lwnoc-topo/SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: `single-tree verification checklist using demo-root umbrella filelist, sim/Makefile exported *_OUT_DIR, and generated build_logic sub-filelists`
  - File: `~/.claude/skills/lwnoc-topo/SKILL.md` — Section: `Project Structure Convention` — Action: add — Content sketch: `scope boundary explaining why build/temp scratch outputs and external vendor/common collateral should not be conflated with compile-facing generated RTL`
  - File: `~/.claude/skills/lwnoc-topo/SKILL.md` — Section: `Pitfall Reference` — Action: add — Content sketch: `P013 scratch expanded-filelist false positives; P014 external collateral mistaken for loss of single-tree status`
- **Architecture notes**: Keep stable audit rules in the main build-tree section, and place future demo-specific failure modes in the pitfall table so the top-level workflow stays short while edge cases remain searchable.
- **Estimated context cost**: `+180 tokens in SKILL.md`
- **Overlaps checked**: `lwnoc-topo` already covered build_logic vs build/temp and hybrid models, but it did not explicitly separate scratch `build/temp/*.expanded.f` from compile-facing filelists or define the boundary between generated RTL and external collateral. `fexpand` can help flatten filelists, but the CLI is ❌ NOT INSTALLED here, so the skill cannot assume it. `skill-improvement-suggestor` only defines the retrospective workflow. `skill-creator/SKILL.md` is unavailable in this environment.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add single-tree audit checklist and scope boundary to `lwnoc-topo` | High | Low | P0 | ✅ Done |
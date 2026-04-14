# Skill Improvement Report — Git Push Large Blob

Date: 2026-04-15
Scenario: The task was to analyze a blocked `git push origin main:main` where GitHub rejected a 541.93 MB JSON file, then remove the offending large file so the local branch can be pushed. The environment involved a clean local repo on `main`, one unpushed local commit ahead of `origin/main`, GitHub SSH remote `git@github-sub-account-z:lwnoc/lwnoc_network_demo.git`, and a generated AST JSON artifact committed under `intr_demo1/`.

## Context

### Work Scenario
Direct repo inspection showed that `main` was clean and exactly one commit ahead of `origin/main`. The push blocker was not an untracked or merely staged file: commit `06394ad` introduced `intr_demo1/intr_iniu_sys_interrupt_iniu_aync_sys_side.interrupt_iniu_aync_sys_side.ast.json` as a 568,259,326-byte tracked blob, which GitHub rejected with `GH001`. The repo also tracks two other `*.ast.json` files, but they are much smaller: about 5.1 MB and 237 bytes. `skill-creator/SKILL.md` is not present in the available external skill inventory, so overlap review proceeded without it.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant to Git push large-blob failure. |
| design-microarch | ❌ | Not relevant. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ❌ | Not the right workflow for source-control push blockers. |
| dev-skill-index | ❌ | Not needed because the proposal modifies an existing skill rather than adding a new one. |
| dev-skill-load-test | ❌ | Not needed for this retrospective. |
| eda-toolchain-debug | ❌ | Not relevant; this is a GitHub policy rejection, not an EDA toolchain issue. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ❌ | Not relevant. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| issue-reporter | ✅ | Overlap checked as a handoff/escalation skill, but it does not cover GitHub push remediation. |
| lwnoc-topo | ❌ | Not relevant. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ❌ | Not relevant. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective, and the target for the low-effort workflow fix. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ❌ | Not relevant. |
| terminal-manager | ❌ | Not relevant. |
| wave-reader | ❌ | Not relevant. |
| ip-design | ❌ | Not relevant. |

## Findings

### F1: The Push Failure Needed History-Level Classification, Not Just Path Filtering
- **What happened**: The push error named one oversized JSON file, but the key fact was that the 568,259,326-byte blob was already committed in the single local-only commit ahead of `origin/main`. Without explicitly classifying the blocker as history-resident, a workflow could waste time only deleting or unstaging the working-tree file while leaving the rejected blob in local history.
- **Outcome**: ❌ Missed
- **Iterations**: 2
- **Impact**: Risk of repeating failed pushes and misunderstanding the remediation path; the real fix requires local history rewrite of the unpushed commit, not just worktree cleanup.
- **Category**: `quality-criteria`

### F2: Existing Retrospective Guidance Did Not Force Large-Blob Push Diagnostics
- **What happened**: `skill-improvement-suggestor` already captured sequencing and artifact-boundary issues, but it did not explicitly tell the agent to determine whether a publish blocker came from worktree/staging versus already-committed local history, nor to record offending blob path, size, and introducing commit.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 2
- **Impact**: Retrospectives about publish failures could stay too abstract and miss the concrete remediation class for large-file push rejections.
- **Category**: `skill-gap`

## Proposals

### Proposal 1: Add Large-Blob Push Diagnostics — skill-improvement-suggestor
- **Type**: Modify Existing
- **Target**: `skills/skills/skill-improvement-suggestor/`
- **Addresses findings**: F1, F2
- **Problem class**: Retrospectives for Git push/publish failures where a remote rejects large files or other host-policy blockers and the agent must distinguish worktree-state issues from already-committed local history.
- **Change summary**: Extend the retrospective workflow so git push/publish scenarios must record branch/upstream state, blocker layer (worktree, staged set, or local-only history), offending blob path/size, and the first introducing local commit when observable.
- **Specific changes**:
  - File: `~/.claude/skills/skill-improvement-suggestor/SKILL.md` — Section: `Step 1: Gather Context` — Action: add — Content sketch: capture push target, blocker layer, offending blob path/size/commit.
  - File: `~/.claude/skills/skill-improvement-suggestor/SKILL.md` — Section: `Step 2c. Identify root causes` — Action: add — Content sketch: add a signal for remote rejection caused by a large blob already committed in local-only history.
  - File: `~/.claude/skills/skill-improvement-suggestor/SKILL.md` — Section: `Quality Checklist` — Action: add — Content sketch: verify worktree-versus-history classification for push blockers.
- **Architecture notes**: This fits inside the existing retrospective workflow skill because the change improves analysis quality across future push/publish retrospectives without creating a new domain-specific skill.
- **Estimated context cost**: +95 tokens in `SKILL.md`
- **Overlaps checked**: `skill-improvement-suggestor` already covered sequencing and artifact-boundary capture but not history-aware push blockers; `issue-reporter` packages reproducible issues but does not classify GitHub push failures or prescribe local history diagnosis; `skill-creator/SKILL.md` was unavailable.

### Proposal 2: Add Git Publish Large-File Preflight Workflow — git-publish-workflow
- **Type**: New Skill
- **Target**: `skills/skills/git-publish-workflow/`
- **Addresses findings**: F1, F2
- **Problem class**: Publishing or pushing repos to GitHub when generated artifacts, large binaries, or host policy limits can block the push.
- **Change summary**: Add a dedicated publish skill that performs source-only staging audit, large-blob preflight on local-only commits, and approved remediation paths before the first push attempt.
- **Specific changes**:
  - File: `skills/skills/git-publish-workflow/SKILL.md` — Section: `Workflow` — Action: add — Content sketch: local-only commit audit, `git rev-list --objects`, size checks, history rewrite guidance for unpushed large blobs, and closure rules.
- **Architecture notes**: Keep the core workflow short and push tool-specific examples into optional references to preserve context economy.
- **Estimated context cost**: +230 tokens in `SKILL.md`
- **Overlaps checked**: No existing skill advertises Git/GitHub publish remediation; `issue-reporter` is escalation-oriented, not publish-oriented; `skill-improvement-suggestor` is analysis-only. `skill-creator/SKILL.md` was unavailable.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add large-blob push diagnostics to `skill-improvement-suggestor` | High | Low | P0 | ✅ Done |
| 2 | Create `git-publish-workflow` with large-file preflight | High | Med | P1 | ❌ Deferred — recorded in repo memory |
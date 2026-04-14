# Skill Improvement Report — Git Publish Order

Date: 2026-04-14
Scenario: The user wanted the repository changes uploaded first, without compiled files or logs. This retrospective checks whether the conversation preserved that priority, and whether the current skill pack has enough coverage for source-only git/GitHub publish tasks with remote/auth blockers.

## Context

### Work Scenario
Earlier in the conversation the user explicitly asked to upload the repo changes to GitHub while excluding compiled outputs and logs. The push did not complete because the remote target stayed unavailable: the current `origin` is `git@github-sub-account-z:lwnoc/lwnoc_network_demo.git`, HTTPS existence check for `https://github.com/lwnoc/lwnoc_network_demo` returns `404`, and SSH auth through the alias succeeds as `sub-account-z`. A manual fallback script already exists at `lwnoc_network_demo_manual_run.sh`, but the actual publish remained unresolved while the session continued with demo migration, compile verification, and more generated content. The current root `.gitignore` covers common sim/Verdi artifacts, but the untracked set still includes many generated scratch files under `lwnoc_dti_noc_demo/build/temp/**` and `*.expanded.f`, so a source-only publish request still requires manual filtering. Relevant tools and environment facts: `git`, `curl`, and `ssh` are installed and usable; no existing skill in `/home/lgzhu/.claude/skills/` advertises git/GitHub publish workflow coverage.

### Skill Inventory

| Skill | Used? | Relevance |
|-------|-------|-----------|
| cov-reader | ❌ | Not relevant; no coverage-db task in this scenario. |
| design-microarch | ✅ | Used earlier for RTL audits, but not relevant to git publish closure. |
| design-presentation | ❌ | Not relevant. |
| design-workflow | ✅ | Used earlier for RTL design flow, not for source-control publishing. |
| dev-skill-index | ❌ | Relevant only if a new skill is later added and needs upstream links. |
| dev-skill-load-test | ❌ | Not used; no AB test run in this session. |
| eda-toolchain-debug | ✅ | Used earlier for environment checks, but not a publish workflow skill. |
| fast-elaborator | ❌ | Not relevant. |
| fexpand | ✅ | Used earlier in the session for filelist work; unrelated to git publish. |
| floorplan-guide | ❌ | Not relevant. |
| integration-guide | ❌ | Not relevant. |
| ip-design | ✅ | Used earlier for RTL/IP work; not a git publishing skill. |
| issue-reporter | ✅ | Handles issue-package handoff, not repository push/upload closure. |
| lwnoc-topo | ✅ | Primary for the NoC demo tree, but not for GitHub publishing. |
| presentation-format | ❌ | Not relevant. |
| rtl-coding-style | ✅ | Used earlier for RTL work; not relevant here. |
| simforge | ❌ | Not relevant. |
| skill-improvement-suggestor | ✅ | Primary workflow skill for this retrospective report. |
| svlinter | ❌ | Not relevant. |
| sw-install-self-test | ✅ | Relevant only for tool availability checks, not publish workflow design. |
| terminal-manager | ✅ | Used earlier for long-running shell work, not for GitHub publish closure. |
| wave-reader | ❌ | Not relevant. |

`skill-creator/SKILL.md` was not present in `/home/lgzhu/.claude/skills/` and could not be consulted.

## Findings

### F1: Explicit publish-first work lost priority after the first blocker
- **What happened**: The user explicitly requested a GitHub upload excluding compiled files and logs. After the remote remained unavailable and a manual fallback script was produced, the session continued with substantial unrelated work instead of returning to close or clearly bracket the publish task; the repo is still unpublished at the target remote.
- **Outcome**: ❌ Missed
- **Iterations**: unresolved
- **Impact**: The user's requested order was not preserved, the unpublished delta grew materially, and later publish cleanup became harder because more generated and migrated content accumulated after the original push request.
- **Category**: `skill-gap`

### F2: Source-only publish still depends on manual artifact filtering
- **What happened**: The root `.gitignore` excludes common simulation and Verdi outputs, but it does not exclude many generated scratch paths such as `lwnoc_dti_noc_demo/build/temp/**` and `*.expanded.f`. Current untracked files include many such scratch artifacts, so a request to upload only source changes still requires manual auditing instead of a normalized publish boundary.
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3
- **Impact**: Time is wasted re-auditing untracked paths, and the risk of pushing scratch outputs or omitting intended source changes stays high.
- **Category**: `automation-opportunity`

## Proposals

### Proposal 1: Add sequencing-priority checks to the retrospective workflow — skill-improvement-suggestor
- **Type**: Modify Existing
- **Target**: `skills/skills/skill-improvement-suggestor/`
- **Addresses findings**: F1
- **Problem class**: Retrospectives where the user explicitly required an execution order and the agent drifted into later work before completing the prerequisite.
- **Change summary**: Extend the timeline and outcome rules so the retrospective must record explicit order constraints, and must not treat workaround artifacts as completion of a prerequisite unless the user explicitly asked for fallback behavior.
- **Specific changes**:
  - File: `~/.claude/skills/skill-improvement-suggestor/SKILL.md` — Section: `Step 2: Analyze Conversation` — Action: modify — Content sketch: `record explicit first/先/before constraints in the timeline and classify bypassed prerequisites correctly`
  - File: `~/.claude/skills/skill-improvement-suggestor/SKILL.md` — Section: `Step 2c. Identify root causes` — Action: add — Content sketch: `signal for ignored prerequisite order`
  - File: `~/.claude/skills/skill-improvement-suggestor/SKILL.md` — Section: `Quality Checklist` — Action: add — Content sketch: `verify unresolved prerequisites were not treated as completed because a manual script existed`
- **Architecture notes**: Keep this rule inside the analysis workflow rather than the markdown template so it improves all future retrospective domains without requiring larger per-report content.
- **Estimated context cost**: `+90 tokens in SKILL.md`
- **Overlaps checked**: `skill-improvement-suggestor` already covered timeline reconstruction but not explicit order constraints or the difference between fallback artifacts and actual completion. `issue-reporter` covers handoff packages, not prerequisite sequencing. `skill-creator/SKILL.md` was unavailable.

### Proposal 2: Create a dedicated git/GitHub publish workflow skill — git-publish-workflow
- **Type**: New Skill
- **Target**: `skills/skills/git-publish-workflow/`
- **Addresses findings**: F1, F2
- **Problem class**: Requests to upload or push current repo changes while excluding generated artifacts and handling remote existence, auth, and fallback-script closure.
- **Change summary**: Add a focused skill for `push/upload/publish` tasks that treats `first/先` as a hard sequencing barrier, audits source-only staging boundaries, runs non-interactive remote/auth preflight, and either completes the push or produces a verified manual script before allowing unrelated work to continue.
- **Specific changes**:
  - File: `skills/skills/git-publish-workflow/SKILL.md` — Section: `When to Use` — Action: add — Content sketch: `trigger phrases such as push/upload/publish/先上传改动/推到 GitHub`
  - File: `skills/skills/git-publish-workflow/SKILL.md` — Section: `Workflow` — Action: add — Content sketch: `sequence barrier, source-only diff audit, remote existence/auth preflight, push or manual-script fallback`
  - File: `skills/skills/git-publish-workflow/SKILL.md` — Section: `Common Mistakes` — Action: add — Content sketch: `continuing unrelated work after a blocked publish, assuming fallback script equals completion, trusting broad untracked trees without audit`
- **Architecture notes**: Keep the core SKILL.md short and stable, and move future host-specific examples into optional `reference/` notes so the skill stays lightweight. If created later, it should receive at least one strong upstream link from a high-traffic workflow skill or it will stay discoverability-poor.
- **Estimated context cost**: `+220 tokens in SKILL.md`, with optional on-demand reference files if more examples are needed.
- **Overlaps checked**: No existing skill in `/home/lgzhu/.claude/skills/` advertises git/GitHub publish coverage. `issue-reporter` handles reproducible issue packages, not repo pushes. `skill-improvement-suggestor` is analysis-only. `dev-skill-index` becomes relevant only once a new skill is created and cross-linked. `skill-creator/SKILL.md` was unavailable.

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|--------------|
| 1 | Add sequencing-priority checks to `skill-improvement-suggestor` | High | Low | P0 | ✅ Done |
| 2 | Create `git-publish-workflow` for source-only push/upload tasks | High | Med | P1 | ❌ Deferred — recorded in repo memory |
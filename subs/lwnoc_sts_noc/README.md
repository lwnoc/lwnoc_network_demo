# lw_status_manage_noc_component
niu component of status management noc
iniu:
  src sys side
  noc side
tniu:
  noc side
  dst sys side

## Workspace Hygiene

For long regressions and coverage runs, keep generated EDA artifacts out of the editor fast path.

- Run `make hygiene` to summarize large logs, build outputs, VCDs, and coverage databases.
- Use the workspace excludes in `.vscode/settings.json` to prevent VS Code from watching `work/`, `csrc/`, `simv.daidir/`, `cov/`, and large logs.
- Use `make clean_generated` before a fresh coverage rebuild if stale VCS artifacts start causing link or editor issues.
- Enable detailed tracing only when debugging a specific issue: pass `SIM_ARGS='+ENABLE_TRACE +ENABLE_VCD'` to the relevant `make` target.

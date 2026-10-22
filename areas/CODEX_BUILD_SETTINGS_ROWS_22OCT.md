# CDS missing Settings rows — 22 October 2026

1. **PR:** pending. Branch `cx/settings-rows-c60`, base `origin/claude/rel-20261022m` at `40ee0a36f7960145743954b39859eb6c3af92869` (also read from the installed Civil DLL). Tests added and final totals: pending.
2. **Scope:** desk plan/03 brief, review entries 1582.5 and 1586; Settings window only. Defaults unchanged. No deployment, AutoCAD launch or writes to Tim's settings files authorised.
3. **Verified finding:** four requested rows already exist on Newer tools: `linking.tidyLeaderOut`, `doubleClick.opensEditWindow`, `checks.allowIgnoreFinding`, `checks.checksCommandEnabled`. Keep exactly one of each. Six missing: both layer findings, slow progress tick and seconds, removed-pit exclusion, source Edit window.
4. **Work:** private short worktree `C:\ce-c60`, baseline full Civil net10 suite running with the mandatory skip flag and C-57 reference paths. Every change will use the existing draft, change tracking, Reset, Save and search. All tabs will be rendered dark/light and checked at 150%.
5. **Remaining:** implement, check defaults and saved keys through real controls in temporary settings files; all three build lanes; full Civil net10 suite; focused net48 suite; inspect pictures; top regression entry; commit named files; draft PR against the current release line; final report.
6. **Undo:** revert this branch's Settings commit. Nothing installed; real AutoCAD behaviour remains untested by this task.

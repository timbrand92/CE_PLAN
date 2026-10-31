# BUGFIX n13 REPORT, 31 Oct 2026: batch 13, Inspector follow-ups, Civil, build B-127

## FOR TIM (plain English; nothing below the line needs reading)

1. **Four small Inspector fixes are built as draft pull requests. None is installed, none is tested in AutoCAD.** They are all "low and rare" follow-ups to the reopen fix (BUG-1240, #1880). Each is switched ON by default and each has a Settings switch that puts the old behaviour back.
2. **BUG-1263 (PR #1953): two drawings, a change that could not be saved.** You change a pit in drawing A, the save cannot happen (read-only file, busy drawing), you switch to B and back. Before: picking the pit in A showed the older saved values. After: it shows the newer values CE is holding for A.
3. **BUG-1264 (PR #1955): Undo in drawing A after picking in drawing B.** Before: the Undo could leave the Inspector listing a pit the Undo had removed. After: CE clears its pit list for A to match the drawing. This one touches Undo, so I ran the REDO safety scan (25 of 25 pass).
4. **BUG-1265 (PR #1951): one rule instead of two.** The rule "use CE's list in memory, or read the list saved in the drawing" existed twice (CDCHECK and the Inspector), so the two could disagree after a reopen. Now there is one. You see nothing different. A wrong switch name in a comment is fixed.
5. **BUG-1266 (PR #1958): log noise.** A drawing whose saved list cannot be read used to write two log lines on every pick. Now one line per drawing, and the Inspector stops re-trying the read at every pick. **Not done:** remembering a HEALTHY saved list per drawing. It could show old values and I cannot tell when it changes. One question below.
6. **Order matters.** The four PRs sit on top of each other, and all on top of draft #1880 (still an open draft, so nothing here can merge before it). Merge order: #1880, then #1951, #1953, #1955, #1958. Each PR targets the one before, not the release line.
7. **What to do:** nothing now. Robot cases are named below; two of them (1263, 1264) need two drawings open and are awkward to automate, so a Codex look may be the cheaper proof.
8. **One question for CE 04 (from CE 05):** should the Inspector keep a good saved-list read per drawing to save time on big drawings? My recommendation: first measure the read on your biggest job drawing. If it is under about a quarter of a second, leave it as is. Example: a 600-pit drawing where picking a pit takes a visible pause.
9. **Mistakes of my own, first:** (a) my first commit command failed (wrong way of passing the message) after I had already pushed the branch name; the branch then held #1880's tip for about a minute, then the real commit went on top with a normal push. Nothing was force-pushed. (b) The PR text for #1953 said the net48 compile was not run; I ran it afterwards on the top branch (it contains all four changes) and it passes with 0 errors. (c) Free space moved only 0.43 GB on clean-up, not several GB; the build output was small and NuGet packages stay in their cache.

---

## TECHNICAL

### PRs (all DRAFT, all titles start with B-127, none merged or closed by me)

1. **#1951, BUG-1265**, branch `fb/bug1265-one-record-read-rule`, base `fb/bug1240-inspector-reads-saved-record` (= #1880's branch).
2. **#1953, BUG-1263**, branch `fb/bug1263-inspector-shows-waiting-record`, base #1951's branch. Switch `linking.inspectorShowsRecordWaitingToSave`.
3. **#1955, BUG-1264**, branch `fb/bug1264-undo-clears-list-after-other-drawing-read`, base #1953's branch. Switch `linking.undoRemembersEachDrawingsRecord`.
4. **#1958, BUG-1266**, branch `fb/bug1266-inspector-unreadable-record-once`, base #1955's branch. Switch `linking.inspectorUnreadableRecordLoggedOnce`.

### Stacking and why

1. The plan says batch 13 joins after #1880 (BUG-1240, B-059) merges. #1880 is an OPEN DRAFT (head `fb/bug1240-inspector-reads-saved-record`, base `claude/rel-20261102a`). `Rules/InspectorProjectSourceRule.cs` and the Inspector code the follow-ups change exist only on that branch, so I started there and based PR #1951 on it. #1866 (B-055, CDCHECK) is already inside the #1880 branch (its files are present), so the "depends on #1866" part of the plan is met.
2. The four PRs also stack on each other because they all add a switch to `UserSettings.cs`, an entry to `REGRESSION_LOG.md`, and #1953 / #1958 edit the same block of `RefreshCivilProperties`. Independent branches would conflict at every merge.
3. When #1880 merges, #1951 needs its base changed to the release line by whoever owns merges (I never retarget, D6).

### Per bug: reproduce on the line first, cause, fix

1. **BUG-1263, CONFIRMED by code read** (`Services/ProjectDataService.KeptRecords.cs` parks a record that could not be saved when CE's list switches drawing; `Services/InspectorPaletteService.cs` `RefreshCivilProperties` ignored it and, since #1880, read the older saved list). Fix: `ProjectDataService.TryReadKeptRecordCopy` (a copy, matched by drawing pointer and path, takes and forgets nothing) and a new answer `KeptRecord` in `InspectorProjectSourceRule`. Never replaces the list in memory.
2. **BUG-1264, CONFIRMED by code read and reproduced headless** (`EmbeddedRecordMemory`, switch OFF, gives the old answer and `DecideHistoryReload` returns `KeepMemory`). Cause: `ProjectDataService._embeddedRecordDatabase` was one pointer; any successful read or save replaced it (`Persistence.cs` `NoteEmbeddedRecord`), so a pick in B moved the note from A to B and the Undo in A took the "before the first save, keep memory" path. Fix: one note per drawing, dropped at drawing close (one line in `LinkService` close handler) because AutoCAD can reuse a closed drawing's memory.
3. **BUG-1265, CONFIRMED** (the two rule files were line-for-line copies; comment named `inspector.readsSavedRecordWhenNotLoaded`, real key is `linking.inspectorReadsSavedRecordWhenNotLoaded`). Fix: new `Rules/ProjectRecordReadRule.cs`; both rules call it; public names and both existing switches unchanged. No new switch (code tidy).
4. **BUG-1266, PARTLY CONFIRMED.** Confirmed: a failed saved-list read is not remembered; `RefreshCivilProperties` also runs for an empty selection, so read and log repeat at every refresh. The "two lines" are the failed read's own error line (`TryLoadFromDrawing` logs "Failed to load project data from DWG" when the JSON throws) plus the Inspector's warning; I did not run a real unreadable record, so the exact line count is from the code and the card. Fix: failure remembered per drawing (pointer plus path). The card's "remember the read per drawing" for a good read was NOT built, reason and question above.

### Skipped, with evidence

1. Nothing in this batch was skipped as already fixed, window-only or AutoCAD-only; one item was built in part (BUG-1266, above).
2. No window was changed. No Codex brief needed.

### Switches (all `Default: on.`, group `linking`, declared in `Models/UserSettings.cs`)

1. `inspectorShowsRecordWaitingToSave` (BUG-1263)
2. `undoRemembersEachDrawingsRecord` (BUG-1264)
3. `inspectorUnreadableRecordLoggedOnce` (BUG-1266)
4. Each is pinned in its own new test through BOTH start-up reads (`SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`) for three file shapes, typed false turns off only itself, missing group reads ON. I did NOT add them to `C78NewSwitchDefaultsTests` (that file is the C-78 train's own pin); a later finalizer should add the three keys to the next train's pin. They are not shown on the Settings page (the neighbouring BUG-1240 switch is not either).

### Tests run (net10.0-windows, Release, one test project, always with a filter, `-m:2`, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below-normal priority)

1. Top of the stack (#1958 tip), 79 of 79 pass: `Bug1266...`, `Bug1264...`, `Bug1263...`, `Bug1265...`, `Bug1240...`, `RedoSafeCallGraphTests` (25).
2. Also 107 of 107 at the BUG-1264 tip (adds the Undo policy tests) and 210 of 210 source-guard tests around the Inspector and REDO window (`Bug861RedoFirstClickTests`, `Bug861DiagSwitchesTests`, `Bug892InspectorEmptyCountTests`, `Bug385MoreRecordBindsTests`, `InspectorPaletteServiceHintTests`, `CeInspectorHostWiringTests`, `RedoRound2Tests`, `RedoWindowGuardTests`, `LinkServiceCommandPerformanceContractTests`). `B055CdcheckReadsThisDrawingsRecordTests` 14 of 14 at the BUG-1265 tip. Counts were checked to be above zero every time.
3. net48 compile of `Modules/Drainage/CE_CVL_SUITE.csproj` on the top branch: 0 errors (216 pre-existing warnings on net10).
4. The full suite was NOT run (the job says focused classes only). Manager tests were never run. The build needed a 0-byte placeholder `CE_TRANSFORM_2027.arx` under `Modules/Shared.Transform.Native2027/bin/x64/Release`; it was untracked and went with the worktree. The MSBuild after-build step was not a problem.

### What I did NOT test

1. Nothing was run in AutoCAD, Codex or accoreconsole. Two-drawing behaviour, a failed save, an Undo across drawings and a damaged record cannot be driven headless.
2. The speed of the saved-list read on a big drawing is unmeasured (BUG-1266 question).
3. Not run: the full Civil suite, the PDF page test, net48 tests (compile only), Manager, Structural.

### Robot cases to write (names proposed, each with a switch-off control)

1. **N13a_inspector_kept_record / C13a (BUG-1263):** two drawings; a CE command in A with the drawing locked so the save is kept; a CE command in B; back to A; pick the changed pit. Checks the Inspector value of the changed field. Right: new value. Control: `inspectorShowsRecordWaitingToSave` false, older saved value.
2. **N13b_undo_two_drawings / C13b (BUG-1264):** PIT in A, pick in B, `U` in A back before the PIT, pick in A. Checks the Inspector pit count and the CE log line "Undo removed CE's record from this drawing". Control: `undoRemembersEachDrawingsRecord` false, the pit is still listed.
3. **N13c_inspector_unreadable_once / C13c (BUG-1266):** a test copy with damaged record text, three picks, count `[Inspector]` "could not be read" lines in the CE log. Right: 1. Control: `inspectorUnreadableRecordLoggedOnce` false, one per pick.
4. BUG-1265 needs no robot case (nothing visible changes; the unit test proves the two rules agree in all eight cases).

### Shared files and clashes

1. **Touched:** `Modules/Drainage/Models/UserSettings.cs` (three switches), `REGRESSION_LOG.md` (four entries), `Modules/Drainage/Services/LinkService.cs` (two lines in the document-close handler). **CE_SHARED not touched.** No Settings-engine or loader change (only new keys on the existing `linking` group), so no N91 needed beyond the normal area re-test.
2. **Also touched (not on the shared list):** `InspectorPaletteService.cs`, `ProjectDataService.cs`, `ProjectDataService.Persistence.cs`, `ProjectDataService.KeptRecords.cs`, `InspectorProjectSourceRule.cs`, `CdCheckProjectSourceRule.cs` and five new rule files / four new test files.
3. **Open drafts that edit the same files (gh pr view per open PR, checked 31 Oct):** `UserSettings.cs` is edited by nearly every Civil draft (usual keep-both-sides). `InspectorPaletteService.cs`: #1920 and #1897 (BUG-903, project summary and pit-warning hunks, far from mine), #1815, #1798, #1784, #1779. `ProjectDataService.cs`: #1944 (BUG-296, `Recovery.cs` hunks, far from mine) and #1830 (BUG-1225, already in the base). `ProjectDataService.Persistence.cs`: #1821, #1782, #1758. `CdCheckProjectSourceRule.cs`: #1866 (the original) and #1857 (old base carrying it as a new file). Clash PRs seen by number: #1949 to #1937, #1927, #1926, #1924, #1920, #1919 touch only `UserSettings.cs` among my files. Whichever merges second resolves by keeping both sides.

### Real-files compare (names, sizes and times only, no contents)

1. Before: 33537 files under `%APPDATA%\TIM_CE_CADTOOLS`, `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS`, `CE_SUITE`. After: 33554. 51 lines differ.
2. **No settings file changed:** `TIM_CE_CADTOOLS\CD_Settings.json` 15270 bytes, 2026-10-04 08:22:30; `CS_Settings.json` 35613 bytes, 2026-10-30 19:54:14; `settings.json` 672 bytes, 2026-09-16 12:13:17; `CS_Settings.json` 351713 bytes, 2026-03-31 13:18:00; all identical before and after.
3. **What did change, and why it is not mine:** logs, `CE_Admin\outbox` usage and machine files, `ledger\suggestions.jsonl`, `telemetry\outbox.jsonl`, `CE_Admin\sessions`, `manager-menu-state.json`, the Manager menu `.cuix`, and `CD_RecentValues.json` (12220 bytes, 8:39:41 pm). An AutoCAD process (`acad.exe`, started 8:43:24 pm, not started by me) was running when I looked, and an earlier AutoCAD session wrote files at 8:13 pm. My test runs were 8:19-8:20, 8:30-8:31, 8:36, 8:42-8:43 pm and my redirected log folder stayed empty, so by timing the 8:39:41 write to `CD_RecentValues.json` was not made by a test run of mine. I cannot prove that from the file itself. Full before and after lists (names, sizes, times) are saved at `C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-desk-new-chat-start-prompt-a377a5\cfcdf1b6-1fff-471f-aa77-cf0ac3351cdf\scratchpad\n13_real_before.txt` and `n13_real_after.txt`.
4. Isolation: before every build and test I set and printed `CE_STRUC_SUITE_APPDATA_ROOT`, `CE_LOG_DIR_OVERRIDE`, `TEMP`, `TMP` to `C:\CE_WORK\scratch\n13\...`, with a script that refuses to run if any points at `%APPDATA%`. No dotnet command named a solution; every test command named the one test project and carried a filter.

### Clean-up and timing

1. Worktree `C:\CE_WORK\build\n13` cleaned (`git clean -fdXq`), removed with `git worktree remove`, and `C:\CE_WORK\scratch\n13` deleted. Nothing new at the root of C:.
2. C: free space: 30.46 GB at start, 29.19 GB just before clean-up, 29.63 GB after; clean-up moved about 0.43 GB.
3. Finished at about 8:50 pm on the PC clock (Saturday 31 Oct 2026).
4. I did not edit `BUG_CARPARK.md`, did not start AutoCAD, Codex or accoreconsole, did not touch installed bundles or Tim's settings files, and never force-pushed.

# Review: claude/b1276-unsaved-structural (BUG-1276 Structural half, PR #2034)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:20. Read only. Nothing built, run or installed.
**Base checked:** branch sits on `8de95c34` (installed Structural 1.0.126); its own change is five commits, `4a231b69` to `c565a0fc`, diffed with `git diff 8de95c34...origin/claude/b1276-unsaved-structural`.
**Where it already is:** PR #2034 was MERGED on 5 Nov into `claude/rel-20261026s`, the held S-46 line (Structural 1.0.127). S-46 is not installed.
**Card:** TRUST-04, Structural item 2. **Bug:** BUG-1276 (a Structural drawing with no CE backup across about 2.5 hours of editing, then a crash the next morning). **Tim's ruling:** decision 223, "c" = reminder and timed copies.

---

# FOR TIM

1. **What it does:** the same as the Civil half. After 25 minutes unsaved, "Not saved for 25 min" in the CE status text and once on the command line; every 10 minutes a copy of AutoCAD's own automatic-save file goes into CE's backup folder. The Settings page gets the on/off boxes and the minutes.
2. **It is a guard, not the cure.** Why CE made no backup that afternoon is still not known; the reminder would have warned you, and the copies only work if AutoCAD's own automatic save is running.
3. **Verdict: FIX FIRST** (CE never tells you when it cannot make copies; some reasons it prints are software words; a real job's number and street are in the tests; Codex must look at the new Settings rows).

---

## Findings

1. **Same scope as decision 223, so card TRUST-04 needs correcting** (see the Civil review, finding 1). The two suites share one rule file: `Modules/Structural/Services/UnsavedWorkPlanner.cs` is the Civil file except for pruning (compared line by line).
2. **FIX FIRST: CE never says on screen when it cannot make copies.** When AutoCAD's automatic save is off ("SAVETIME 0") or no automatic-save file appears, the skip goes only to the log (`Services/DrawingAutoSaveService.UnsavedWork.cs` 317, `LogUnsavedSkip`) and the status-bar tooltip. The bug's expected behaviour is that CE says so once in plain words. On the incident day the bug records no automatic-save files at all, so this case is the likely one, not a corner case.
3. **FIX FIRST: software words in the new "backup copy not made" line.** `DrawingAutoSaveService.cs` 1180 prints "CE: backup copy not made (reason)." (gated on the reminder switch, good). The reasons come from `DrawingSafetyService` and include "document disposed", "database inaccessible", ".sv$ autosave drawing", "non-DWG drawing". Plain words, as for Civil.
4. **FIX FIRST: a real job's number and street name are in the tests.** `Modules/Structural.Tests/Services/UnsavedWorkPlannerTests.cs` lines 21, 22, 39, 42 and onward. Made-up names at the lift; old commits listed here for the controller (RULES 11.3). Line 435 of the same file also uses a job-number-shaped folder; make it obviously made up.
5. **Before acceptance: the Settings window rows need a Codex look.** `UI/Dialogs/CeSettingsDialog.xaml` 570 to 585 adds three boxes and three ticks in the AutoSave group. Windows are Codex's work (ruling B, 15 Sep; `trust-plan.md` section 1 item 6). The labels are plain ("Remind me when a drawing has not been saved"), though "Every (minutes)" on its own is vague.
6. **Should fix before colleagues: one folder for copies.** Structural writes to `AutoSaveBackups\CE_STRUC_SUITE` (`DrawingAutoSaveService.cs` 1336), Civil to `...\CE_CVL_SUITE`; whichever suite starts first does the copying, so a drafter may have to look in either after a crash.
7. **Small differences from Civil (design rule 1, one way per behaviour):**
   1. The AutoCAD save-time change has no Redo-window guard here (`UnsavedWork.cs` 100 to 119); Civil added one. Low risk: it runs only at start-up and its switch ships OFF.
   2. With SAVEFILEPATH blank, Structural finds no automatic-save files (`UnsavedWork.cs` 435); Civil falls back to the Windows temporary folder.
   3. Which drawings are skipped differs: Civil's check skips template drawings (`DrawingSafetyService.cs` line 247 in Civil), Structural's `RecoveryReason` does not. So a template may or may not get copies depending on which suite started first.
8. **Build note for whoever packages S-46:** on `claude/rel-20261026s` the version commit `97ee6d11` (1.0.127) comes BEFORE the merges `5cbd8b17` (this branch's last fix, the drawing-comparison guard `c565a0fc`) and `f8a01fe4`. A package built at the version commit lacks them. Check the tip before any S-46 build.
9. **Checked and fine:** never saves, wblocks, locks or opens a transaction on the drawing (source-text test, `UnsavedWorkPlannerTests.cs` from line 455); background copy results are handed back under a lock and logged on the main thread (`ConsumePendingCopyResult`); the "is this an Xref of another open drawing" check reads only and compares drawings the safe way (`AutoCadDocumentIdentity.SameDatabase`, the BUG-279 guard); skips read-only drawings, REFEDIT, two drawings with the same name, old automatic-save files; saved-file backups and unsaved copies are pruned separately so one never pushes out the other; settings recovery names added in plain words; no units involved; no existing test weakened; `Shared\CE_SHARED` untouched.

## What I did not check

1. Nothing was built or run; nothing seen in AutoCAD (automatic-save file names on 2027, copy time, the Settings rows as drawn).
2. The cause of the missing backups on 4 Nov (BUG-1276 cause is still unknown).
3. Whether S-46 as merged still builds and passes (not my lane; the merge itself was not re-run).
4. AutoCAD 2022 to 2024.

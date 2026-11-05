# REVIEW: BUG-1276 final re-check, PR #2035 (Civil, B-220) and PR #2034 (Structural, B-221)

Thu 5 Nov 2026 (Melbourne). Opus reviewer on Tim's Max account. Read only: `git fetch`, then read the two commits and the branch files. Nothing built, run, changed or pushed. PR heads confirmed on GitHub: #2035 `1d3d44b8` (base `claude/rel-20261112a`, draft), #2034 `3b837622` (base `claude/rel-20261026s`, draft). Earlier re-check: `REVIEW_B1276_FF_05NOV.md`. Builder report: `BUGFIX_ff2035b_2034b_REPORT_05NOV.md`.

## FOR TIM

1. **#2035 Civil: GO.** A failed copy now waits one full interval and logs once. An old automatic-save file is never taken as today's work.
2. **#2034 Structural: GO.** Same rule file as Civil, one due rule, failed copy waits one interval, the three minute boxes are in the number-check list.
3. **Both still never write your drawing:** no Save, SaveAs, Wblock, lock or transaction. "Set AutoCAD's automatic save" still ships OFF. CE_SHARED untouched.
4. **Doubt 1:** nothing has run in AutoCAD; the 2027 automatic-save file name and folder are still unproven.
5. **Doubt 2:** a second AutoCAD window with a drawing of the same file name could, in theory, have its automatic-save file picked. Not blocking, but worth one robot check.
6. **Doubt 3:** the Structural net48 test project was not compiled by the builder; on reading I found nothing that would stop it compiling.

---

## PR #2035 Civil (B-220), commit 1d3d44b8: GO

1. **Old `.sv$` never matched as the wrong drawing's work: PASS.** `Modules/Drainage/Services/UnsavedWorkPlanner.cs`:
   - line 237 skips any file written before the first change (`LastWriteUtc >= unsavedSinceUtc`);
   - line 236 skips any file not newer than the last one taken;
   - line 230 matches only `<name>_n_n_n.sv$`;
   - line 203 skips when two open drawings share the name.
   The service passes `UnsavedSinceUtc` (`DrawingBackupService.cs` line 603) and resets it on save (line 451). The failure branches stamp only `LastUnsavedCopyUtc`, not `LastSvTakenUtc`. So a failed try never marks a file as taken, and it never lets an older file through.
2. **Failed copy backs off at least one interval and logs once: PASS.**
   - **Retry branch** (`DrawingBackupService.cs` lines 663 to 670) and **exception branch** (lines 682 to 687) both set `UnsavedCopyDue = false` and `LastUnsavedCopyUtc = now`.
   - **The 30 s timer** (line 467) raises the due flag only through `IsDue`, which uses the later of the last try and the first change. Idle moments therefore stop, and the next try comes one Settings interval later.
   - **Logging:** one log line per failure, carrying the next try time (`NextTryUtc`, planner line 171).
   - **Test:** `AfterAFailedCopy_NothingIsDueAtIdleMomentsUntilTheNextInterval` drives `IsDue` and `NextCopyDecision`.
3. **CE never writes the open drawing: PASS.** No Save, SaveAs, Wblock or LockDocument in `UnsavedWorkPlanner.cs` or `DrawingBackupService.cs`. The commit touches 4 files: planner, service, tests, REGRESSION_LOG.
4. **Switch and BOM: PASS.** `MatchAutoCadSaveTime = false` (`Models/UserSettings.cs` line 1714). `UserSettings.cs` still starts with a BOM (EF BB BF) and is not in the commit.
5. **Small, not blocking:**
   - The background task writes `DocState` fields without a lock. This was there before; a 64-bit DateTime write is safe.
   - `PickSvFile`'s `unsavedSinceUtc` is still optional, so a future caller that leaves it out turns the old-file guard off. The one caller passes it.

## PR #2034 Structural (B-221), commit 3b837622: GO

1. **Old `.sv$` never matched as the wrong drawing's work: PASS.** The planner is the Civil file: same lines 230 to 237 and 203. The service passes `UnsavedSinceUtc`, `LastCopyUtc` and `LastSvTakenUtc` (`DrawingAutoSaveService.UnsavedWork.cs` lines 294 to 296). On save, `ClearUnsavedTracking` (line 155) resets the first-change time. `LastSvTakenUtc` is set only after a good copy (line 352).
2. **Failed copy backs off at least one interval and logs once: PASS.**
   - **Covers:** both the Retry result and the caught exception (lines 343 to 346).
   - **What happens:** both stamp `LastUnsavedCopyUtc` under the lock (line 360). The timer (line 207) and the idle copy (line 274) both ask `UnsavedWorkPlanner.IsDue`.
   - **The old rule is gone:** "first copy at once / due when MinValue" no longer appears. The source guard `TheService_UsesThePlannersDueRule_NotItsOwn` checks this.
   - **Logging:** one line per failure, with the next try time (`ConsumePendingCopyResult`, lines 390 to 395).
3. **CE never writes the open drawing: PASS.**
   - **No write calls:** no Save, SaveAs, Wblock, LockDocument or transaction in the service or planner. The only hit is the guard comment on line 16.
   - **One variable write:** `SetSystemVariable("SAVETIME")` (line 119), behind the OFF switch (`Models/UserSettings.cs` line 445).
   - **Background copy:** the copy task touches files only. A source-text test guards this.
4. **The two `UnsavedWorkPlanner.cs` copies: now the same logic.** A line-by-line diff shows only two differences:
   - the namespace;
   - `SelectPruneByKind` is removed from Structural (Civil lines 257 to 276), replaced by a comment. Structural keeps "newest N per kind" as `DrawingAutoSaveService.SelectToPrune`.
   **Remaining difference in behaviour:** pruning only. "Unsaved copies to keep 12" means a floor plus retention days in Civil, and a cap in Structural. This is a Tim question, not a fault.
   **Tests: nearly the same set.** All shared planner tests are in both. Differences:
   - **Civil only:** `ADrawingInTheTempFolder_IsSkippedAsARecoveryDrawing`, `RecoveryOrAutosaveLikeDrawings_AreSkippedWithThatReason`, `ThirtyUnsavedAndFiveSaved_KeepsAllSavedAndTheNewestTwelveUnsaved`, and `TheService_NeverSaves...`. These test Civil's own service, recovery and prune code.
   - **Structural only:** `FirstCopy_IsDueOnlyAfterTheCopyIntervalFromTheFirstChange_NotAtOnce`, `Pruning_IsByKind...`, `RecoveryOrTemporaryDrawing_HasAReasonAndIsSkipped`, `NewServiceCode_NeverSaves...`, `TheService_UsesThePlannersDueRule_NotItsOwn`.
   - **Gap:** Civil still lacks the "first copy waits the interval" test. The rule itself is correct.
5. **Minute boxes and Bug841: PASS by reading.**
   - **The list:** `UI/Dialogs/CeSettingsNumberBoxes.cs` lines 52 to 54 add `UnsavedReminderMinutesTextBox`, `UnsavedCopyMinutesTextBox` and `UnsavedMaxCopiesTextBox`.
   - **What the test needs:** these are exactly the three names read through `IntOr(` in `CeSettingsDialog.xaml.cs` (lines 424, 426, 428), which is what `Bug841SettingsNumberTextTests` requires.
   - **Box labels:** each box has a XAML `Label Target=` (`CeSettingsDialog.xaml` lines 573, 578, 583), so `BoxLabel` has plain words.
   - **BOM:** Structural `UserSettings.cs` still has no BOM (starts `namespace`). Civil `UserSettings.cs` still has its BOM.
6. **Structural net48 test project, read for compile risks: nothing found.**
   - **C# version:** the project uses `LangVersion latest`, so throw expressions, `out _`, `out object v`, `$@""` and `int?` test cases are all fine.
   - **.NET Framework 4.8 support:** `AppContext.BaseDirectory` and `Path.Combine(string[])` both exist in 4.8.
   - **Usings and names:** `CE_STRUC_SUITE.Models` (for `AutoSaveSettings`) and `CE_STRUC_SUITE.Services` are present. The `Planner` alias is correct.
   - **Internal access:** `DrawingAutoSaveService.SelectToPrune` (line 548) and `RecoveryReason` (line 511) are `internal static`. `InternalsVisibleTo("CE_STRUC_SUITE.Tests")` is in `Properties/AssemblyInfo.cs`.
   - **Planner names:** `SvCandidate(string, DateTime, long)`, `KeepDue`, `NextTryUtc` and `CopyDecision.Skip(reason, keepDue)` all exist. `ReadSource` walks up to `Modules/Structural/CE_STRUC_SUITE.csproj` and does not depend on the target framework.
7. **Small, not blocking:**
   - The disk and Xref reads (line 304) are not gated on REFEDIT the way Civil's are. During an in-place Xref edit, that is one wasted look per 30 s tick. The planner still skips correctly.
   - `PickSvFile`'s optional parameter: same note as Civil.

## KNOWN LIMITS (for the PR descriptions)

1. **Nothing run in AutoCAD.** Every result is a unit test or reading. No robot or Codex pass yet, so the bug is not FIXED.
2. **`.sv$` naming and folder on AutoCAD 2027 are unproven.** The match assumes `<name>_n_n_n.sv$` in SAVEFILEPATH. Also unproven: whether AutoCAD's own automatic save leaves DBMOD set.
3. **Civil Settings-window rows not built.** Civil has no Settings boxes for the reminder minutes, copy minutes or copies to keep, and no Bug841-style number check for them. The Structural rows exist in XAML but Codex has not looked at them.
4. **The back-off is proven only as a planner rule.** "The failed try counts as the last try" is tested, but the idle hook and timer were not driven.
5. **Same file name in a second AutoCAD window:** the planner ignores the session numbers in the `.sv$` name. A same-named drawing open in another AutoCAD instance could write a matching file after the first change, and the "two open drawings share the name" check sees only this session.
6. **Structural net48 test project not compiled or run by the builder.** Reading found no compile problem. The Structural net48 main build ends with a post-build PowerShell (exit 9009) environment error.
7. **Pre-existing geometry test failures on the Structural base `rel-20261026s`** are not caused by this PR and not fixed by it.
8. **Pruning means different things.** "Unsaved copies to keep 12" is a floor plus retention days in Civil and a cap in Structural: a Tim question.
9. **`PickSvFile`'s `unsavedSinceUtc` is optional in both.** A future caller that leaves it out switches the old-file guard off.
10. **Civil has no "first copy waits the interval" test.** The rule is correct; only the test is missing.

## What I did not check

1. Did not build or run anything; pass counts are the builder's (Civil 43 planner tests; Structural 46 planner, 16 Bug841 number, 8 Bug841 label).
2. Did not look for merge clashes with the CE 01 QSAVE-to-CLEAN work.
3. Did not re-read `TryGetIdleAutoSaveDrawing`, `RedoWindowGuard` or `ListAutomaticSaveFiles`, which are unchanged by these commits.

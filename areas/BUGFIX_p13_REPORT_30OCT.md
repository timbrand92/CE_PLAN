# BUGFIX p13 report, 30 Oct 2026: BUG-1184 (bearer and stump marks)

## FOR TIM

1. **Draft PR #1895 is open.** Built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1184 is not marked fixed.
2. **What you will see:** tag three bearers in three separate CSTAGBEARERS runs, sizes 150x50 F17, 200x75 F17, 150x50 F17. You now get BR1, BR2, BR1. Before, all three said BR1. Stumps and piers (SPR) do the same. It also holds after save and reopen.
3. **Why it happened:** the command wrote its label on layer 25TEXT but looked for earlier labels on the bearer layer. It never saw any, so every run started again at 1.
4. **Warn and carry on:** if a drawing already has one mark on two sizes (made by the old fault), CE prints a warning line naming the mark and both sizes, then carries on. It never stops.
5. **Switch:** `TimberSubfloor.MarksReadTextLayer`, ON by default, settings file only (no Settings page row). OFF gives the old behaviour exactly.
6. **My mistakes and surprises, first:**
   1. **Wrong base in the task.** The task said start from `rel-20261102a`. That line does not contain `TimberSubfloorService.cs` at all (830 Structural files there against 1,403 on the Structural line). I rebuilt on `claude/rel-20261026s` (Structural 1.0.125, the newest line that has the file) and the PR is against that. CE 01 may want to move it.
   2. **A real settings file changed during my run.** `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` read 21:55:44 on 30 Oct, 15,357 bytes before my first test, and 4 Oct 08:22:30, 15,270 bytes after my last. It went backwards in time, so something copied an older file over it. My tests are Structural only, with the Structural settings folder redirected to scratch, and nothing in them names CD_Settings. I cannot prove from here which job did it. Please check it before trusting your Civil settings. I did not touch it. The other three settings files (CE_STRUC_SUITE CS_Settings, CE_CVL_SUITE settings.json, TIM_CE_CADTOOLS CS_Settings) did not change.
   3. I lost about 40 minutes to a path and quoting problem in my own run script (dotnet not on PATH, a space in the AutoCAD 2027 path). No effect on the result.
7. **NOT proven:** nothing was run in AutoCAD. The real drawing scan (text on 25TEXT in model space) is not covered by a unit test, because a real Database aborts the test host. The tests check the rules the scan uses and the mark engine end to end on a fake drawing. The full Structural suite was not run (the test-isolation rule forbids it).
8. **Robot case to prove it: `C13_bearer_marks`** (copy of a blank mm drawing, World UCS, layers unlocked).
   1. Draw three lines. Type `CSTAGBEARERS`, pick line 1, Enter, `150x50 F17`, `No`, `Yes`. Repeat for line 2 with `200x75 F17`, and line 3 with `150x50 F17`.
   2. Read the three DBText strings on 25TEXT. Expected: `BR1 150x50 F17`, `BR2 200x75 F17`, `BR1 150x50 F17`. Also read the command-line text: no "Warning" line.
   3. Save, reopen, tag a fourth line `200x75 F17`: expected `BR2 200x75 F17`.
   4. **Switch-off control `C13_bearer_marks_off`:** before launch set `TimberSubfloor.MarksReadTextLayer` to false in the Structural settings (CE reads settings at start). Same steps; the second label reads `BR1 200x75 F17` (the old fault).

---

## Technical detail

1. **Cause, with lines (on `rel-20261026s`):** `Modules/Structural/Services/TimberSubfloorService.cs` `ScanExistingMembers` kept only entities whose layer equalled the member layer (`BEARERS - SUBFLOOR` or `STUMPS AND PIERS`). `DrawBearerLabel` and `DrawStumpPier` put the label text on `TextLayer = "25TEXT"`. `MemberMarkEngine.AssignNew` is correct and unchanged.
2. **Change:** new `Modules/Structural/Core/Subfloor/SubfloorMarkScanRules.cs` (`LayersToScan`, `TryParseLabel`, `ConflictWarnings`); `ScanExistingMembers` uses them; `PreviewMarks` calls `WarnAboutSharedMarks`. `Models/UserSettings.cs` `TimberSubfloorSettings.MarksReadTextLayer` (default true, "Default: on."); label line in `SettingsService.LoadRecovery.cs`; REGRESSION_LOG entry.
3. **Known limit:** any other `BR<n> <text>` on 25TEXT (for example a roof beam mark `BR1 ...` from the Excel import prefixes) counts as a bearer label, which only makes marks more cautious (a higher number), never reuses one.
4. **Tests:** `Structural.Tests/Core/Subfloor/SubfloorMarkScanRulesTests.cs` (14 cases). Focused net10 run with filter `SubfloorMarkScanRulesTests|TimberSubfloor|SettingsLoadRobustness`: 62 passed, 0 failed (count not 0). Default-ON pinned through `DeserializeSettingsTolerant` on a blank file, an old file without the key and a damaged file. A typed OFF stays OFF.
5. **net48 compile:** `CE_STRUC_SUITE.dll` built to `bin\Standalone\Release\net48`; the build then failed only on the post-build `powershell` step (not on PATH for this tool), exit 9009, not a compile error.
6. **Settings listings (names, times, sizes):**
   1. Before: CE_STRUC_SUITE `CS_Settings.json` 2026-10-30 19:54:14, 35,613. CE_CVL_SUITE `settings.json` 2026-09-16 12:13:17, 672. CE_SUITE missing. TIM_CE_CADTOOLS `CD_Settings.json` 2026-10-30 21:55:44, 15,357; `CS_Settings.json` 2026-03-31 13:18:00, 351,713.
   2. After: identical except `CD_Settings.json` 2026-10-04 08:22:30, 15,270 (see FOR TIM item 6.2).
7. **Branch and PR:** `claude/p13-bug1184-bearer-marks`, commit d09b4935, draft PR #1895 against `claude/rel-20261026s`. Build register entry: B-073 (job text names p13 / B-073); title is "BUG-1184 ..." and CE 01 may rename it.
8. **Not edited:** BUG_CARPARK.md (CE 05 records the cause and PR above), DESK_LOG.md, the other Structural jobs' files.

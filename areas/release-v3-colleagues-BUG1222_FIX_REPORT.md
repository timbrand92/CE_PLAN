# BUG-1222 fix report: Edit Pipe arrow flips back on a second Save (Wed 28 Oct 2026, about 19:05 Melbourne)

## ANSWER FIRST

**FOR TIM**

1. **The fault is found and a fix is built.** Draft PR **#1832** on the newest Civil line (3.0.84). Nothing installed, nothing merged.
2. **What went wrong, in drawing terms:** when Edit Pipe opens, it checks whether you deliberately turned the flow arrow round. It made that check too early, while the two levels were still in "upstream first" order, not in the order of the pipe's two drawn ends. On a pipe whose levels you had turned round, the arrow looked "deliberately reversed" to CE. The next Save then reversed it again, so it pointed uphill.
3. **What changes for a drafter:** turn a pipe's levels round in Edit Pipe and Save: the arrow turns, as now. Save again, or change only the size: **the arrow now stays pointing from the higher IL to the lower IL.** Before, it turned back uphill against its own IL texts. Arrows you reversed on purpose stay reversed.
4. **One thing it does not repair by itself:** a pipe that already got the wrong arrow from this fault still has its arrow uphill. Fix it once in Edit Pipe (untick the reverse-arrow choice) and Save.
5. **The switch:** `pipe.editPipeReverseArrowReadsDrawnEnds`. It ships ON. Set it to false in the settings file to get the old behaviour back.
6. **My own mistakes:** two small ones, about 10 minutes of machine time. My first test run stopped because the build tool was not on my script's path. My first focused test run then had one red test: my own check banned a word that the unchanged code legitimately contains. I made the check stricter and re-ran it.
7. **Which robot cases prove it:** **R32** (a second plain Save, nothing typed) and **R32b** (a Save that changes only the diameter). Both fail today on 3.0.84 because of BUG-1222. Once this fix is installed, both should pass. Their broken twins R32_BROKEN and R32b_BROKEN must still fail.
8. **Status:** built and unit-tested only. Nobody has opened it in AutoCAD. BUG-1222 stays OPEN.

---

## Detail

1. **Start point:** `claude/rel-20261026y` at `94f521cc75811785800faf436d7c259c26337569` ("Version: Civil 3.0.84 / Manager 1.1.84 (C-74)"), read with `git ls-remote origin` at 18:41. The remote is named `origin` in the main checkout, not `github`.
2. **Evidence read:** BUG-1222 in `BUG_CARPARK.md`; `release-v3-colleagues-ROBOT_REMAINING_ASKS_28OCT.md` items 12 and 13; `release-v3-colleagues-OPUS_CASE_REVIEW_B6_28OCT.md` real-fault item 1; case files `R32_edit_pipe_reverse_levels_arrow_follows.case.txt` and `R32b_edit_pipe_size_only_keeps_arrow.case.txt`; run report RUN-20261028-1353-C3.0.84-b6b3 (R32b arrow A rotation 0.0 at 160000,-90200). CE's own log of that run (`CE_CVL_SUITE.log.1`, 13:55 to 13:58) has diagnostics off, so it has no direction trace. The cause below comes from reading the code. No log line confirms it.
3. **Cause (confident):** `Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs` lines 436 to 437 at C-74. In `AnalyzeAttachmentState`, `TryResolveReverseArrowFromAttachment` ran from line 176 of `TryCollectPipeData`. At that moment `context.FirstInvert/SecondInvert` were filled from the record's `FromInvert/ToInvert` (lines 107 to 108) for a polyline pipe with no levels in XData. The R32 pipe is that kind: its CDEDIT log says "Created multi-vertex MLINE", which is the non-pipe-entity branch. The levels were put on their drawn ends only at lines 193 to 200 (level evidence) and 265 to 273 (`RecordLevelFillRule.Orient`). After the first Save the record reads From 18.000 / To 17.900, so `TryGetExpectedForwardFlow` (line 701) answered "forward" while the arrow pointed back. The result was `ReverseArrow = true` and `vm.ReverseArrow = true` (`PipeEditCommand.Update.cs` line 72).
4. **Second suspect, the place where the false tick acts:** `PipeEditCommand.Attachments.cs` lines 84 to 87. `ArrowTurnForSave` correctly works out "flows from the second end" (pi) and then applies `reverseArrow`, giving 0. The Save also writes the tick to the record (`PipeEditCommand.Update.cs` line 1836). This code is right in itself; it was handed a wrong tick.
5. **Fix:** a new switch `PipeSettings.EditPipeReverseArrowReadsDrawnEnds` (`pipe.editPipeReverseArrowReadsDrawnEnds`, default true, declared and documented like `linking.reopenedDrawingLoadsItsOwnRecord` of #1830) and a new `Rules/EditPipeReverseArrowReadRule.cs` (`IsOn`, `ArrowIsReversed`). With the switch ON, the early reading is skipped and the same reading runs straight after `RecordLevelFillRule.Orient`, before the read transaction commits. With it OFF, the old early reading runs. The AutoCAD-free half is split out as `TryReadReverseArrow`, with its logic unchanged. The change is read only: the arrow is opened ForRead, and there is no write, command, regen, view or system variable, so it is REDO-safe. No locked-layer, Xref or REFEDIT path is touched. CE_SHARED, Structural and Manager are unchanged.
6. **Tests:** new `Modules/Drainage.Tests/Commands/Bug1222EditPipeArrowReadTests.cs`, 14 tests, 14 passed:
   1. The robot's pipe A read with record-order levels gives the false tick, and the second Save's turn is then rotation 0. This reproduces the fault without AutoCAD.
   2. The same pipe read with drawn-end levels gives no tick, and the turn stays pi.
   3. The other cases checked: R32's zero-level pipe, the never-turned control pipe, a deliberate reverse (still read as reversed) and the rule table.
   4. The switch loads ON through both start-up reads for an empty file and for a pipe group without the key. Typed false turns off only itself; typed true reads true.
   5. Source guards: the switch-on reading sits after the boxes are final and inside the same pass; the early reading runs only with the switch off; neither path writes.
7. **Build and test evidence:** private worktree `C:\ce-fx\b1222`; scratch `C:\ce-fx\j1222`; Release; every command ran with `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the C-62 AutoCAD refs, the `build.lock` taken, and dotnet at Below Normal. Results:
   1. Focused run (Bug1222, Bug260ArrowTurn, PipeEditCommandDataCollection, C74NewSwitchDefaults, C5RefreshDirection): 80 tests, 79 passed and 1 failed (my own guard, see FOR TIM item 6), then fixed.
   2. **Civil net10 full suite, 18:51 to 19:00: 20,734 total, 20,702 passed, 0 failed, 32 skipped.** The PDF page test did not fail, so no re-run was needed.
   3. **Civil net48 compile: 0 errors** (242 warnings).
   4. Never deployed. AutoCAD (acad.exe, not started by me) was running throughout. Tim's settings files and the installed bundle were not touched.
8. **Commit and PR:** `76171d1e` on `fb/bug1222-edit-pipe-arrow`; draft PR **#1832** against `claude/rel-20261026y`. REGRESSION_LOG.md entry added at the top; both sides kept.
9. **Not tested or not known:**
   1. Nothing has been driven in AutoCAD.
   2. I did not check the window label of the reverse-arrow tick.
   3. A pipe already saved with the false tick keeps its uphill arrow until the drafter unticks it once.
   4. A pipe whose boxes can only be filled from the record, with pit names that prove nothing, still reads in record order, as before.
   5. Edit 2+ pipes reads each pipe through the same `TryCollectPipeData`, so it gets the same fix, but no test drives it.
10. **For the robot after install:**
    1. Run R32 and R32b in two separate sessions on the installed build. Right result: after the second Save the arrow rotation reads about 3.14 in both.
    2. R32_BROKEN and R32b_BROKEN must still FAIL.
    3. Retag both cases off EXPECT-FAIL only after two passing sessions.
    4. Under the 24 Oct acceptance amendment, R32 and R32b's own 3.0.84 FAIL rows serve as the earlier-build red.

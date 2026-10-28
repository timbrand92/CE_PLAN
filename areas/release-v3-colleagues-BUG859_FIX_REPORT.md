# BUG-859 fix report: double-click on a downpipe opens AutoCAD's attribute editor instead of CE's Edit source (Thu 29 Oct 2026, about 10:15 Melbourne)

## ANSWER FIRST

**FOR TIM**

1. **A fix is built.** Draft PR **#1834** on the newest Civil line (3.0.85). Nothing installed, nothing merged.
2. **What went wrong, in drawing terms:** CE did notice your double-click on DP1 and asked AutoCAD to cancel its own editor. But AutoCAD only reads that cancel after its editor window is closed. So you saw AutoCAD's "Enhanced Attribute Editor" first, every time.
3. **What changes for a drafter:** double-click the circle of a downpipe. AutoCAD's attribute editor no longer opens. CE's small "Edit source" window opens straight away, showing DP1.
4. **What stays the same:** a pit, a pit label or a plain block still opens AutoCAD's own editor. A downpipe on a locked layer, an Xref downpipe, and anything while you are in REFEDIT also keep AutoCAD's own answer.
5. **The switch:** `doubleClick.sourceStopsAttributeEditorFirst`. It ships ON. Set it to false in the settings file to get the old behaviour back.
6. **My own mistakes:** two small ones, about 8 minutes of machine time. My first focused test run caught all 20,835 tests because my filter word "Settings" matched every test. Two of them went red because of where I had put the new code in the file. I moved it and both passed.
7. **One honest doubt:** this uses a different AutoCAD hook from the three earlier attempts. The code and AutoCAD's own logs say it should stop the editor first. Only the robot in real AutoCAD can prove it.
8. **Which robot cases prove it:** **R09** should turn from FAIL to pass in two sessions. Its broken twin **R09_OFF_BROKEN** must still fail.
9. **Status:** built and unit-tested only. Nobody has opened it in AutoCAD. BUG-859 stays OPEN.

---

## Detail

1. **Start point:** `claude/rel-20261026z` at `09126560f98acc4fd6ca4be298d087307a89a259` ("Version: Civil 3.0.85 / Manager 1.1.85 (C-75)"), read with `git ls-remote origin` at 09:17.
2. **Evidence read:** BUG-859 in `BUG_CARPARK.md` (Codex V4, V5, V10; runner 25 Oct); case `R09_dp1_double_click_edit_source.case.txt` and its review; run reports RUN-20261028-1744-C3.0.84-aR09 and RUN-20261028-2234-C3.0.84-bR09 (both FAIL, the double-click opened "Enhanced Attribute Editor"); CE's structured log for bR09 (`ce_cvl_structured_20261028.log`, 22:39:58 to 22:40:43), read only: hit-test found DP1, pick set emptied, "CANCELCMD posted=true for EATTEDIT", "target registered; CDEDIT scheduled at Idle" at 22:39:58, then "starting CDEDIT in command context" only at 22:40:27, after the robot had closed AutoCAD's editor.
3. **Cause (confident):** `Modules/Drainage/Services/CompoundEditModeService.cs` at C-75, `OnCommandWillStart` (line 199) -> `TryRedirectToCdEdit` (line 270) -> `StopNativeEditor` (line 789) -> `TryCancelStartingCommand` (line 878, `acedPostCommand("CANCELCMD")`). The command-start notice comes after AutoCAD has already decided to run EATTEDIT with the double-clicked block handed over inside the command, so its window opens at once. The posted cancel waits in the command queue until that window closes. Rounds 1 to 3 (empty pick set, find the block by position) could not change that order.
4. **Second suspect (not acted on):** the Idle hop (`ScheduleCdEditAtIdle`, line 827). It explains why CE's window came late, not why AutoCAD's came first.
5. **Fix:** a new handler `OnDocumentLockModeChanged`, hooked in `Initialize` and unhooked in `Shutdown`. Evidence for the order: CE's own REDO-DIAG lines of 28 Oct show the document-lock notice for a command (for example 'REDO', 'LINE') 4 to 6 ms before the command-start notice. The AutoCAD 2027 wrapper (decompiled, `CDocCollReactorImpl.FireDocumentLockModeChanged`) passes a managed `Veto()` to the native doc-manager reactor's veto. Steps:
   1. The handler looks only at the start notice of EATTEDIT (not '#EATTEDIT', not any other command).
   2. It needs the new switch ON, `doubleClick.sourceEditWindow` ON, a double-click within 1.5 s and its position.
   3. It runs the existing round-2 hit-test (which never returns an Xref block).
   4. It reads the block (tagged source?) and its layer (locked?) through an open-close transaction, and REFEDITNAME.
   5. Only for a tagged source, off locked layers, with no REFEDIT open: it registers the block for CDEDIT, uses up the double-click note, calls `e.Veto()`, and schedules CDEDIT at Idle (the existing path, the same "target registered; CDEDIT scheduled at Idle" line R09 checks).
   6. Anything else returns with the note intact, so the old command-start path decides it exactly as before.
6. **Switch:** `DoubleClickSettings.SourceStopsAttributeEditorFirst` (`doubleClick.sourceStopsAttributeEditorFirst`, default true, one default constant), declared and documented like `linking.reopenedDrawingLoadsItsOwnRecord` of #1830 (doc line ends "Default: on."). New `Rules/DoubleClickAttributeEditorStopRule.cs` (`IsOn`, `IsAttributeEditorStarting`, `ShouldLook`, `ShouldStop`, `IsEditingInPlace`, `StoppedLogLine`). No Settings page row (like the C-62 to C-75 switches).
7. **REDO and protection:** read only: no write, selection change, command, regen, view or system variable change in the handler (a source test pins this). CDEDIT is started by the same existing Idle path as before. Locked layer, Xref and REFEDIT keep AutoCAD's own answer. CE_SHARED, Structural and Manager unchanged.
8. **Tests:** new `Modules/Drainage.Tests/Services/Bug859AttributeEditorStoppedFirstTests.cs`, 29 tests, 29 passed on net10 and on net48:
   1. The switch loads ON through both start-up reads for an empty file, an empty doubleClick group and a group with only the older keys. Typed false turns off only itself. An unreadable group reads ON.
   2. Only the plain EATTEDIT start notice is looked at. The look needs all four conditions (16 combinations). Only a tagged source off locked layers and outside REFEDIT is stopped.
   3. Source guards: name test first, switches before the hit-test, block checks before the decision, note used up before the refusal, one refusal, nothing written, everything caught, R09's log line still written.
   4. The fault without AutoCAD: the old path still cancels from the command-start notice. This test pins the shape R09 caught. The window order itself cannot be reproduced without AutoCAD.
9. **Build and test evidence:** private worktree `C:\ce-fx\b859`; scratch `C:\ce-fx\j859`; Release; every command with `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the C-62 AutoCAD refs, the `build.lock` taken, dotnet set to Below Normal at start (children inherit). Results:
   1. Focused run (Bug859, DoubleClick, CompoundEditMode, RedoSafe, C75NewSwitch, TextEditRedirect, Bug558, Bug224, AuditPhase23, C60AuditSourcePin, RedoWindowGuard, GroupGBug, UserSettings, OvernightLabel): 414 total, 411 passed, 3 skipped, 0 failed.
   2. **Civil net10 full suite: 20,835 total, 20,803 passed, 32 skipped, 0 failed.** The PDF page test did not fail.
   3. **Civil net48 compile (tests project, with the plugin): 0 errors** (293 warnings).
   4. My mistake (FOR TIM item 6): the first run's filter matched the whole suite; `OvernightLabelDoubleClickAndCopyTests.ProductionTextRoute_UsesCacheBeforeAnyCommandStartTransaction` (it looks for the first transaction in the file) and `RedoSafeCallGraphTests` (the async helper's compiler name moved from d__40 to d__41) went red because the handler sat high in the file. Moved below `TryCancelStartingCommand`; both pass, the REDO baseline is unchanged.
   5. Never deployed. AutoCAD was not started or touched. Tim's settings files and the installed bundle were not touched.
10. **Commit and PR:** `9b2da5c3` on `fb/bug859-double-click-edit-source`; draft PR **#1834** against `claude/rel-20261026z`. REGRESSION_LOG.md entry added at the top.
11. **Not tested or not known (RULES 5.9):**
    1. Nothing driven in AutoCAD. That AutoCAD honours the refusal for an EATTEDIT started by a double-click is the one thing only R09 can prove. If it does not, the old path still runs (the note is used up, so CDEDIT is still scheduled at Idle as today).
    2. The red centre and the angled DP text use the same hit-test (the whole block outline), so they should behave the same; not driven. The green DP label is BUG-860 and is not changed.
    3. Whether a double-click on a downpipe on a locked layer starts EATTEDIT at all in AutoCAD is not known; this fix leaves that case alone.
    4. The Edit source window's Tag box name is still unproven (R09's own note).
12. **For the robot after install:** run R09 alone in two separate sessions (it moves the real mouse, outside Tim's hours). Right result: the window list after the double-click reads "Edit source" with DP1, no "Enhanced Attribute Editor"; the structured log holds "EATTEDIT stopped before AutoCAD's attribute editor opened". R09_OFF_BROKEN must still fail. Retag R09 off EXPECT-FAIL only after two passing sessions.
